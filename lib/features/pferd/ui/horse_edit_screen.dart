import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/time/local_date.dart';
import '../../../core/widgets/date_field.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../domain/horse.dart';
import 'horse_labels.dart';
import 'horse_providers.dart';

/// Pferd anlegen ([horseId] == null) oder bearbeiten.
class HorseEditScreen extends ConsumerStatefulWidget {
  const HorseEditScreen({super.key, this.horseId});

  final String? horseId;

  @override
  ConsumerState<HorseEditScreen> createState() => _HorseEditScreenState();
}

enum _F {
  name,
  callName,
  breed,
  color,
  height,
  ueln,
  chip,
  passport,
  sire,
  dam,
  stable,
  keeping,
  owner,
  insurance,
  intolerances,
  medical,
  notes,
}

class _HorseEditScreenState extends ConsumerState<HorseEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _c = {for (final f in _F.values) f: TextEditingController()};
  LocalDate? _birthDate;
  HorseSex? _sex;
  bool _birthdayReminder = false;
  bool _loading = true;
  bool _saving = false;

  bool get _isNew => widget.horseId == null;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    if (!_isNew) {
      final h = await ref
          .read(horseRepositoryProvider)
          .getHorse(widget.horseId!);
      if (h != null) {
        _birthDate = h.birthDate;
        _sex = h.sex;
        _birthdayReminder = h.birthdayReminder;
        final values = {
          _F.name: h.name,
          _F.callName: h.callName,
          _F.breed: h.breed,
          _F.color: h.colorMarkings,
          _F.height: h.heightCm?.toString(),
          _F.ueln: h.ueln,
          _F.chip: h.chipNumber,
          _F.passport: h.passportNumber,
          _F.sire: h.sire,
          _F.dam: h.dam,
          _F.stable: h.stableLocation,
          _F.keeping: h.keepingType,
          _F.owner: h.owner,
          _F.insurance: h.insurance,
          _F.intolerances: h.intolerances,
          _F.medical: h.medicalHistory,
          _F.notes: h.notes,
        };
        values.forEach((f, v) => _c[f]!.text = v ?? '');
      }
    }
    if (mounted) setState(() => _loading = false);
  }

  @override
  void dispose() {
    for (final c in _c.values) {
      c.dispose();
    }
    super.dispose();
  }

  String? _t(_F f) => _c[f]!.text;

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final horse = Horse(
      id: widget.horseId ?? '',
      name: _t(_F.name)!,
      callName: _t(_F.callName),
      birthDate: _birthDate,
      birthdayReminder: _birthDate != null && _birthdayReminder,
      sex: _sex,
      breed: _t(_F.breed),
      colorMarkings: _t(_F.color),
      heightCm: int.tryParse(_t(_F.height)!.trim()),
      ueln: _t(_F.ueln),
      chipNumber: _t(_F.chip),
      passportNumber: _t(_F.passport),
      sire: _t(_F.sire),
      dam: _t(_F.dam),
      stableLocation: _t(_F.stable),
      keepingType: _t(_F.keeping),
      owner: _t(_F.owner),
      insurance: _t(_F.insurance),
      intolerances: _t(_F.intolerances),
      medicalHistory: _t(_F.medical),
      notes: _t(_F.notes),
    );
    final repo = ref.read(horseRepositoryProvider);
    if (_isNew) {
      final id = await repo.createHorse(horse);
      // Ein neu angelegtes Pferd wird direkt ausgewählt.
      await ref.read(horseSelectionProvider).select(id);
    } else {
      await repo.updateHorse(horse);
    }
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(_isNew ? l10n.horseNew : l10n.horseEditTitle),
        actions: [
          TextButton(
            onPressed: (_loading || _saving) ? null : _save,
            child: Text(l10n.actionSave),
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                children: [
                  _section(context, l10n.horseSectionGeneral),
                  _text(
                    _F.name,
                    l10n.horseFieldName,
                    required: true,
                    autofocus: _isNew,
                  ),
                  _text(_F.callName, l10n.horseFieldCallName),
                  _gap,
                  DateField(
                    label: l10n.horseFieldBirthDate,
                    value: _birthDate,
                    lastDate: LocalDate.today(),
                    onChanged: (d) => setState(() => _birthDate = d),
                  ),
                  // Geburtstagserinnerung nur mit Benachrichtigungen (nicht Web).
                  if (_birthDate != null && !kIsWeb)
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      secondary: const Icon(Icons.cake_outlined),
                      title: Text(l10n.horseFieldBirthdayReminder),
                      value: _birthdayReminder,
                      onChanged: (v) => setState(() => _birthdayReminder = v),
                    ),
                  _gap,
                  Text(
                    l10n.horseFieldSex,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 8,
                    children: [
                      for (final s in HorseSex.values)
                        ChoiceChip(
                          label: Text(s.label(l10n)),
                          selected: _sex == s,
                          onSelected: (on) =>
                              setState(() => _sex = on ? s : null),
                        ),
                    ],
                  ),
                  _text(_F.breed, l10n.horseFieldBreed),
                  _text(_F.color, l10n.horseFieldColor),
                  _text(
                    _F.height,
                    l10n.horseFieldHeight,
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      final t = v?.trim() ?? '';
                      if (t.isEmpty) return null;
                      final n = int.tryParse(t);
                      return (n == null || n < 50 || n > 250)
                          ? l10n.fieldInvalidNumber
                          : null;
                    },
                  ),
                  _section(context, l10n.horseSectionIdentification),
                  _text(_F.ueln, l10n.horseFieldUeln),
                  _text(_F.chip, l10n.horseFieldChip),
                  _text(_F.passport, l10n.horseFieldPassport),
                  _section(context, l10n.horseSectionPedigree),
                  _text(_F.sire, l10n.horseFieldSire),
                  _text(_F.dam, l10n.horseFieldDam),
                  _section(context, l10n.horseSectionKeeping),
                  _text(_F.stable, l10n.horseFieldStable),
                  _text(
                    _F.keeping,
                    l10n.horseFieldKeeping,
                    hint: l10n.horseFieldKeepingHint,
                  ),
                  _text(_F.owner, l10n.horseFieldOwner),
                  _text(
                    _F.insurance,
                    l10n.horseFieldInsurance,
                    multiline: true,
                  ),
                  _section(context, l10n.horseSectionHealth),
                  _text(
                    _F.intolerances,
                    l10n.horseFieldIntolerances,
                    multiline: true,
                  ),
                  _text(
                    _F.medical,
                    l10n.horseFieldMedicalHistory,
                    multiline: true,
                  ),
                  _section(context, l10n.horseSectionNotes),
                  _text(_F.notes, l10n.horseFieldNotes, multiline: true),
                ],
              ),
            ),
    );
  }

  static const _gap = SizedBox(height: 12);

  Widget _section(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 4),
      child: Semantics(
        header: true,
        child: Text(
          title,
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
      ),
    );
  }

  Widget _text(
    _F field,
    String label, {
    bool required = false,
    bool multiline = false,
    bool autofocus = false,
    String? hint,
    TextInputType? keyboardType,
    FormFieldValidator<String>? validator,
  }) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: TextFormField(
        controller: _c[field],
        autofocus: autofocus,
        decoration: InputDecoration(
          labelText: required ? '$label *' : label,
          hintText: hint,
        ),
        keyboardType: multiline ? TextInputType.multiline : keyboardType,
        minLines: multiline ? 2 : 1,
        maxLines: multiline ? 6 : 1,
        textCapitalization: TextCapitalization.sentences,
        textInputAction: multiline
            ? TextInputAction.newline
            : TextInputAction.next,
        validator:
            validator ??
            (required
                ? (v) => (v == null || v.trim().isEmpty)
                      ? l10n.fieldRequired
                      : null
                : null),
      ),
    );
  }
}
