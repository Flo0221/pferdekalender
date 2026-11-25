import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/db/app_database.dart';
import '../../../core/time/local_date.dart';
import '../domain/feed.dart';
import '../domain/feed_logic.dart';

/// Futtermittel, Futterpläne (Versionen) und zeitlich begrenzte Zusätze.
class FeedRepository {
  FeedRepository(this._db, {Uuid? uuid, DateTime Function()? clock})
    : _uuid = uuid ?? const Uuid(),
      _clock = clock ?? DateTime.now;

  final AppDatabase _db;
  final Uuid _uuid;
  final DateTime Function() _clock;

  String newId() => _uuid.v4();

  // ---------------------------------------------------------------- Futtermittel

  Stream<List<FeedItem>> watchItems({bool includeArchived = false}) {
    final q = _db.select(_db.feedItems)
      ..orderBy([
        (i) => OrderingTerm(expression: i.category),
        (i) => OrderingTerm(expression: i.name.collate(Collate.noCase)),
      ]);
    if (!includeArchived) q.where((i) => i.archived.equals(false));
    return q.watch().map((rows) => rows.map(_toItem).toList());
  }

  Future<List<FeedItem>> getItems() =>
      _db.select(_db.feedItems).get().then((r) => r.map(_toItem).toList());

  /// Neu (leere ID) oder ändern. Gibt die ID zurück.
  Future<String> saveItem(FeedItem item) async {
    final id = item.id.isEmpty ? newId() : item.id;
    await _db
        .into(_db.feedItems)
        .insertOnConflictUpdate(
          FeedItemsCompanion.insert(
            id: id,
            name: item.name.trim(),
            category: item.category.key,
            unit: item.unit.key,
            notes: Value(_clean(item.notes)),
            stock: Value(item.stock),
            lowStockThreshold: Value(item.lowStockThreshold),
            archived: Value(item.archived),
            updatedAt: Value(_clock()),
          ),
        );
    return id;
  }

  /// Findet ein (nicht archiviertes) Futtermittel mit gleichem Namen oder legt
  /// es an – für Vorschläge aus dem Blutbild.
  Future<String> findOrCreateItem(FeedItem item) async {
    final existing =
        await (_db.select(_db.feedItems)..where(
              (i) => i.name.lower().equals(item.name.trim().toLowerCase()),
            ))
            .get();
    if (existing.isNotEmpty) return existing.first.id;
    return saveItem(item);
  }

  /// Wird das Futtermittel noch verwendet, wird es nur archiviert.
  /// Gibt `true` zurück, wenn es gelöscht (nicht nur archiviert) wurde.
  Future<bool> removeItem(String id) => _db.transaction(() async {
    final inMeals = await (_db.select(
      _db.feedMealItems,
    )..where((m) => m.itemId.equals(id))).get();
    final inSupplements = await (_db.select(
      _db.feedSupplementsTemporary,
    )..where((s) => s.itemId.equals(id))).get();
    if (inMeals.isNotEmpty || inSupplements.isNotEmpty) {
      await (_db.update(_db.feedItems)..where((i) => i.id.equals(id))).write(
        FeedItemsCompanion(
          archived: const Value(true),
          updatedAt: Value(_clock()),
        ),
      );
      return false;
    }
    await (_db.delete(_db.feedItems)..where((i) => i.id.equals(id))).go();
    return true;
  });

  Future<void> setStock(String id, double? stock) =>
      (_db.update(_db.feedItems)..where((i) => i.id.equals(id))).write(
        FeedItemsCompanion(stock: Value(stock), updatedAt: Value(_clock())),
      );

  // ---------------------------------------------------------------- Pläne

  /// Alle Planversionen eines Pferdes (neueste zuerst) mit Mahlzeiten.
  Stream<List<FeedPlan>> watchPlans(String horseId) => _db
      .customSelect(
        'SELECT COUNT(*) AS n FROM feed_plans',
        readsFrom: {_db.feedPlans, _db.feedMeals, _db.feedMealItems},
      )
      .watch()
      .asyncMap((_) => getPlans(horseId));

  Future<List<FeedPlan>> getPlans(String horseId) async {
    final plans =
        await (_db.select(_db.feedPlans)
              ..where((p) => p.horseId.equals(horseId))
              ..orderBy([
                (p) => OrderingTerm(
                  expression: p.validFrom,
                  mode: OrderingMode.desc,
                ),
              ]))
            .get();
    if (plans.isEmpty) return const [];
    final ids = plans.map((p) => p.id).toList();
    final meals =
        await (_db.select(_db.feedMeals)
              ..where((m) => m.planId.isIn(ids))
              ..orderBy([(m) => OrderingTerm(expression: m.sortOrder)]))
            .get();
    final mealIds = meals.map((m) => m.id).toList();
    final entries = mealIds.isEmpty
        ? const <FeedMealItemRow>[]
        : await (_db.select(_db.feedMealItems)
                ..where((e) => e.mealId.isIn(mealIds))
                ..orderBy([(e) => OrderingTerm(expression: e.sortOrder)]))
              .get();
    return [
      for (final p in plans)
        FeedPlan(
          id: p.id,
          horseId: p.horseId,
          name: p.name,
          validFrom: p.validFrom,
          notes: p.notes,
          meals: [
            for (final m in meals)
              if (m.planId == p.id)
                Meal(
                  id: m.id,
                  name: m.name,
                  timeMinutes: m.timeMinutes,
                  sortOrder: m.sortOrder,
                  entries: [
                    for (final e in entries)
                      if (e.mealId == m.id)
                        MealEntry(
                          id: e.id,
                          itemId: e.itemId,
                          amount: e.amount,
                          variant: FeedVariant.fromKey(e.variant),
                        ),
                  ],
                ),
          ],
        ),
    ];
  }

  /// Speichert eine Planversion vollständig (Mahlzeiten werden ersetzt).
  Future<String> savePlan(FeedPlan plan) => _db.transaction(() async {
    final id = plan.id.isEmpty ? newId() : plan.id;
    await _db
        .into(_db.feedPlans)
        .insertOnConflictUpdate(
          FeedPlansCompanion.insert(
            id: id,
            horseId: plan.horseId,
            name: plan.name.trim(),
            validFrom: plan.validFrom,
            notes: Value(_clean(plan.notes)),
            updatedAt: Value(_clock()),
          ),
        );
    await (_db.delete(_db.feedMeals)..where((m) => m.planId.equals(id))).go();
    for (final (mi, m) in plan.meals.indexed) {
      final mealId = m.id.isEmpty ? newId() : m.id;
      await _db
          .into(_db.feedMeals)
          .insert(
            FeedMealsCompanion.insert(
              id: mealId,
              planId: id,
              name: m.name.trim(),
              timeMinutes: Value(m.timeMinutes),
              sortOrder: Value(mi),
            ),
          );
      for (final (ei, e) in m.entries.indexed) {
        await _db
            .into(_db.feedMealItems)
            .insert(
              FeedMealItemsCompanion.insert(
                id: e.id.isEmpty ? newId() : e.id,
                mealId: mealId,
                itemId: e.itemId,
                amount: e.amount,
                variant: Value(e.variant.key),
                sortOrder: Value(ei),
              ),
            );
      }
    }
    return id;
  });

  /// Neue Version ab [validFrom] als Kopie von [plan] (Historie bleibt).
  Future<String> createVersion(
    FeedPlan plan,
    LocalDate validFrom, {
    String? name,
  }) => savePlan(copyPlanAsNewVersion(plan, validFrom, newId, name: name));

  Future<void> deletePlan(String id) =>
      (_db.delete(_db.feedPlans)..where((p) => p.id.equals(id))).go();

  // ---------------------------------------------------------------- Zusätze

  Stream<List<TemporarySupplement>> watchSupplements(String horseId) =>
      (_db.select(_db.feedSupplementsTemporary)
            ..where((s) => s.horseId.equals(horseId))
            ..orderBy([
              (s) => OrderingTerm(
                expression: s.startDate,
                mode: OrderingMode.desc,
              ),
            ]))
          .watch()
          .map((rows) => rows.map(_toSupplement).toList());

  Future<String> saveSupplement(TemporarySupplement s) async {
    final id = s.id.isEmpty ? newId() : s.id;
    await _db
        .into(_db.feedSupplementsTemporary)
        .insertOnConflictUpdate(
          FeedSupplementsTemporaryCompanion.insert(
            id: id,
            horseId: s.horseId,
            itemId: s.itemId,
            amount: Value(s.amount),
            mealName: Value(_clean(s.mealName)),
            startDate: s.start,
            endDate: s.end,
            note: Value(_clean(s.note)),
            source: Value(s.source.key),
            bloodTestId: Value(s.bloodTestId),
            updatedAt: Value(_clock()),
          ),
        );
    return id;
  }

  Future<void> deleteSupplement(String id) => (_db.delete(
    _db.feedSupplementsTemporary,
  )..where((s) => s.id.equals(id))).go();

  // ---------------------------------------------------------------- Mapping

  static String? _clean(String? v) {
    final t = v?.trim();
    return (t == null || t.isEmpty) ? null : t;
  }

  FeedItem _toItem(FeedItemRow r) => FeedItem(
    id: r.id,
    name: r.name,
    category: FeedCategory.fromKey(r.category),
    unit: FeedUnit.fromKey(r.unit),
    notes: r.notes,
    stock: r.stock,
    lowStockThreshold: r.lowStockThreshold,
    archived: r.archived,
  );

  TemporarySupplement _toSupplement(FeedSupplementRow r) => TemporarySupplement(
    id: r.id,
    horseId: r.horseId,
    itemId: r.itemId,
    amount: r.amount,
    mealName: r.mealName,
    start: r.startDate,
    end: r.endDate,
    note: r.note,
    source: SupplementSource.fromKey(r.source),
    bloodTestId: r.bloodTestId,
  );
}
