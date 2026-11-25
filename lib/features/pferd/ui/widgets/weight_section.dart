import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/format/formatters.dart';
import '../../../../core/time/local_date.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../../../core/widgets/date_field.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../domain/horse.dart';
import '../horse_providers.dart';
import 'section_card.dart';
import 'weight_chart.dart';

class WeightSection extends ConsumerStatefulWidget {
  const WeightSection({super.key, required this.horse});

  final Horse horse;

  @override
  ConsumerState<WeightSection> createState() => _WeightSectionState();
}

class _WeightSectionState extends ConsumerState<WeightSection> {
  static const _collapsedCount = 3;
  bool _showAll = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final entries =
        ref.watch(horseWeightsProvider(widget.horse.id)).value ?? const [];
    final newestFirst = entries.reversed.toList();
    final visible = _showAll
        ? newestFirst
        : newestFirst.take(_collapsedCount).toList();

    return SectionCard(
      title: l10n.horseSectionWeight,
      action: IconButton(
        tooltip: l10n.weightAdd,
        icon: const Icon(Icons.add),
        onPressed: () => _add(context),
      ),
      child: entries.isEmpty
          ? Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Text(l10n.weightEmpty),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (entries.length >= 2)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
                    child: WeightChart(entries: entries),
                  ),
                for (final e in visible)
                  ListTile(
                    dense: true,
                    title: Text(l10n.weightValue(Fmt.decimal(e.weightKg))),
                    subtitle: Text([Fmt.date(e.date), ?e.note].join(' · ')),
                    trailing: IconButton(
                      tooltip: l10n.actionDelete,
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => _delete(context, e),
                    ),
                  ),
                if (!_showAll && entries.length > _collapsedCount)
                  TextButton(
                    onPressed: () => setState(() => _showAll = true),
                    child: Text(l10n.weightShowAll(entries.length)),
                  ),
              ],
            ),
    );
  }

  Future<void> _delete(BuildContext context, WeightEntry e) async {
    final l10n = AppLocalizations.of(context);
    final ok = await showConfirmDialog(
      context,
      title: l10n.weightDeleteConfirm,
      message:
          '${l10n.weightValue(Fmt.decimal(e.weightKg))} · ${Fmt.date(e.date)}',
      confirmLabel: l10n.actionDelete,
      destructive: true,
    );
    if (ok) await ref.read(horseRepositoryProvider).deleteWeight(e.id);
  }

  Future<void> _add(BuildContext context) async {
    final result = await showDialog<(LocalDate, double, String)>(
      context: context,
      builder: (_) => const _WeightDialog(),
    );
    if (result == null) return;
    final (date, kg, note) = result;
    await ref
        .read(horseRepositoryProvider)
        .addWeight(widget.horse.id, date, kg, note: note);
  }
}

class _WeightDialog extends StatefulWidget {
  const _WeightDialog();

  @override
  State<_WeightDialog> createState() => _WeightDialogState();
}

class _WeightDialogState extends State<_WeightDialog> {
  final _formKey = GlobalKey<FormState>();
  final _kg = TextEditingController();
  final _note = TextEditingController();
  LocalDate _date = LocalDate.today();

  @override
  void dispose() {
    _kg.dispose();
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(l10n.weightAdd),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _kg,
                autofocus: true,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(labelText: l10n.weightKg),
                validator: (v) {
                  final n = Fmt.parseDecimal(v ?? '');
                  return (n == null || n <= 0 || n > 2000)
                      ? l10n.fieldInvalidNumber
                      : null;
                },
              ),
              const SizedBox(height: 12),
              DateField(
                label: l10n.weightDate,
                value: _date,
                clearable: false,
                lastDate: LocalDate.today(),
                onChanged: (d) => setState(() => _date = d ?? _date),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _note,
                decoration: InputDecoration(labelText: l10n.weightNote),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.actionCancel),
        ),
        FilledButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;
            Navigator.pop(context, (
              _date,
              Fmt.parseDecimal(_kg.text)!,
              _note.text,
            ));
          },
          child: Text(l10n.actionSave),
        ),
      ],
    );
  }
}
