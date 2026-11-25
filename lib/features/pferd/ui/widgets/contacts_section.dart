import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../l10n/generated/app_localizations.dart';
import '../../domain/contact.dart';
import '../../domain/horse.dart';
import '../horse_labels.dart';
import '../horse_providers.dart';
import 'section_card.dart';

/// Kontakte des Pferdes; Telefonnummern sind antippbar (`tel:` öffnet nur
/// die Telefon-App, kein Netzwerk).
class ContactsSection extends ConsumerWidget {
  const ContactsSection({super.key, required this.horse});

  final Horse horse;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final contacts =
        ref.watch(horseContactsProvider(horse.id)).value ?? const [];
    return SectionCard(
      title: l10n.horseSectionContacts,
      action: IconButton(
        tooltip: l10n.contactAdd,
        icon: const Icon(Icons.person_add_alt_outlined),
        onPressed: () => _add(context, ref, contacts),
      ),
      child: contacts.isEmpty
          ? Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Text(l10n.contactsEmpty),
            )
          : Column(
              children: [
                for (final c in contacts)
                  ListTile(
                    title: Text(c.name),
                    subtitle: Text([c.role.label(l10n), ?c.phone].join(' · ')),
                    onTap: () => _edit(context, ref, c),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (c.dialablePhone != null)
                          IconButton(
                            tooltip: l10n.contactCall(c.name),
                            icon: const Icon(Icons.call_outlined),
                            onPressed: () => _call(context, c),
                          ),
                        PopupMenuButton<String>(
                          onSelected: (v) => v == 'edit'
                              ? _edit(context, ref, c)
                              : ref
                                    .read(horseRepositoryProvider)
                                    .unlinkContact(horse.id, c.id),
                          itemBuilder: (_) => [
                            PopupMenuItem(
                              value: 'edit',
                              child: Text(l10n.actionEdit),
                            ),
                            PopupMenuItem(
                              value: 'unlink',
                              child: Text(l10n.contactUnlink),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
    );
  }

  Future<void> _call(BuildContext context, Contact c) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final ok = await launchUrl(Uri(scheme: 'tel', path: c.dialablePhone));
    if (!ok) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.contactCallFailed)));
    }
  }

  Future<void> _add(
    BuildContext context,
    WidgetRef ref,
    List<Contact> linked,
  ) async {
    final l10n = AppLocalizations.of(context);
    final all = ref.read(allContactsProvider).value ?? const <Contact>[];
    final linkedIds = linked.map((c) => c.id).toSet();
    final available = all.where((c) => !linkedIds.contains(c.id)).toList();

    if (available.isEmpty) {
      await _edit(context, ref, null);
      return;
    }
    final choice = await showModalBottomSheet<Object>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              leading: const Icon(Icons.person_add_alt_outlined),
              title: Text(l10n.contactNew),
              onTap: () => Navigator.pop(context, 'new'),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
              child: Text(
                l10n.contactExisting,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            for (final c in available)
              ListTile(
                leading: const Icon(Icons.person_outline),
                title: Text(c.name),
                subtitle: Text(c.role.label(l10n)),
                onTap: () => Navigator.pop(context, c),
              ),
          ],
        ),
      ),
    );
    if (!context.mounted) return;
    if (choice == 'new') {
      await _edit(context, ref, null);
    } else if (choice is Contact) {
      await ref.read(horseRepositoryProvider).linkContact(horse.id, choice.id);
    }
  }

  Future<void> _edit(BuildContext context, WidgetRef ref, Contact? c) async {
    final result = await showDialog<Contact>(
      context: context,
      builder: (_) => _ContactDialog(contact: c),
    );
    if (result == null) return;
    await ref
        .read(horseRepositoryProvider)
        .saveContact(result, horseId: horse.id);
  }
}

class _ContactDialog extends StatefulWidget {
  const _ContactDialog({this.contact});

  final Contact? contact;

  @override
  State<_ContactDialog> createState() => _ContactDialogState();
}

class _ContactDialogState extends State<_ContactDialog> {
  final _formKey = GlobalKey<FormState>();
  late final _name = TextEditingController(text: widget.contact?.name);
  late final _phone = TextEditingController(text: widget.contact?.phone);
  late final _email = TextEditingController(text: widget.contact?.email);
  late final _notes = TextEditingController(text: widget.contact?.notes);
  late ContactRole _role = widget.contact?.role ?? ContactRole.tierarzt;

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _email.dispose();
    _notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isNew = widget.contact == null;
    return AlertDialog(
      title: Text(isNew ? l10n.contactNew : l10n.contactEdit),
      scrollable: true,
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _name,
              autofocus: isNew,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(labelText: '${l10n.contactName} *'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? l10n.fieldRequired : null,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<ContactRole>(
              initialValue: _role,
              decoration: InputDecoration(labelText: l10n.contactRole),
              items: [
                for (final r in ContactRole.values)
                  DropdownMenuItem(value: r, child: Text(r.label(l10n))),
              ],
              onChanged: (r) => setState(() => _role = r ?? _role),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _phone,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: l10n.contactPhone),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: l10n.contactEmail),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _notes,
              minLines: 1,
              maxLines: 4,
              decoration: InputDecoration(labelText: l10n.contactNotes),
            ),
            if (!isNew) ...[
              const SizedBox(height: 12),
              Text(
                l10n.contactSharedHint,
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
            Navigator.pop(
              context,
              Contact(
                id: widget.contact?.id ?? '',
                name: _name.text,
                role: _role,
                phone: _phone.text,
                email: _email.text,
                notes: _notes.text,
              ),
            );
          },
          child: Text(l10n.actionSave),
        ),
      ],
    );
  }
}
