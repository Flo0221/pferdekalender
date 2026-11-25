import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../domain/care_type.dart';
import 'care_labels.dart';
import 'care_providers.dart';

/// Einstellungen → Eintragsarten: Namen/Farben ändern, eigene Arten anlegen,
/// Arten ausblenden (archivieren statt löschen, damit alte Einträge bleiben).
class CareTypesScreen extends ConsumerWidget {
  const CareTypesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final types = ref.watch(allCareTypesProvider).value ?? const <CareType>[];
    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsCareTypes)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _edit(context, ref, null),
        icon: const Icon(Icons.add),
        label: Text(l10n.careTypeNew),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 96),
        children: [
          for (final t in types)
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Color(t.colorValue).withValues(alpha: 0.18),
                foregroundColor: Color(t.colorValue),
                child: ExcludeSemantics(child: Icon(careIconFor(t.iconKey))),
              ),
              title: Text(t.name),
              subtitle: t.archived ? Text(l10n.careTypeArchivedLabel) : null,
              onTap: () => _edit(context, ref, t),
              trailing: IconButton(
                tooltip: t.archived
                    ? l10n.careTypeUnarchive
                    : l10n.careTypeArchive,
                icon: Icon(
                  t.archived
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onPressed: () => ref
                    .read(careRepositoryProvider)
                    .setTypeArchived(t.id, archived: !t.archived),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _edit(
    BuildContext context,
    WidgetRef ref,
    CareType? type,
  ) async {
    final result = await showDialog<CareType>(
      context: context,
      builder: (_) => _TypeDialog(type: type),
    );
    if (result != null) await ref.read(careRepositoryProvider).saveType(result);
  }
}

class _TypeDialog extends StatefulWidget {
  const _TypeDialog({this.type});
  final CareType? type;

  @override
  State<_TypeDialog> createState() => _TypeDialogState();
}

class _TypeDialogState extends State<_TypeDialog> {
  final _formKey = GlobalKey<FormState>();
  late final _name = TextEditingController(text: widget.type?.name);
  late int _color = widget.type?.colorValue ?? careColors.first;
  late String _icon = widget.type?.iconKey ?? 'sonstiges';

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final builtin = widget.type?.builtin ?? false;
    return AlertDialog(
      title: Text(widget.type == null ? l10n.careTypeNew : l10n.careTypeEdit),
      scrollable: true,
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _name,
              autofocus: widget.type == null,
              decoration: InputDecoration(labelText: '${l10n.careTypeName} *'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? l10n.fieldRequired : null,
            ),
            const SizedBox(height: 16),
            Text(l10n.careTypeColor),
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
                        radius: 18,
                        backgroundColor: Color(c),
                        child: c == _color
                            ? const Icon(Icons.check, color: Colors.white)
                            : null,
                      ),
                    ),
                  ),
              ],
            ),
            if (!builtin) ...[
              const SizedBox(height: 16),
              Text(l10n.careTypeIcon),
              const SizedBox(height: 8),
              Wrap(
                spacing: 4,
                children: [
                  for (final MapEntry(:key, :value) in careIcons.entries)
                    IconButton(
                      isSelected: key == _icon,
                      tooltip: key,
                      icon: Icon(value),
                      onPressed: () => setState(() => _icon = key),
                    ),
                ],
              ),
            ] else ...[
              const SizedBox(height: 12),
              Text(
                l10n.careTypeBuiltinHint,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
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
            final t = widget.type;
            Navigator.pop(
              context,
              CareType(
                id: t?.id ?? '',
                name: _name.text,
                kind: t?.kind ?? CareKind.allgemein,
                colorValue: _color,
                iconKey: _icon,
                builtin: builtin,
              ),
            );
          },
          child: Text(l10n.actionSave),
        ),
      ],
    );
  }
}
