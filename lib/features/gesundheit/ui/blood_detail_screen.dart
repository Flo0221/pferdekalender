import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/format/formatters.dart';
import '../../../core/router/routes.dart';
import '../../../core/time/local_date.dart';
import '../../../core/widgets/confirm_dialog.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../futter/ui/feed_providers.dart';
import '../../pflege/ui/care_providers.dart';
import '../domain/blood.dart';
import '../domain/blood_evaluation.dart';
import 'blood_apply.dart';
import 'blood_providers.dart';

/// Auswertung eines Blutbilds mit Übernahme in Futterplan/Kalender.
class BloodDetailScreen extends ConsumerStatefulWidget {
  const BloodDetailScreen({super.key, required this.testId});

  final String testId;

  @override
  ConsumerState<BloodDetailScreen> createState() => _BloodDetailScreenState();
}

class _BloodDetailScreenState extends ConsumerState<BloodDetailScreen> {
  BloodTest? _test;
  Set<String>? _selected;
  bool _applying = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final t = await ref.read(bloodRepositoryProvider).getTest(widget.testId);
    if (mounted) setState(() => _test = t);
  }

  Future<void> _apply(BloodEvaluation e) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final chosen = [
      for (final s in e.suggestions)
        if (_selected!.contains(s.key)) s,
    ];
    if (chosen.isEmpty) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.bloodApplyNothing)));
      return;
    }
    setState(() => _applying = true);
    final r = await applyBloodSuggestions(
      l10n: l10n,
      test: _test!,
      selected: chosen,
      controlWeeks: e.controlWeeks,
      feed: ref.read(feedRepositoryProvider),
      care: ref.read(careRepositoryProvider),
      today: LocalDate.today(),
    );
    if (!mounted) return;
    setState(() => _applying = false);
    messenger.showSnackBar(
      SnackBar(
        content: Text(l10n.bloodApplied(r.supplements, r.events, r.notes)),
      ),
    );
  }

  Future<void> _delete() async {
    final l10n = AppLocalizations.of(context);
    final ok = await showConfirmDialog(
      context,
      title: l10n.bloodDeleteTitle,
      message: l10n.bloodDeleteText,
      confirmLabel: l10n.actionDelete,
      destructive: true,
    );
    if (!ok) return;
    await ref.read(bloodRepositoryProvider).deleteTest(widget.testId);
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final catalog = ref.watch(bloodCatalogProvider).value;
    final test = _test;
    if (catalog == null || test == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final e = evaluate(test, catalog);
    _selected ??= {
      for (final s in e.suggestions)
        // Termine und Futter-Zusätze vorauswählen, aber nicht bei „zuerst
        // Tierarzt“ (dann erst nach Rücksprache).
        if (s.kind == SuggestionKind.care || !e.vetFirst) s.key,
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('${l10n.bloodEvaluation} · ${Fmt.date(test.date)}'),
        actions: [
          IconButton(
            tooltip: l10n.actionEdit,
            icon: const Icon(Icons.edit_outlined),
            onPressed: () async {
              await context.push(Routes.bloodEdit(test.id));
              _selected = null;
              await _load();
            },
          ),
          IconButton(
            tooltip: l10n.actionDelete,
            icon: const Icon(Icons.delete_outline),
            onPressed: _delete,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: [
          Container(
            color: theme.colorScheme.secondaryContainer,
            padding: const EdgeInsets.all(16),
            child: Text(
              catalog.disclaimer,
              style: TextStyle(color: theme.colorScheme.onSecondaryContainer),
            ),
          ),
          if (test.lab != null)
            ListTile(
              leading: const Icon(Icons.science_outlined),
              title: Text(test.lab!),
              subtitle: test.notes == null ? null : Text(test.notes!),
            ),
          _header(l10n.bloodDeviations),
          if (e.deviations.isEmpty)
            ListTile(title: Text(l10n.bloodNoDeviations)),
          for (final f in e.findings)
            ListTile(
              dense: true,
              leading: Icon(
                switch (f.direction) {
                  Direction.high => Icons.arrow_upward,
                  Direction.low => Icons.arrow_downward,
                  null => Icons.check,
                },
                color: f.direction == null
                    ? theme.colorScheme.primary
                    : theme.colorScheme.error,
                semanticLabel: statusText(l10n, f),
              ),
              title: Text(f.parameter.name),
              subtitle: Text(
                '${l10n.bloodRange(rangeText(l10n, f.low, f.high))} ${f.parameter.unit}',
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${Fmt.decimal(f.value.value)} ${f.parameter.unit}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(statusText(l10n, f), style: theme.textTheme.labelSmall),
                ],
              ),
            ),
          if (e.interpretations.isNotEmpty) _header(l10n.bloodEvaluation),
          for (final i in e.interpretations)
            Card(
              margin: const EdgeInsets.fromLTRB(16, 4, 16, 4),
              color: i.vetFirst ? theme.colorScheme.errorContainer : null,
              child: ListTile(
                leading: Icon(
                  i.vetFirst
                      ? Icons.local_hospital_outlined
                      : (i.isCombo ? Icons.hub_outlined : Icons.info_outline),
                  color: i.vetFirst ? theme.colorScheme.onErrorContainer : null,
                ),
                title: Text(
                  i.title,
                  style: TextStyle(
                    color: i.vetFirst
                        ? theme.colorScheme.onErrorContainer
                        : null,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  [i.text, if (i.vetFirst) l10n.bloodVetFirst].join('\n'),
                  style: TextStyle(
                    color: i.vetFirst
                        ? theme.colorScheme.onErrorContainer
                        : null,
                  ),
                ),
              ),
            ),
          if (e.suggestions.isNotEmpty) ...[
            _header(l10n.bloodSuggestions),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Text(
                l10n.bloodSuggestionsHint,
                style: theme.textTheme.bodySmall,
              ),
            ),
            for (final s in e.suggestions)
              CheckboxListTile(
                value: _selected!.contains(s.key),
                onChanged: (v) => setState(
                  () => v == true
                      ? _selected!.add(s.key)
                      : _selected!.remove(s.key),
                ),
                title: Text(s.title),
                subtitle: Text(
                  '${[_kindLabel(l10n, s.kind), if (s.kind == SuggestionKind.supplement && s.weeks != null) l10n.bloodWeeks(s.weeks!), if (s.key == 'kontrolle' && e.controlWeeks != null) l10n.bloodControlIn(e.controlWeeks!), if (s.kind == SuggestionKind.care && s.key != 'kontrolle' && s.inDays != null) l10n.bloodInDays(s.inDays!)].join(' · ')}\n${s.text}',
                ),
                isThreeLine: true,
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: FilledButton.icon(
                icon: const Icon(Icons.playlist_add),
                label: Text(l10n.bloodApply),
                onPressed: _applying ? null : () => _apply(e),
              ),
            ),
          ],
          _header(l10n.bloodSource),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Text(catalog.source, style: theme.textTheme.bodySmall),
          ),
        ],
      ),
    );
  }

  String _kindLabel(AppLocalizations l10n, SuggestionKind k) => switch (k) {
    SuggestionKind.supplement => l10n.bloodKind_supplement,
    SuggestionKind.ration => l10n.bloodKind_ration,
    SuggestionKind.management => l10n.bloodKind_management,
    SuggestionKind.care => l10n.bloodKind_care,
  };

  Widget _header(String text) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
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
