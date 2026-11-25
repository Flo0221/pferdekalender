import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/format/formatters.dart';
import '../../../core/router/routes.dart';
import '../../../core/time/local_date.dart';
import '../../../core/widgets/date_field.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../pferd/ui/horse_providers.dart';
import '../domain/blood.dart';
import '../domain/blood_evaluation.dart';
import 'blood_providers.dart';

/// Blutbild eintragen: nur die abweichenden Werte, mit Suche.
class BloodEditScreen extends ConsumerStatefulWidget {
  const BloodEditScreen({super.key, this.testId});

  final String? testId;

  @override
  ConsumerState<BloodEditScreen> createState() => _BloodEditScreenState();
}

class _BloodEditScreenState extends ConsumerState<BloodEditScreen> {
  final _search = TextEditingController();
  final _lab = TextEditingController();
  final _notes = TextEditingController();
  LocalDate _date = LocalDate.today();
  final _values = <String, BloodValue>{};
  BloodTest? _original;
  bool _onlyEntered = false;
  bool _labDefaulted = false;
  bool _loading = true;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    if (widget.testId != null) {
      final t = await ref.read(bloodRepositoryProvider).getTest(widget.testId!);
      if (t != null) {
        _original = t;
        _date = t.date;
        _lab.text = t.lab ?? '';
        _notes.text = t.notes ?? '';
        for (final v in t.values) {
          _values[v.paramKey] = v;
        }
      }
    }
    if (mounted) setState(() => _loading = false);
  }

  @override
  void dispose() {
    _search.dispose();
    _lab.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final horse = ref.read(selectedHorseProvider).value;
    final horseId = _original?.horseId ?? horse?.id;
    if (horseId == null) return;
    setState(() => _saving = true);
    final id = await ref
        .read(bloodRepositoryProvider)
        .saveTest(
          BloodTest(
            id: _original?.id ?? '',
            horseId: horseId,
            date: _date,
            lab: _lab.text,
            notes: _notes.text,
            values: _values.values.toList(),
          ),
        );
    if (!mounted) return;
    // Nach dem Speichern direkt die Auswertung zeigen.
    context.pop();
    if (_original == null) await context.push(Routes.bloodDetail(id));
  }

  Future<void> _editValue(BloodParameter p) async {
    final result = await showDialog<_ValueResult>(
      context: context,
      builder: (_) => _ValueDialog(
        parameter: p,
        current: _values[p.key],
        month: _date.month,
      ),
    );
    if (result == null) return;
    setState(() {
      if (result.remove) {
        _values.remove(p.key);
      } else {
        _values[p.key] = result.value!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final catalog = ref.watch(bloodCatalogProvider).value;
    if (_loading || catalog == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    // Labor einmalig mit „Laboklin“ vorbelegen (änderbar).
    if (!_labDefaulted && _original == null) {
      _labDefaulted = true;
      _lab.text = l10n.bloodLabDefault;
    }

    var params = searchParameters(catalog.parameters, _search.text);
    if (_onlyEntered) {
      params = [
        for (final p in params)
          if (_values.containsKey(p.key)) p,
      ];
    }
    final searching = _search.text.trim().isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(_original == null ? l10n.bloodNew : l10n.bloodEdit),
        actions: [
          TextButton(
            onPressed: _saving ? null : _save,
            child: Text(l10n.actionSave),
          ),
        ],
      ),
      body: Column(
        children: [
          // Suche bleibt oben stehen, die Liste scrollt darunter.
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: TextField(
              controller: _search,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: l10n.bloodSearch,
                suffixIcon: searching
                    ? IconButton(
                        tooltip: l10n.bloodSearchClear,
                        icon: const Icon(Icons.clear),
                        onPressed: () => setState(_search.clear),
                      )
                    : null,
                border: const OutlineInputBorder(),
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
            child: Row(
              children: [
                Expanded(child: Text(l10n.bloodEnteredCount(_values.length))),
                FilterChip(
                  label: Text(l10n.bloodOnlyEntered),
                  selected: _onlyEntered,
                  onSelected: (v) => setState(() => _onlyEntered = v),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 32),
              children: [
                if (!searching && !_onlyEntered) ...[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: DateField(
                      label: l10n.bloodDate,
                      value: _date,
                      clearable: false,
                      lastDate: LocalDate.today(),
                      onChanged: (d) => setState(() => _date = d ?? _date),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                    child: TextField(
                      controller: _lab,
                      decoration: InputDecoration(labelText: l10n.bloodLab),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                    child: TextField(
                      controller: _notes,
                      minLines: 1,
                      maxLines: 4,
                      decoration: InputDecoration(labelText: l10n.bloodNotes),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                    child: Text(
                      l10n.healthTestsEmptyHint,
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                ],
                if (params.isEmpty) ListTile(title: Text(l10n.bloodNoMatch)),
                for (final (gKey, gName) in catalog.groups)
                  if (params.any((p) => p.group == gKey)) ...[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                      child: Semantics(
                        header: true,
                        child: Text(
                          gName,
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                    for (final p in params)
                      if (p.group == gKey) _paramTile(l10n, p),
                  ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _paramTile(AppLocalizations l10n, BloodParameter p) {
    final theme = Theme.of(context);
    final v = _values[p.key];
    final finding = v == null ? null : judge(p, v, _date.month);
    final (seasonHigh, _) = p.highFor(_date.month);
    final color = switch (finding?.direction) {
      Direction.high => theme.colorScheme.error,
      Direction.low => theme.colorScheme.tertiary,
      null => null,
    };
    return ListTile(
      title: Text(p.name),
      subtitle: Text(
        '${l10n.bloodRange(rangeText(l10n, v?.refLow ?? p.low, v?.refHigh ?? seasonHigh))} ${p.unit}',
      ),
      trailing: v == null
          ? const Icon(Icons.add)
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${Fmt.decimal(v.value)} ${p.unit}',
                  style: TextStyle(color: color, fontWeight: FontWeight.w600),
                ),
                Text(
                  statusText(l10n, finding!),
                  style: theme.textTheme.labelSmall?.copyWith(color: color),
                ),
              ],
            ),
      onTap: () => _editValue(p),
    );
  }
}

class _ValueResult {
  const _ValueResult.value(BloodValue this.value) : remove = false;
  const _ValueResult.remove() : value = null, remove = true;
  final BloodValue? value;
  final bool remove;
}

class _ValueDialog extends StatefulWidget {
  const _ValueDialog({
    required this.parameter,
    this.current,
    required this.month,
  });
  final BloodParameter parameter;
  final BloodValue? current;
  final int month;

  @override
  State<_ValueDialog> createState() => _ValueDialogState();
}

class _ValueDialogState extends State<_ValueDialog> {
  final _formKey = GlobalKey<FormState>();
  late final _value = TextEditingController(
    text: widget.current == null ? '' : Fmt.decimal(widget.current!.value),
  );
  late final _low = TextEditingController(
    text: widget.current?.refLow == null
        ? ''
        : Fmt.decimal(widget.current!.refLow!),
  );
  late final _high = TextEditingController(
    text: widget.current?.refHigh == null
        ? ''
        : Fmt.decimal(widget.current!.refHigh!),
  );
  late bool _ownRange =
      widget.current?.refLow != null || widget.current?.refHigh != null;

  @override
  void dispose() {
    _value.dispose();
    _low.dispose();
    _high.dispose();
    super.dispose();
  }

  String? _num(String? v, AppLocalizations l10n, {bool required = false}) {
    final t = v?.trim() ?? '';
    if (t.isEmpty) return required ? l10n.fieldRequired : null;
    return Fmt.parseDecimal(t) == null ? l10n.fieldInvalidNumber : null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final p = widget.parameter;
    final (seasonHigh, _) = p.highFor(widget.month);
    return AlertDialog(
      title: Text(p.name),
      scrollable: true,
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '${l10n.bloodRange(rangeText(l10n, p.low, seasonHigh))} ${p.unit}',
            ),
            if (p.note != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  p.note!,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _value,
              autofocus: true,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: '${l10n.bloodValue} *',
                suffixText: p.unit,
              ),
              validator: (v) => _num(v, l10n, required: true),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.bloodOwnRange),
              value: _ownRange,
              onChanged: (v) => setState(() => _ownRange = v),
            ),
            if (_ownRange)
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _low,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: InputDecoration(labelText: l10n.bloodOwnLow),
                      validator: (v) => _num(v, l10n),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _high,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: InputDecoration(labelText: l10n.bloodOwnHigh),
                      validator: (v) => _num(v, l10n),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
      actions: [
        if (widget.current != null)
          TextButton(
            onPressed: () =>
                Navigator.pop(context, const _ValueResult.remove()),
            child: Text(l10n.bloodRemoveValue),
          ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.actionCancel),
        ),
        FilledButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;
            Navigator.pop(
              context,
              _ValueResult.value(
                BloodValue(
                  paramKey: p.key,
                  value: Fmt.parseDecimal(_value.text)!,
                  refLow: _ownRange ? Fmt.parseDecimal(_low.text) : null,
                  refHigh: _ownRange ? Fmt.parseDecimal(_high.text) : null,
                ),
              ),
            );
          },
          child: Text(l10n.actionSave),
        ),
      ],
    );
  }
}
