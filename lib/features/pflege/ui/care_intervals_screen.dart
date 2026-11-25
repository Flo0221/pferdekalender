import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../domain/care_type.dart';
import '../domain/repeat_interval.dart';
import 'care_labels.dart';
import 'care_providers.dart';

/// Einstellungen → Standard-Intervalle: Vorschläge je Art und Variante.
class CareIntervalsScreen extends ConsumerWidget {
  const CareIntervalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final types = ref.watch(careTypesProvider).value ?? const <CareType>[];
    final defaults = ref.watch(intervalDefaultsProvider).value ?? const [];

    RepeatInterval? exact(String typeId, String? variant) {
      for (final d in defaults) {
        if (d.typeId == typeId && d.variantKey == variant) return d.interval;
      }
      return null;
    }

    final rows = <(CareType, String?)>[
      for (final t in types)
        if (t.kind != CareKind.kotprobe) ...[
          if (CareVariants.forKind(t.kind).isEmpty) (t, null),
          for (final v in CareVariants.forKind(t.kind))
            if (v != 'sonstige') (t, v),
        ],
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsIntervals)),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(l10n.disclaimer, style: theme.textTheme.bodyMedium),
          ),
          for (final (type, variant) in rows)
            ListTile(
              leading: Icon(
                careIconFor(type.iconKey),
                color: Color(type.colorValue),
              ),
              title: Text(
                variant == null
                    ? type.name
                    : '${type.name} · ${variantLabel(l10n, variant)}',
              ),
              subtitle: Text(switch (exact(type.id, variant)) {
                final i? => intervalLabel(l10n, i),
                null => l10n.intervalNone,
              }),
              trailing: const Icon(Icons.edit_outlined),
              onTap: () =>
                  _edit(context, ref, type, variant, exact(type.id, variant)),
            ),
        ],
      ),
    );
  }

  Future<void> _edit(
    BuildContext context,
    WidgetRef ref,
    CareType type,
    String? variant,
    RepeatInterval? current,
  ) async {
    final result = await showDialog<(RepeatInterval?,)>(
      context: context,
      builder: (_) => _IntervalDialog(current: current),
    );
    if (result == null) return;
    await ref
        .read(careRepositoryProvider)
        .setIntervalDefault(type.id, variant, result.$1);
  }
}

class _IntervalDialog extends StatefulWidget {
  const _IntervalDialog({this.current});
  final RepeatInterval? current;

  @override
  State<_IntervalDialog> createState() => _IntervalDialogState();
}

class _IntervalDialogState extends State<_IntervalDialog> {
  late final _value = TextEditingController(
    text: widget.current?.value.toString() ?? '',
  );
  late IntervalUnit _unit = widget.current?.unit ?? IntervalUnit.weeks;

  @override
  void dispose() {
    _value.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final n = int.tryParse(_value.text.trim());
    final valid = n != null && n > 0 && n <= 999;
    return AlertDialog(
      title: Text(l10n.settingsIntervals),
      content: Row(
        children: [
          SizedBox(
            width: 80,
            child: TextField(
              controller: _value,
              autofocus: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: l10n.careRepeatValue),
              onChanged: (_) => setState(() {}),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: DropdownButton<IntervalUnit>(
              value: _unit,
              isExpanded: true,
              items: [
                for (final u in IntervalUnit.values)
                  DropdownMenuItem(
                    value: u,
                    child: Text(unitLabel(l10n, u, n ?? 2)),
                  ),
              ],
              onChanged: (u) => setState(() => _unit = u ?? _unit),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, (null,)),
          child: Text(l10n.intervalNone),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.actionCancel),
        ),
        FilledButton(
          onPressed: valid
              ? () => Navigator.pop(context, (RepeatInterval(n, _unit),))
              : null,
          child: Text(l10n.actionSave),
        ),
      ],
    );
  }
}
