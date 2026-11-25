import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/format/formatters.dart';
import '../../../core/widgets/confirm_dialog.dart';
import '../../../core/widgets/minutes_field.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../pflege/ui/care_labels.dart' show careColors;
import '../domain/shift.dart';
import 'shift_providers.dart';
import 'widgets/shift_badge.dart';

/// Schichtvorlagen verwalten.
class ShiftTemplatesScreen extends ConsumerWidget {
  const ShiftTemplatesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final templates =
        ref.watch(shiftTemplatesProvider).value ?? const <ShiftTemplate>[];
    return Scaffold(
      appBar: AppBar(title: Text(l10n.shiftTemplates)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => editShiftTemplate(context, ref, null),
        icon: const Icon(Icons.add),
        label: Text(l10n.shiftTemplateNew),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 96),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Text(
              l10n.shiftTemplatesHint,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          if (templates.isEmpty)
            ListTile(
              leading: const Icon(Icons.auto_awesome_outlined),
              title: Text(l10n.shiftCreateDefaults),
              subtitle: Text(l10n.shiftCreateDefaultsHint),
              onTap: () =>
                  ref.read(shiftRepositoryProvider).createDefaultTemplates(),
            ),
          for (final t in templates)
            ListTile(
              leading: ShiftBadge(template: t),
              title: Text(t.name),
              subtitle: Text(shiftTemplateSummary(l10n, t)),
              onTap: () => editShiftTemplate(context, ref, t),
              trailing: IconButton(
                tooltip: l10n.actionDelete,
                icon: const Icon(Icons.delete_outline),
                onPressed: () => _remove(context, ref, t),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _remove(
    BuildContext context,
    WidgetRef ref,
    ShiftTemplate t,
  ) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final ok = await showConfirmDialog(
      context,
      title: l10n.shiftTemplateRemoveTitle(t.name),
      message: l10n.shiftTemplateRemoveText,
      confirmLabel: l10n.actionRemove,
      destructive: true,
    );
    if (!ok) return;
    final deleted = await ref
        .read(shiftRepositoryProvider)
        .removeTemplate(t.id);
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          deleted ? l10n.shiftTemplateRemoved : l10n.shiftTemplateArchived,
        ),
      ),
    );
  }
}

/// „06:00–14:00 · 90 min · Nachtschicht“
String shiftTemplateSummary(AppLocalizations l10n, ShiftTemplate t) => [
  if (t.startMinutes != null && t.endMinutes != null)
    l10n.shiftTimeRange(Fmt.time(t.startMinutes!), Fmt.time(t.endMinutes!)),
  '${l10n.shiftStableToday} ${Fmt.duration(t.stableMinutes)}',
  if (t.preferredTime case final p?) dayTimeLabel(l10n, p),
  if (t.isNight) l10n.shiftTemplateNight,
].join(' · ');

/// Öffnet den Dialog für eine neue ([template] == null) oder vorhandene
/// Schicht. Gibt die ID der gespeicherten Schicht zurück (oder `null`).
Future<String?> editShiftTemplate(
  BuildContext context,
  WidgetRef ref,
  ShiftTemplate? template,
) async {
  final result = await showDialog<ShiftTemplate>(
    context: context,
    builder: (_) => _TemplateDialog(template: template),
  );
  if (result == null) return null;
  return ref.read(shiftRepositoryProvider).saveTemplate(result);
}

/// Chip „+ Eigene Schicht“ für Auswahllisten; ruft [onCreated] mit der ID.
class AddShiftChip extends ConsumerWidget {
  const AddShiftChip({super.key, required this.onCreated});

  final ValueChanged<String> onCreated;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return ActionChip(
      avatar: const Icon(Icons.add, size: 18),
      label: Text(l10n.shiftCustomAdd),
      onPressed: () async {
        final id = await editShiftTemplate(context, ref, null);
        if (id != null) onCreated(id);
      },
    );
  }
}

class _TemplateDialog extends StatefulWidget {
  const _TemplateDialog({this.template});
  final ShiftTemplate? template;

  @override
  State<_TemplateDialog> createState() => _TemplateDialogState();
}

class _TemplateDialogState extends State<_TemplateDialog> {
  final _formKey = GlobalKey<FormState>();
  late final _name = TextEditingController(text: widget.template?.name);
  late final _short = TextEditingController(text: widget.template?.shortCode);
  late final _minutes = TextEditingController(
    text: '${widget.template?.stableMinutes ?? 90}',
  );
  late int _color = widget.template?.colorValue ?? careColors[1];
  late int? _start = widget.template?.startMinutes;
  late int? _end = widget.template?.endMinutes;
  late DayTime? _preferred = widget.template?.preferredTime;
  late bool _night = widget.template?.isNight ?? false;

  @override
  void dispose() {
    _name.dispose();
    _short.dispose();
    _minutes.dispose();
    super.dispose();
  }

  Future<void> _pickTime(bool start) async {
    final current = (start ? _start : _end) ?? (start ? 6 * 60 : 14 * 60);
    final t = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: current ~/ 60, minute: current % 60),
    );
    if (t == null) return;
    setState(() {
      final m = t.hour * 60 + t.minute;
      if (start) {
        _start = m;
        _end ??= (m + 8 * 60) % (24 * 60);
      } else {
        _end = m;
        _start ??= (m - 8 * 60) % (24 * 60);
      }
      // Ende vor Beginn → über Mitternacht → Nachtschicht vorschlagen.
      if (_start != null && _end != null && _end! < _start!) _night = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return AlertDialog(
      title: Text(
        widget.template == null
            ? l10n.shiftTemplateNew
            : l10n.shiftTemplateEdit,
      ),
      scrollable: true,
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _name,
              autofocus: widget.template == null,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: '${l10n.shiftTemplateName} *',
              ),
              onChanged: (v) {
                if (_short.text.isEmpty && v.trim().isNotEmpty) {
                  _short.text = v.trim().characters.first.toUpperCase();
                }
              },
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? l10n.fieldRequired : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _short,
              maxLength: 3,
              decoration: InputDecoration(
                labelText: '${l10n.shiftTemplateShort} *',
                helperText: l10n.shiftTemplateShortHint,
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? l10n.fieldRequired : null,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final c in careColors)
                  Semantics(
                    button: true,
                    selected: c == _color,
                    label: '${l10n.careTypeColor} ${careColors.indexOf(c) + 1}',
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => setState(() => _color = c),
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Color(c),
                        child: c == _color
                            ? const Icon(
                                Icons.check,
                                size: 18,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.login),
                    label: Text(
                      _start == null
                          ? l10n.shiftTemplateStart
                          : '${l10n.shiftTemplateStart} ${Fmt.time(_start!)}',
                    ),
                    onPressed: () => _pickTime(true),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.logout),
                    label: Text(
                      _end == null
                          ? l10n.shiftTemplateEnd
                          : '${l10n.shiftTemplateEnd} ${Fmt.time(_end!)}',
                    ),
                    onPressed: () => _pickTime(false),
                  ),
                ),
              ],
            ),
            if (_start != null || _end != null)
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () => setState(() {
                    _start = null;
                    _end = null;
                  }),
                  child: Text(l10n.shiftTemplateNoTime),
                ),
              ),
            const SizedBox(height: 12),
            MinutesField(
              controller: _minutes,
              label: l10n.shiftTemplateStable,
              helper: l10n.shiftTemplateStableHint,
              onChanged: () => setState(() {}),
            ),
            const SizedBox(height: 16),
            Text(l10n.shiftTemplatePreferred, style: theme.textTheme.bodySmall),
            const SizedBox(height: 4),
            Wrap(
              spacing: 6,
              children: [
                ChoiceChip(
                  label: Text(l10n.shiftTemplatePreferredNone),
                  selected: _preferred == null,
                  onSelected: (_) => setState(() => _preferred = null),
                ),
                for (final t in DayTime.values)
                  ChoiceChip(
                    label: Text(dayTimeLabel(l10n, t)),
                    selected: _preferred == t,
                    onSelected: (_) => setState(() => _preferred = t),
                  ),
              ],
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.shiftTemplateNight),
              subtitle: Text(l10n.shiftTemplateNightHint),
              value: _night,
              onChanged: (v) => setState(() => _night = v),
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
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;
            final t = widget.template;
            Navigator.pop(
              context,
              ShiftTemplate(
                id: t?.id ?? '',
                name: _name.text,
                shortCode: _short.text,
                colorValue: _color,
                startMinutes: _start,
                endMinutes: _end,
                stableMinutes: int.parse(_minutes.text.trim()),
                preferredTime: _preferred,
                isNight: _night,
                sortOrder: t?.sortOrder ?? 0,
              ),
            );
          },
          child: Text(l10n.actionSave),
        ),
      ],
    );
  }
}
