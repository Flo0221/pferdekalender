import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/format/formatters.dart';
import '../../../core/notifications/notification_providers.dart';
import '../../../core/time/local_date.dart';
import '../../../core/widgets/date_field.dart';
import '../../../core/widgets/suggest_field.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../einstellungen/domain/reminder_settings.dart';
import '../../einstellungen/ui/settings_providers.dart';
import '../../pferd/ui/horse_providers.dart';
import '../domain/care_event.dart';
import '../domain/care_type.dart';
import '../domain/interval_defaults.dart';
import '../domain/repeat_interval.dart';
import 'care_actions.dart';
import 'care_labels.dart';
import 'care_providers.dart';

/// Pflege-Eintrag anlegen ([eventId] == null) oder bearbeiten.
class CareEditScreen extends ConsumerStatefulWidget {
  const CareEditScreen({super.key, this.eventId, this.initialDate});

  final String? eventId;
  final LocalDate? initialDate;

  @override
  ConsumerState<CareEditScreen> createState() => _CareEditScreenState();
}

/// Wählbare Erinnerungen (Tage vorher).
const _reminderChoices = [0, 1, 3, 7, 14];

class _CareEditScreenState extends ConsumerState<CareEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _person = TextEditingController();
  final _cost = TextEditingController();
  final _notes = TextEditingController();
  final _praeparat = TextEditingController();
  final _wirkstoff = TextEditingController();
  final _dosierung = TextEditingController();
  final _labor = TextEditingController();
  final _epg = TextEditingController();
  final _ergebnis = TextEditingController();
  final _impfungName = TextEditingController();
  final _impfstoff = TextEditingController();
  final _repeatValue = TextEditingController();

  CareEvent? _original;
  String? _typeId;
  late LocalDate _date;
  int? _time;
  bool _done = false;
  String? _variant;
  bool _grundimmunisierung = false;
  bool _repeatOn = false;
  IntervalUnit _repeatUnit = IntervalUnit.weeks;
  Set<int> _reminders = {};
  bool _loading = true;
  bool _saving = false;

  bool get _isNew => widget.eventId == null;

  @override
  void initState() {
    super.initState();
    _date = widget.initialDate ?? LocalDate.today();
    _load();
  }

  Future<void> _load() async {
    if (_isNew) {
      final settings =
          ref.read(reminderSettingsProvider).value ?? const ReminderSettings();
      _reminders = settings.defaultOffsets.toSet();
      _done = _date.isBefore(LocalDate.today());
    } else {
      final e = await ref
          .read(careRepositoryProvider)
          .getEvent(widget.eventId!);
      if (e != null) {
        _original = e;
        _typeId = e.typeId;
        _date = e.date;
        _time = e.timeMinutes;
        _done = e.done;
        _variant = e.variantKey;
        _title.text = e.title ?? '';
        _person.text = e.person ?? '';
        _cost.text = e.costCents == null ? '' : Fmt.money(e.costCents!);
        _notes.text = e.notes ?? '';
        String f(String k) => e.fields[k]?.toString() ?? '';
        _praeparat.text = f(CareFields.praeparat);
        _wirkstoff.text = f(CareFields.wirkstoff);
        _dosierung.text = f(CareFields.dosierung);
        _labor.text = f(CareFields.labor);
        _epg.text = f(CareFields.epg);
        _ergebnis.text = f(CareFields.ergebnis);
        _impfungName.text = f(CareFields.impfungName);
        _impfstoff.text = f(CareFields.impfstoff);
        _grundimmunisierung = e.fields[CareFields.grundimmunisierung] == true;
        if (e.repeat != null) {
          _repeatOn = true;
          _repeatValue.text = e.repeat!.value.toString();
          _repeatUnit = e.repeat!.unit;
        }
        _reminders = e.reminderOffsets.toSet();
      }
    }
    if (mounted) setState(() => _loading = false);
  }

  @override
  void dispose() {
    for (final c in [
      _title,
      _person,
      _cost,
      _notes,
      _praeparat,
      _wirkstoff,
      _dosierung,
      _labor,
      _epg,
      _ergebnis,
      _impfungName,
      _impfstoff,
      _repeatValue,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  CareType? _type(Map<String, CareType> types) =>
      _typeId == null ? null : types[_typeId];

  RepeatInterval? get _repeat {
    if (!_repeatOn) return null;
    final n = int.tryParse(_repeatValue.text.trim());
    return (n == null || n <= 0) ? null : RepeatInterval(n, _repeatUnit);
  }

  void _selectType(CareType t) {
    setState(() {
      _typeId = t.id;
      _variant = null;
    });
    _applySuggestion();
  }

  /// Übernimmt das vorgeschlagene Intervall, solange der Nutzer bei einem
  /// neuen Eintrag noch nichts eingestellt hat.
  void _applySuggestion() {
    if (!_isNew || _typeId == null) return;
    final defaults = ref.read(intervalDefaultsProvider).value ?? const [];
    final s = suggestInterval(defaults, _typeId!, _variant);
    setState(() {
      if (s == null) {
        _repeatOn = false;
        _repeatValue.clear();
      } else {
        _repeatOn = true;
        _repeatValue.text = s.value.toString();
        _repeatUnit = s.unit;
      }
    });
  }

  Map<String, Object> _fields(CareKind kind) => switch (kind) {
    CareKind.wurmkur => {
      CareFields.praeparat: _praeparat.text,
      CareFields.wirkstoff: _wirkstoff.text,
      CareFields.dosierung: _dosierung.text,
    },
    CareKind.kotprobe => {
      CareFields.labor: _labor.text,
      CareFields.epg: ?int.tryParse(_epg.text.trim()),
      CareFields.ergebnis: _ergebnis.text,
    },
    CareKind.impfung => {
      if (_variant == 'sonstige') CareFields.impfungName: _impfungName.text,
      CareFields.impfstoff: _impfstoff.text,
      CareFields.grundimmunisierung: _grundimmunisierung,
    },
    _ => const {},
  };

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    final types = ref.read(careTypeMapProvider);
    final type = _type(types);
    final horse = ref.read(selectedHorseProvider).value;
    if (type == null || !_formKey.currentState!.validate()) return;
    if (_isNew && horse == null) return;
    setState(() => _saving = true);
    final messenger = ScaffoldMessenger.of(context);
    final repo = ref.read(careRepositoryProvider);

    final event = CareEvent(
      id: _original?.id ?? '',
      horseId: _original?.horseId ?? horse!.id,
      typeId: type.id,
      date: _date,
      timeMinutes: _time,
      done: _done,
      variantKey: _variant,
      title: type.kind == CareKind.allgemein ? _title.text : null,
      person: type.kind == CareKind.kotprobe ? null : _person.text,
      costCents: Fmt.parseMoneyCents(_cost.text),
      notes: _notes.text,
      fields: _fields(type.kind),
      repeat: _repeat,
      parentEventId: _original?.parentEventId,
      seriesId: _original?.seriesId,
      reminderOffsets: _reminders.toList()..sort(),
    );

    // Folgetermin anpassen, wenn Datum oder Intervall geändert wurden.
    var recalc = false;
    if (_original != null && event.repeat != null) {
      final followUp = await repo.getFollowUp(_original!.id);
      final changed =
          _original!.date != event.date || _original!.repeat != event.repeat;
      if (followUp != null && !followUp.done && changed && mounted) {
        final target = event.repeat!.addTo(event.date);
        if (target != followUp.date) {
          recalc = await askRecalculateFollowUp(
            context,
            oldDate: followUp.date,
            newDate: target,
          );
        }
      }
    }

    final id = await repo.saveEvent(event, recalculateFollowUp: recalc);
    if (_isNew && event.repeat != null) {
      final created = await repo.getFollowUp(id);
      if (created != null) {
        messenger.showSnackBar(
          SnackBar(
            content: Text(l10n.careFollowUpCreated(Fmt.date(created.date))),
          ),
        );
      }
    }
    if (!event.done && event.reminderOffsets.isNotEmpty) {
      await _ensureNotificationPermission(messenger, l10n);
    }
    if (mounted) context.pop();
  }

  Future<void> _ensureNotificationPermission(
    ScaffoldMessengerState messenger,
    AppLocalizations l10n,
  ) async {
    final gateway = ref.read(notificationGatewayProvider);
    try {
      final state = await gateway.permissionState();
      // Web: keine Benachrichtigungen – kein Hinweis nötig.
      if (!state.supported || state.notificationsAllowed) return;
      final granted = await gateway.requestNotifications();
      if (!granted) {
        messenger.showSnackBar(
          SnackBar(
            content: Text(l10n.careReminderPermissionDenied),
            duration: const Duration(seconds: 6),
          ),
        );
      }
    } on Object {
      // Ohne Benachrichtigungs-Plugin (z. B. in Tests) einfach weiter.
    }
  }

  Future<void> _delete() async {
    if (_original == null) return;
    final deleted = await deleteEventFlow(context, ref, _original!);
    if (deleted && mounted) context.pop();
  }

  Future<void> _pickTime() async {
    final initial = _time ?? 9 * 60;
    final t = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: initial ~/ 60, minute: initial % 60),
    );
    if (t != null) setState(() => _time = t.hour * 60 + t.minute);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final types = ref.watch(careTypeMapProvider);
    final activeTypes = ref.watch(careTypesProvider).value ?? const [];
    final type = _type(types);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isNew ? l10n.careNew : l10n.careEdit),
        actions: [
          if (!_isNew)
            IconButton(
              tooltip: l10n.actionDelete,
              icon: const Icon(Icons.delete_outline),
              onPressed: _saving ? null : _delete,
            ),
          TextButton(
            onPressed: (_loading || _saving || type == null) ? null : _save,
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
                  _header(l10n.careFieldType),
                  if (_isNew)
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        for (final t in activeTypes)
                          ChoiceChip(
                            avatar: Icon(
                              careIconFor(t.iconKey),
                              size: 18,
                              color: Color(t.colorValue),
                            ),
                            label: Text(t.name),
                            selected: _typeId == t.id,
                            onSelected: (_) => _selectType(t),
                          ),
                      ],
                    )
                  else if (type != null)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        careIconFor(type.iconKey),
                        color: Color(type.colorValue),
                      ),
                      title: Text(type.name),
                    ),
                  if (type != null) ..._form(l10n, type),
                ],
              ),
            ),
    );
  }

  List<Widget> _form(AppLocalizations l10n, CareType type) {
    final kind = type.kind;
    List<String> sugg(String field, {bool perType = true}) =>
        ref
            .watch(careSuggestionsProvider((field, perType ? type.id : null)))
            .value ??
        const [];
    final variants = CareVariants.forKind(kind);
    final personLabel = switch (kind) {
      CareKind.huf => l10n.careFieldHufschmied,
      CareKind.impfung || CareKind.wurmkur => l10n.careFieldTierarzt,
      _ => l10n.careFieldPerson,
    };
    final hint = switch ((kind, _variant)) {
      (CareKind.huf, _) => l10n.careHintHuf,
      (CareKind.wurmkur, _) => l10n.careHintWurmkur,
      (CareKind.impfung, 'influenza') => l10n.careHintInfluenza,
      (CareKind.impfung, 'tetanus') => l10n.careHintTetanus,
      _ => null,
    };

    return [
      const SizedBox(height: 16),
      DateField(
        label: l10n.careFieldDate,
        value: _date,
        clearable: false,
        lastDate: LocalDate.today().addYears(5),
        onChanged: (d) => setState(() => _date = d ?? _date),
      ),
      const SizedBox(height: 12),
      InkWell(
        onTap: _pickTime,
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: l10n.careFieldTime,
            prefixIcon: const Icon(Icons.schedule),
            suffixIcon: _time == null
                ? null
                : IconButton(
                    tooltip: l10n.careFieldTimeClear,
                    icon: const Icon(Icons.clear),
                    onPressed: () => setState(() => _time = null),
                  ),
          ),
          isEmpty: _time == null,
          child: _time == null ? null : Text(Fmt.time(_time!)),
        ),
      ),
      SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(l10n.careFieldDone),
        value: _done,
        onChanged: (v) => setState(() => _done = v),
      ),
      if (variants.isNotEmpty) ...[
        _header(
          kind == CareKind.huf ? l10n.careFieldHufArt : l10n.careFieldImpfung,
        ),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            for (final v in variants)
              ChoiceChip(
                label: Text(variantLabel(l10n, v)),
                selected: _variant == v,
                onSelected: (on) {
                  setState(() => _variant = on ? v : null);
                  _applySuggestion();
                },
              ),
          ],
        ),
      ],
      if (kind == CareKind.impfung && _variant == 'sonstige') ...[
        const SizedBox(height: 12),
        SuggestField(
          controller: _impfungName,
          label: l10n.careFieldImpfungName,
          suggestions: sugg(CareFields.impfungName),
        ),
      ],
      if (kind == CareKind.allgemein) ...[
        const SizedBox(height: 12),
        TextFormField(
          controller: _title,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(labelText: l10n.careFieldTitle),
        ),
      ],
      if (kind == CareKind.wurmkur) ...[
        const SizedBox(height: 12),
        SuggestField(
          controller: _praeparat,
          label: l10n.careFieldPraeparat,
          suggestions: sugg(CareFields.praeparat),
        ),
        const SizedBox(height: 12),
        SuggestField(
          controller: _wirkstoff,
          label: l10n.careFieldWirkstoff,
          suggestions: sugg(CareFields.wirkstoff),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _dosierung,
          decoration: InputDecoration(labelText: l10n.careFieldDosierung),
        ),
      ],
      if (kind == CareKind.kotprobe) ...[
        const SizedBox(height: 12),
        SuggestField(
          controller: _labor,
          label: l10n.careFieldLabor,
          suggestions: sugg(CareFields.labor),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _epg,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: l10n.careFieldEpg),
          validator: (v) {
            final t = v?.trim() ?? '';
            if (t.isEmpty) return null;
            final n = int.tryParse(t);
            return (n == null || n < 0) ? l10n.fieldInvalidNumber : null;
          },
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _ergebnis,
          decoration: InputDecoration(labelText: l10n.careFieldErgebnis),
        ),
      ],
      if (kind == CareKind.impfung) ...[
        const SizedBox(height: 12),
        SuggestField(
          controller: _impfstoff,
          label: l10n.careFieldImpfstoff,
          suggestions: sugg(CareFields.impfstoff),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(l10n.careFieldGrundimmunisierung),
          value: _grundimmunisierung,
          onChanged: (v) => setState(() => _grundimmunisierung = v),
        ),
      ],
      if (kind != CareKind.kotprobe) ...[
        const SizedBox(height: 12),
        SuggestField(
          controller: _person,
          label: personLabel,
          suggestions: sugg('person'),
          textCapitalization: TextCapitalization.words,
        ),
      ],
      const SizedBox(height: 12),
      TextFormField(
        controller: _cost,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(labelText: l10n.careFieldCost),
        validator: (v) {
          final t = v?.trim() ?? '';
          if (t.isEmpty) return null;
          final c = Fmt.parseMoneyCents(t);
          return (c == null || c < 0) ? l10n.fieldInvalidNumber : null;
        },
      ),
      const SizedBox(height: 12),
      TextFormField(
        controller: _notes,
        minLines: 2,
        maxLines: 6,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(labelText: l10n.careFieldNotes),
      ),
      ..._repeatSection(l10n, type, hint),
      ..._reminderSection(l10n),
    ];
  }

  List<Widget> _repeatSection(
    AppLocalizations l10n,
    CareType type,
    String? hint,
  ) {
    final defaults = ref.watch(intervalDefaultsProvider).value ?? const [];
    final suggestion = suggestInterval(defaults, type.id, _variant);
    final repeat = _repeat;
    final theme = Theme.of(context);
    return [
      _header(l10n.careSectionRepeat),
      SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(_repeatOn ? l10n.careRepeatAfter : l10n.careRepeatNone),
        value: _repeatOn,
        onChanged: (v) => setState(() {
          _repeatOn = v;
          if (v && _repeatValue.text.isEmpty) {
            _repeatValue.text = (suggestion?.value ?? 6).toString();
            _repeatUnit = suggestion?.unit ?? IntervalUnit.weeks;
          }
        }),
      ),
      if (_repeatOn)
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 96,
              child: TextFormField(
                controller: _repeatValue,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: l10n.careRepeatValue),
                onChanged: (_) => setState(() {}),
                validator: (v) {
                  final n = int.tryParse(v?.trim() ?? '');
                  return (n == null || n <= 0 || n > 999)
                      ? l10n.fieldInvalidNumber
                      : null;
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DropdownButtonFormField<IntervalUnit>(
                initialValue: _repeatUnit,
                decoration: const InputDecoration(),
                items: [
                  for (final u in IntervalUnit.values)
                    DropdownMenuItem(
                      value: u,
                      child: Text(
                        unitLabel(
                          l10n,
                          u,
                          int.tryParse(_repeatValue.text) ?? 2,
                        ),
                      ),
                    ),
                ],
                onChanged: (u) =>
                    setState(() => _repeatUnit = u ?? _repeatUnit),
              ),
            ),
          ],
        ),
      if (_repeatOn && repeat != null)
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            l10n.careRepeatNextOn(Fmt.date(repeat.addTo(_date))),
            style: theme.textTheme.bodyMedium,
          ),
        ),
      if (suggestion != null && suggestion != repeat)
        Align(
          alignment: Alignment.centerLeft,
          child: ActionChip(
            avatar: const Icon(Icons.lightbulb_outline, size: 18),
            label: Text(
              l10n.careRepeatSuggestion(intervalLabel(l10n, suggestion)),
            ),
            onPressed: () => setState(() {
              _repeatOn = true;
              _repeatValue.text = suggestion.value.toString();
              _repeatUnit = suggestion.unit;
            }),
          ),
        ),
      if (hint != null)
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(hint, style: theme.textTheme.bodySmall),
        ),
      Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          l10n.careDisclaimerShort,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    ];
  }

  List<Widget> _reminderSection(AppLocalizations l10n) => [
    _header(l10n.careSectionReminders),
    Wrap(
      spacing: 8,
      runSpacing: 4,
      children: [
        FilterChip(
          label: Text(l10n.careReminderNone),
          selected: _reminders.isEmpty,
          onSelected: (_) => setState(() => _reminders = {}),
        ),
        for (final o in _reminderChoices)
          FilterChip(
            label: Text(
              o == 0 ? l10n.careReminderOnDay : l10n.careReminderDaysBefore(o),
            ),
            selected: _reminders.contains(o),
            onSelected: (on) => setState(() {
              _reminders = {..._reminders};
              on ? _reminders.add(o) : _reminders.remove(o);
            }),
          ),
      ],
    ),
  ];

  Widget _header(String text) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Semantics(
        header: true,
        child: Text(
          text,
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
