import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pferdekalender/core/db/app_database.dart';
import 'package:pferdekalender/core/time/local_date.dart';
import 'package:pferdekalender/features/dienstplan/domain/shift_logic.dart';
import 'package:pferdekalender/features/pferd/data/horse_repository.dart';
import 'package:pferdekalender/features/pferd/data/photo_storage.dart';
import 'package:pferdekalender/features/pferd/domain/horse.dart';
import 'package:pferdekalender/features/training/data/training_repository.dart';
import 'package:pferdekalender/features/training/domain/training.dart';

import 'training_generator_test.dart' show generator, allForms, start;

void main() {
  late AppDatabase db;
  late TrainingRepository repo;
  late HorseRepository horses;
  late String horseId;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repo = TrainingRepository(db);
    horses = HorseRepository(
      db,
      PhotoStorage(() async => Directory.systemTemp),
    );
    horseId = await horses.createHorse(const Horse(id: '', name: 'Amigo'));
  });
  tearDown(() => db.close());

  final params = TrainingParams(
    goal: TrainingGoal.muskelaufbau,
    fitness: 3,
    daysPerWeek: 4,
    weeks: 4,
    startDate: start,
    forms: allForms,
  );
  const noShifts = <LocalDate, DayAvailability>{};

  Future<String> createPlan({LocalDate? today}) => repo.savePlan(
    horseId: horseId,
    params: params,
    sessions: generator
        .generate(params: params, availability: noShifts)
        .sessions,
    today: today ?? start,
  );

  test(
    'Plan übernehmen speichert Einheiten mit Inhalt und Begründung',
    () async {
      final planId = await createPlan();
      final sessions = await repo.getSessions(horseId);
      expect(sessions, isNotEmpty);
      expect(sessions.every((s) => s.planId == planId), isTrue);
      final s = sessions.first;
      expect(s.content.work, isNotEmpty);
      expect(s.reason, isNotNull);
      expect(s.reason!.assumedMinutes, isTrue);
      expect(s.pinned, isFalse);
      final plan = await repo.watchActivePlan(horseId).first;
      expect(plan!.params.goal, TrainingGoal.muskelaufbau);
      expect(plan.distributedAt, isNotNull);
    },
  );

  test('Verschieben fixiert, Kopieren legt fixierte Kopie an', () async {
    await createPlan();
    final s = (await repo.getSessions(horseId)).first;
    await repo.moveSession(s.id, s.date.addDays(1));
    final moved = (await repo.getSession(s.id))!;
    expect(moved.pinned, isTrue);
    expect(moved.date, s.date.addDays(1));

    final copyId = await repo.copySession(s.id, s.date.addDays(20));
    final copy = (await repo.getSession(copyId))!;
    expect(copy.planId, isNull);
    expect(copy.status, SessionStatus.planned);
    expect(copy.title, s.title);
  });

  test(
    'Neu verteilen: nur künftige, offene, nicht fixierte Einheiten',
    () async {
      await createPlan();
      final plan = (await repo.watchActivePlan(horseId).first)!;
      final before = await repo.getSessions(horseId);
      final today = start.addDays(7);

      final past = before.firstWhere((s) => s.date.isBefore(today));
      await repo.saveSession(
        past.copyWith(status: SessionStatus.done, rating: 4),
      );
      final future = before.where((s) => !s.date.isBefore(today)).toList();
      final pinned = future.first;
      await repo.moveSession(pinned.id, pinned.date);

      await repo.redistribute(
        plan: plan,
        generator: generator,
        availability: noShifts,
        today: today,
      );
      final after = await repo.getSessions(horseId);
      expect(
        after.any((s) => s.id == past.id && s.status == SessionStatus.done),
        isTrue,
      );
      expect(after.any((s) => s.id == pinned.id), isTrue);
      // Alte, nicht fixierte künftige Einheiten wurden ersetzt.
      final removed = future.skip(1).map((s) => s.id).toSet();
      expect(after.any((s) => removed.contains(s.id)), isFalse);
      expect(
        after.where((s) => !s.date.isBefore(today)).length,
        greaterThan(1),
      );
      // Kein zweites Training am fixierten Tag.
      expect(after.where((s) => s.date == pinned.date), hasLength(1));
    },
  );

  test('Neuer Plan ersetzt alten, erledigte Einheiten bleiben', () async {
    await createPlan();
    final first = await repo.getSessions(horseId);
    final done = first.first;
    await repo.saveSession(done.copyWith(status: SessionStatus.done));

    await createPlan(today: start);
    final plans = await db.select(db.trainingPlans).get();
    expect(plans.where((p) => p.status == 'active'), hasLength(1));
    expect(plans.where((p) => p.status == 'archived'), hasLength(1));
    final sessions = await repo.getSessions(horseId);
    expect(sessions.any((s) => s.id == done.id), isTrue);
  });

  test('Plan beenden entfernt künftige offene Einheiten', () async {
    final planId = await createPlan();
    await repo.endPlan(planId, start.addDays(14));
    final sessions = await repo.getSessions(horseId);
    expect(sessions.every((s) => s.date.isBefore(start.addDays(14))), isTrue);
    expect(await repo.watchActivePlan(horseId).first, isNull);
  });

  test('Pferd löschen entfernt Pläne und Einheiten', () async {
    await createPlan();
    await horses.deleteHorsePermanently(horseId);
    expect(await db.select(db.trainingSessions).get(), isEmpty);
    expect(await db.select(db.trainingPlans).get(), isEmpty);
  });
}
