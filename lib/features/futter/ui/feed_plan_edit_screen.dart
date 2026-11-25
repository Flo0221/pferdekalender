import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/format/formatters.dart';
import '../../../core/time/local_date.dart';
import '../../../core/widgets/date_field.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../pferd/ui/horse_providers.dart';
import '../domain/feed.dart';
import 'feed_items_screen.dart';
import 'feed_labels.dart';
import 'feed_providers.dart';

class _EntryDraft {
  _EntryDraft({this.itemId, double? amount, this.variant = FeedVariant.always})
    : amount = TextEditingController(
        text: amount == null ? '' : Fmt.decimal(amount),
      );
  String? itemId;
  final TextEditingController amount;
  FeedVariant variant;
}

class _MealDraft {
  _MealDraft({String name = '', this.time, List<_EntryDraft>? entries})
    : name = TextEditingController(text: name),
      entries = entries ?? [];
  final TextEditingController name;
  int? time;
  final List<_EntryDraft> entries;
}

/// Planversion anlegen ([planId] == null → neue erste Version) oder bearbeiten.
class FeedPlanEditScreen extends ConsumerStatefulWidget {
  const FeedPlanEditScreen({super.key, this.planId});

  final String? planId;

  @override
  ConsumerState<FeedPlanEditScreen> createState() => _FeedPlanEditScreenState();
}

class _FeedPlanEditScreenState extends ConsumerState<FeedPlanEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _notes = TextEditingController();
  LocalDate _validFrom = LocalDate.today();
  final _meals = <_MealDraft>[];
  FeedPlan? _original;
  bool _loaded = false;

  @override
  void dispose() {
    _name.dispose();
    _notes.dispose();
    for (final m in _meals) {
      m.name.dispose();
      for (final e in m.entries) {
        e.amount.dispose();
      }
    }
    super.dispose();
  }

  void _loadOnce(List<FeedPlan> plans, AppLocalizations l10n) {
    if (_loaded) return;
    _loaded = true;
    final p = plans.where((p) => p.id == widget.planId).firstOrNull;
    if (p == null) {
      _name.text = l10n.feedDefaultPlanName;
      _meals
        ..add(_MealDraft(name: l10n.feedDefaultMealMorning, time: 7 * 60))
        ..add(_MealDraft(name: l10n.feedDefaultMealEvening, time: 18 * 60));
      return;
    }
    _original = p;
    _name.text = p.name;
    _notes.text = p.notes ?? '';
    _validFrom = p.validFrom;
    for (final m in p.meals) {
      _meals.add(
        _MealDraft(
          name: m.name,
          time: m.timeMinutes,
          entries: [
            for (final e in m.entries)
              _EntryDraft(
                itemId: e.itemId,
                amount: e.amount,
                variant: e.variant,
              ),
          ],
        ),
      );
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final horse = ref.read(selectedHorseProvider).value;
    final horseId = _original?.horseId ?? horse?.id;
    if (horseId == null) return;
    final plan = FeedPlan(
      id: _original?.id ?? '',
      horseId: horseId,
      name: _name.text,
      validFrom: _validFrom,
      notes: _notes.text,
      meals: [
        for (final (i, m) in _meals.indexed)
          Meal(
            id: '',
            name: m.name.text,
            timeMinutes: m.time,
            sortOrder: i,
            entries: [
              for (final e in m.entries)
                if (e.itemId != null && Fmt.parseDecimal(e.amount.text) != null)
                  MealEntry(
                    id: '',
                    itemId: e.itemId!,
                    amount: Fmt.parseDecimal(e.amount.text)!,
                    variant: e.variant,
                  ),
            ],
          ),
      ],
    );
    await ref.read(feedRepositoryProvider).savePlan(plan);
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final plans = ref.watch(selectedHorseFeedPlansProvider).value;
    final items = ref.watch(feedItemsProvider).value ?? const <FeedItem>[];
    final itemMap = ref.watch(feedItemMapProvider).value ?? const {};
    if (plans == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    _loadOnce(plans, l10n);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.feedPlanEditTitle),
        actions: [TextButton(onPressed: _save, child: Text(l10n.actionSave))],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          children: [
            TextFormField(
              controller: _name,
              decoration: InputDecoration(
                labelText: '${l10n.feedPlanName} *',
                hintText: l10n.feedPlanNameHint,
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? l10n.fieldRequired : null,
            ),
            const SizedBox(height: 12),
            DateField(
              label: l10n.feedPlanValidFrom,
              value: _validFrom,
              clearable: false,
              lastDate: LocalDate.today().addYears(2),
              onChanged: (d) => setState(() => _validFrom = d ?? _validFrom),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _notes,
              minLines: 1,
              maxLines: 4,
              decoration: InputDecoration(labelText: l10n.feedPlanNotes),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 4),
              child: Text(
                l10n.feedDisclaimer,
                style: theme.textTheme.bodySmall,
              ),
            ),
            if (items.isEmpty)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: Text(l10n.feedNeedItems),
                  trailing: TextButton(
                    onPressed: () => editFeedItem(context, ref, null),
                    child: Text(l10n.feedItemNew),
                  ),
                ),
              ),
            for (final (mi, m) in _meals.indexed)
              Card(
                margin: const EdgeInsets.only(top: 12),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 4, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: m.name,
                              decoration: InputDecoration(
                                labelText: l10n.feedMealName,
                              ),
                              validator: (v) => (v == null || v.trim().isEmpty)
                                  ? l10n.fieldRequired
                                  : null,
                            ),
                          ),
                          TextButton.icon(
                            icon: const Icon(Icons.schedule),
                            label: Text(
                              m.time == null
                                  ? l10n.feedMealTime
                                  : Fmt.time(m.time!),
                            ),
                            onPressed: () async {
                              final t = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(
                                  hour: (m.time ?? 420) ~/ 60,
                                  minute: (m.time ?? 420) % 60,
                                ),
                              );
                              if (t != null) {
                                setState(() => m.time = t.hour * 60 + t.minute);
                              }
                            },
                          ),
                          IconButton(
                            tooltip: l10n.feedMealRemove,
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () =>
                                setState(() => _meals.removeAt(mi)),
                          ),
                        ],
                      ),
                      for (final (ei, e) in m.entries.indexed)
                        _entryRow(l10n, m, ei, e, items, itemMap),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton.icon(
                          icon: const Icon(Icons.add),
                          label: Text(l10n.feedEntryAdd),
                          onPressed: items.isEmpty
                              ? null
                              : () => setState(
                                  () => m.entries.add(
                                    _EntryDraft(itemId: items.first.id),
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              icon: const Icon(Icons.add),
              label: Text(l10n.feedMealAdd),
              onPressed: () => setState(() => _meals.add(_MealDraft())),
            ),
          ],
        ),
      ),
    );
  }

  Widget _entryRow(
    AppLocalizations l10n,
    _MealDraft m,
    int index,
    _EntryDraft e,
    List<FeedItem> items,
    Map<String, FeedItem> itemMap,
  ) {
    final options = [
      ...items,
      if (e.itemId != null &&
          !items.any((i) => i.id == e.itemId) &&
          itemMap[e.itemId] != null)
        itemMap[e.itemId]!,
    ];
    final item = itemMap[e.itemId];
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: DropdownButtonFormField<String>(
                  initialValue: e.itemId,
                  isExpanded: true,
                  decoration: InputDecoration(labelText: l10n.feedEntryItem),
                  items: [
                    for (final i in options)
                      DropdownMenuItem(value: i.id, child: Text(i.name)),
                  ],
                  onChanged: (v) => setState(() => e.itemId = v),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: TextFormField(
                  controller: e.amount,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    labelText: l10n.feedEntryAmount,
                    suffixText: item == null ? null : unitName(l10n, item.unit),
                  ),
                  validator: (v) {
                    final n = Fmt.parseDecimal(v ?? '');
                    return (n == null || n <= 0)
                        ? l10n.fieldInvalidNumber
                        : null;
                  },
                ),
              ),
              IconButton(
                tooltip: l10n.feedEntryRemove,
                icon: const Icon(Icons.close),
                onPressed: () => setState(() => m.entries.removeAt(index)),
              ),
            ],
          ),
          Wrap(
            spacing: 6,
            children: [
              for (final v in FeedVariant.values)
                ChoiceChip(
                  label: Text(variantName(l10n, v)),
                  selected: e.variant == v,
                  onSelected: (_) => setState(() => e.variant = v),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
