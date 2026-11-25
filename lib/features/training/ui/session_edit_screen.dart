import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/format/formatters.dart';
import '../../../core/time/local_date.dart';
import '../../../core/widgets/confirm_dialog.dart';
import '../../../core/widgets/date_field.dart';
import '../../../core/widgets/minutes_field.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../pferd/ui/horse_providers.dart';
import '../domain/training.dart';
import '../domain/training_catalog.dart';
import 'training_labels.dart';
import 'training_providers.dart';

/// Einheit anlegen ([sessionId] == null) oder bearbeiten.
class SessionEditScreen extends ConsumerStatefulWidget {
  const SessionEditScreen({super.key, this.sessionId, this.initialDate});

  final String? sessionId;
  final LocalDate? initialDate;

  @override
  ConsumerState<SessionEditScreen> createState() => _SessionEditScreenState();
}

class _SessionEditScreenState extends ConsumerState<SessionEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _minutes = TextEditingController(text: '30');
  final _warmup = TextEditingController();
  final _work = TextEditingController();
  final _cooldown = TextEditingController();
  final _notes = TextEditingController();

  TrainingSession? _original;
  late LocalDate _date;
  String? _form;
  int _level = 2;
  SessionStatus _status = SessionStatus.planned;
  int? _rating;
  bool _loading = true;

  bool get _isNew => widget.sessionId == null;

  @override
  void initState() {
    super.initState();
    _date = widget.initialDate ?? LocalDate.today();
    _load();
  }

  Future<void> _load() async {
    if (!_isNew) {
      final s = await ref
          .read(trainingRepositoryProvider)
          .getSession(widget.sessionId!);
      if (s != null) {
        _original = s;
        _date = s.date;
        _form = s.form;
        _level = s.level;
        _status = s.status;
        _rating = s.rating;
        _title.text = s.title;
        _minutes.text = '${s.durationMinutes}';
        _warmup.text = s.content.warmup.join('\n');
        _work.text = s.content.work.join('\n');
        _cooldown.text = s.content.cooldown.join('\n');
        _notes.text = s.notes ?? '';
      }
    }
    if (mounted) setState(() => _loading = false);
  }

  @override
  void dispose() {
    for (final c in [_title, _minutes, _warmup, _work, _cooldown, _notes]) {
      c.dispose();
    }
    super.dispose();
  }

  static List<String> _lines(String text) => [
    for (final l in text.split('\n'))
      if (l.trim().isNotEmpty) l.trim(),
  ];

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final horse = ref.read(selectedHorseProvider).value;
    final o = _original;
    if (o == null && horse == null) return;
    final catalog = ref.read(trainingCatalogProvider).value;
    final moved = o != null && o.date != _date;
    final session = TrainingSession(
      id: o?.id ?? '',
      planId: o?.planId,
      horseId: o?.horseId ?? horse!.id,
      date: _date,
      level: _level,
      durationMinutes: int.parse(_minutes.text.trim()),
      title: _title.text.trim().isEmpty
          ? (catalog?.formName(_form) ??
                levelName(AppLocalizations.of(context), _level))
          : _title.text,
      unitKey: o?.unitKey,
      form: _form,
      content: SessionContent(
        warmup: _lines(_warmup.text),
        work: _lines(_work.text),
        cooldown: _lines(_cooldown.text),
        pauseHint: o?.content.pauseHint,
      ),
      status: _status,
      rating: _status == SessionStatus.done ? _rating : null,
      notes: _notes.text,
      // Manuell angelegt oder verschoben → fixiert (Regel 6).
      pinned: o == null || moved || o.pinned,
      reason: moved ? null : o?.reason,
    );
    await ref.read(trainingRepositoryProvider).saveSession(session);
    if (mounted) context.pop();
  }

  Future<void> _delete() async {
    final l10n = AppLocalizations.of(context);
    final ok = await showConfirmDialog(
      context,
      title: l10n.trainingDeleteTitle,
      message: l10n.trainingDeleteText,
      confirmLabel: l10n.actionDelete,
      destructive: true,
    );
    if (!ok || _original == null) return;
    await ref.read(trainingRepositoryProvider).deleteSession(_original!.id);
    if (mounted) context.pop();
  }

  Future<void> _copy() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final picked = await showDatePicker(
      context: context,
      helpText: l10n.trainingCopyTo,
      initialDate: _date.addDays(7).toLocalDateTime(),
      firstDate: LocalDate.today().addYears(-1).toLocalDateTime(),
      lastDate: LocalDate.today().addYears(2).toLocalDateTime(),
    );
    if (picked == null || _original == null) return;
    final date = LocalDate.fromDateTime(picked);
    await ref.read(trainingRepositoryProvider).copySession(_original!.id, date);
    messenger.showSnackBar(
      SnackBar(content: Text(l10n.trainingCopied(Fmt.date(date)))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final catalog = ref.watch(trainingCatalogProvider).value;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isNew ? l10n.trainingNewSession : l10n.trainingEditSession,
        ),
        actions: [
          if (!_isNew) ...[
            IconButton(
              tooltip: l10n.trainingCopy,
              icon: const Icon(Icons.copy_outlined),
              onPressed: _copy,
            ),
            IconButton(
              tooltip: l10n.actionDelete,
              icon: const Icon(Icons.delete_outline),
              onPressed: _delete,
            ),
          ],
          TextButton(
            onPressed: _loading ? null : _save,
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
                  if (_original != null)
                    Card(
                      child: ExpansionTile(
                        leading: const Icon(Icons.help_outline),
                        title: Text(l10n.trainingWhyHere),
                        childrenPadding: const EdgeInsets.fromLTRB(
                          16,
                          0,
                          16,
                          12,
                        ),
                        expandedAlignment: Alignment.centerLeft,
                        children: [
                          for (final line in reasonLines(
                            l10n,
                            _original!.reason,
                          ))
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Text('• $line'),
                            ),
                          if (_original!.pinned)
                            Text('• ${l10n.trainingPinned}'),
                        ],
                      ),
                    ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _title,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      labelText: l10n.trainingFieldTitle,
                    ),
                  ),
                  const SizedBox(height: 12),
                  DateField(
                    label: l10n.trainingFieldDate,
                    value: _date,
                    clearable: false,
                    lastDate: LocalDate.today().addYears(2),
                    onChanged: (d) => setState(() => _date = d ?? _date),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String?>(
                    initialValue: _form,
                    decoration: InputDecoration(
                      labelText: l10n.trainingFieldForm,
                    ),
                    items: [
                      DropdownMenuItem(
                        value: null,
                        child: Text(l10n.trainingFieldFormNone),
                      ),
                      for (final f in catalog?.forms ?? const <FormInfo>[])
                        DropdownMenuItem(value: f.key, child: Text(f.name)),
                    ],
                    onChanged: (v) => setState(() => _form = v),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.trainingFieldLevel,
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: [
                      for (var l = 0; l <= 5; l++)
                        ChoiceChip(
                          avatar: CircleAvatar(
                            backgroundColor: levelColor(l),
                            radius: 6,
                          ),
                          label: Text('$l · ${levelName(l10n, l)}'),
                          selected: _level == l,
                          onSelected: (_) => setState(() => _level = l),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  MinutesField(
                    controller: _minutes,
                    label: l10n.trainingFieldDuration,
                    choices: const [15, 20, 30, 40, 45, 60, 90],
                    onChanged: () => setState(() {}),
                  ),
                  const SizedBox(height: 16),
                  _multi(_warmup, l10n.trainingFieldWarmup, l10n),
                  _multi(_work, l10n.trainingFieldWork, l10n),
                  _multi(_cooldown, l10n.trainingFieldCooldown, l10n),
                  if (_original?.content.pauseHint case final hint?)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(hint, style: theme.textTheme.bodySmall),
                    ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.trainingFieldStatus,
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 4),
                  SegmentedButton<SessionStatus>(
                    segments: [
                      for (final s in SessionStatus.values)
                        ButtonSegment(
                          value: s,
                          label: Text(statusName(l10n, s)),
                        ),
                    ],
                    selected: {_status},
                    onSelectionChanged: (s) =>
                        setState(() => _status = s.single),
                  ),
                  if (_status == SessionStatus.done) ...[
                    const SizedBox(height: 16),
                    Text(
                      l10n.trainingFieldRating,
                      style: theme.textTheme.bodySmall,
                    ),
                    Row(
                      children: [
                        for (var r = 1; r <= 5; r++)
                          IconButton(
                            tooltip: l10n.trainingFieldRatingValue(r),
                            isSelected: (_rating ?? 0) >= r,
                            icon: const Icon(Icons.star_border),
                            selectedIcon: const Icon(Icons.star),
                            onPressed: () => setState(
                              () => _rating = _rating == r ? null : r,
                            ),
                          ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _notes,
                    minLines: 2,
                    maxLines: 6,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      labelText: l10n.trainingFieldNotes,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _multi(TextEditingController c, String label, AppLocalizations l10n) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: TextFormField(
          controller: c,
          minLines: 1,
          maxLines: 8,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: label,
            helperText: l10n.trainingFieldLinesHint,
          ),
        ),
      );
}
