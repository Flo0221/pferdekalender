import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/format/formatters.dart';
import '../../../core/time/local_date.dart';
import '../../../core/widgets/confirm_dialog.dart';
import '../../../core/widgets/date_field.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../pferd/ui/horse_providers.dart';
import '../domain/feed.dart';
import '../domain/feed_logic.dart';
import 'feed_labels.dart';
import 'feed_providers.dart';

/// Zeitlich begrenzte Zusätze (Kuren) des ausgewählten Pferdes.
class FeedSupplementsScreen extends ConsumerWidget {
  const FeedSupplementsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final all = ref.watch(selectedHorseSupplementsProvider).value ?? const [];
    final items = ref.watch(feedItemMapProvider).value ?? const {};
    final today = LocalDate.today();
    final groups = <(String, List<TemporarySupplement>)>[
      (
        l10n.feedSupplementActive,
        [
          for (final s in all)
            if (s.activeOn(today)) s,
        ],
      ),
      (
        l10n.feedSupplementUpcoming,
        [
          for (final s in all)
            if (s.start.isAfter(today)) s,
        ],
      ),
      (
        l10n.feedSupplementPast,
        [
          for (final s in all)
            if (s.end.isBefore(today)) s,
        ],
      ),
    ];
    return Scaffold(
      appBar: AppBar(title: Text(l10n.feedSupplements)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => editSupplement(context, ref, null),
        icon: const Icon(Icons.add),
        label: Text(l10n.feedSupplementNew),
      ),
      body: all.isEmpty
          ? EmptyState(
              icon: Icons.medication_liquid_outlined,
              title: l10n.feedSupplementsEmpty,
              message: l10n.feedDisclaimer,
            )
          : ListView(
              padding: const EdgeInsets.only(bottom: 96),
              children: [
                for (final (title, list) in groups)
                  if (list.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                      child: Semantics(
                        header: true,
                        child: Text(
                          title,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ),
                    for (final s in list)
                      ListTile(
                        title: Text(items[s.itemId]?.name ?? '?'),
                        subtitle: Text(
                          [
                            amountText(l10n, s.amount, items[s.itemId]),
                            s.mealName ?? l10n.feedSupplementMealDaily,
                            l10n.feedSupplementRange(
                              Fmt.date(s.start),
                              Fmt.date(s.end),
                            ),
                            if (s.source == SupplementSource.bloodTest)
                              l10n.feedSupplementFromBlood,
                            ?s.note,
                          ].join(' · '),
                        ),
                        onTap: () => editSupplement(context, ref, s),
                        trailing: IconButton(
                          tooltip: l10n.actionDelete,
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () async {
                            final ok = await showConfirmDialog(
                              context,
                              title: l10n.feedSupplementDeleteTitle,
                              message: items[s.itemId]?.name ?? '',
                              confirmLabel: l10n.actionDelete,
                              destructive: true,
                            );
                            if (ok) {
                              await ref
                                  .read(feedRepositoryProvider)
                                  .deleteSupplement(s.id);
                            }
                          },
                        ),
                      ),
                  ],
              ],
            ),
    );
  }
}

Future<void> editSupplement(
  BuildContext context,
  WidgetRef ref,
  TemporarySupplement? s,
) async {
  final horse = ref.read(selectedHorseProvider).value;
  if (horse == null && s == null) return;
  final result = await showDialog<TemporarySupplement>(
    context: context,
    builder: (_) =>
        _SupplementDialog(supplement: s, horseId: s?.horseId ?? horse!.id),
  );
  if (result != null) {
    await ref.read(feedRepositoryProvider).saveSupplement(result);
  }
}

class _SupplementDialog extends ConsumerStatefulWidget {
  const _SupplementDialog({this.supplement, required this.horseId});
  final TemporarySupplement? supplement;
  final String horseId;

  @override
  ConsumerState<_SupplementDialog> createState() => _SupplementDialogState();
}

class _SupplementDialogState extends ConsumerState<_SupplementDialog> {
  final _formKey = GlobalKey<FormState>();
  late String? _itemId = widget.supplement?.itemId;
  late final _amount = TextEditingController(
    text: widget.supplement?.amount == null
        ? ''
        : Fmt.decimal(widget.supplement!.amount!),
  );
  late bool _asDirected =
      widget.supplement != null && widget.supplement!.amount == null;
  late String? _meal = widget.supplement?.mealName;
  late LocalDate _start = widget.supplement?.start ?? LocalDate.today();
  late LocalDate _end =
      widget.supplement?.end ?? LocalDate.today().addWeeks(6).addDays(-1);
  late final _note = TextEditingController(text: widget.supplement?.note);

  @override
  void dispose() {
    _amount.dispose();
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final items = ref.watch(feedItemsProvider).value ?? const <FeedItem>[];
    final itemMap = ref.watch(feedItemMapProvider).value ?? const {};
    final plans = ref.watch(selectedHorseFeedPlansProvider).value ?? const [];
    final meals = planOn(plans, _start)?.meals ?? const <Meal>[];
    _itemId ??= items.isEmpty ? null : items.first.id;
    final item = itemMap[_itemId];
    return AlertDialog(
      title: Text(
        widget.supplement == null
            ? l10n.feedSupplementNew
            : l10n.feedSupplementEdit,
      ),
      scrollable: true,
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (items.isEmpty) Text(l10n.feedNeedItems),
            if (items.isNotEmpty)
              DropdownButtonFormField<String>(
                initialValue: _itemId,
                isExpanded: true,
                decoration: InputDecoration(labelText: l10n.feedEntryItem),
                items: [
                  for (final i in items)
                    DropdownMenuItem(value: i.id, child: Text(i.name)),
                ],
                onChanged: (v) => setState(() => _itemId = v),
              ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.feedSupplementAmountAsDirected),
              value: _asDirected,
              onChanged: (v) => setState(() => _asDirected = v),
            ),
            if (!_asDirected)
              TextFormField(
                controller: _amount,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: l10n.feedEntryAmount,
                  suffixText: item == null ? null : unitName(l10n, item.unit),
                ),
                validator: (v) {
                  final n = Fmt.parseDecimal(v ?? '');
                  return (n == null || n <= 0) ? l10n.fieldInvalidNumber : null;
                },
              ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String?>(
              initialValue: meals.any((m) => m.name == _meal) ? _meal : null,
              decoration: InputDecoration(labelText: l10n.feedSupplementMeal),
              items: [
                DropdownMenuItem(
                  value: null,
                  child: Text(l10n.feedSupplementMealDaily),
                ),
                for (final m in meals)
                  DropdownMenuItem(value: m.name, child: Text(m.name)),
              ],
              onChanged: (v) => setState(() => _meal = v),
            ),
            const SizedBox(height: 12),
            DateField(
              label: l10n.feedSupplementStart,
              value: _start,
              clearable: false,
              lastDate: LocalDate.today().addYears(2),
              onChanged: (d) => setState(() {
                _start = d ?? _start;
                if (_end.isBefore(_start)) _end = _start;
              }),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              children: [
                for (final w in [2, 4, 6, 8, 12])
                  ChoiceChip(
                    label: Text(l10n.feedSupplementWeeks(w)),
                    selected: _start.addWeeks(w).addDays(-1) == _end,
                    onSelected: (_) =>
                        setState(() => _end = _start.addWeeks(w).addDays(-1)),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            DateField(
              label: l10n.feedSupplementEnd,
              value: _end,
              clearable: false,
              firstDate: _start,
              lastDate: LocalDate.today().addYears(3),
              onChanged: (d) => setState(() => _end = d ?? _end),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _note,
              decoration: InputDecoration(labelText: l10n.feedSupplementNote),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.actionCancel),
        ),
        FilledButton(
          onPressed: _itemId == null
              ? null
              : () {
                  if (!_formKey.currentState!.validate()) return;
                  final s = widget.supplement;
                  Navigator.pop(
                    context,
                    TemporarySupplement(
                      id: s?.id ?? '',
                      horseId: widget.horseId,
                      itemId: _itemId!,
                      amount: _asDirected
                          ? null
                          : Fmt.parseDecimal(_amount.text),
                      mealName: _meal,
                      start: _start,
                      end: _end,
                      note: _note.text,
                      source: s?.source ?? SupplementSource.manual,
                      bloodTestId: s?.bloodTestId,
                    ),
                  );
                },
          child: Text(l10n.actionSave),
        ),
      ],
    );
  }
}
