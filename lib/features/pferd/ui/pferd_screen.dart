import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/format/formatters.dart';
import '../../../core/router/routes.dart';
import '../../../core/time/local_date.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/tab_scaffold.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../domain/horse.dart';
import 'horse_labels.dart';
import 'horse_providers.dart';
import 'widgets/contacts_section.dart';
import 'widgets/horse_avatar.dart';
import 'widgets/photos_section.dart';
import 'widgets/section_card.dart';
import 'widgets/weight_section.dart';

/// Tab „Pferd“: Profil des ausgewählten Pferdes.
class PferdScreen extends ConsumerWidget {
  const PferdScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final selected = ref.watch(selectedHorseProvider);
    final horse = selected.value;

    return TabScaffold(
      title: l10n.titlePferd,
      actions: [
        if (horse != null)
          IconButton(
            tooltip: l10n.actionEdit,
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => context.push(Routes.horseEdit(horse.id)),
          ),
        IconButton(
          tooltip: l10n.horseSwitcherManage,
          icon: const Icon(Icons.list_alt_outlined),
          onPressed: () => context.push(Routes.horseList),
        ),
      ],
      body: switch (selected) {
        AsyncData(value: final Horse h) => _Profile(horse: h),
        AsyncData() => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EmptyState(
              icon: Icons.pets_outlined,
              title: l10n.emptyPferdTitle,
              message: l10n.emptyPferdMessage,
            ),
            FilledButton.icon(
              onPressed: () => context.push(Routes.horseNew),
              icon: const Icon(Icons.add),
              label: Text(l10n.emptyPferdAction),
            ),
          ],
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

class _Profile extends StatelessWidget {
  const _Profile({required this.horse});

  final Horse horse;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final h = horse;
    String? height() =>
        h.heightCm == null ? null : l10n.horseHeightValue(h.heightCm!);

    final groups = <(String, List<(String, String?)>)>[
      (
        l10n.horseSectionGeneral,
        [
          (l10n.horseFieldName, h.callName == null ? null : h.name),
          (l10n.horseFieldBreed, h.breed),
          (l10n.horseFieldColor, h.colorMarkings),
          (l10n.horseFieldHeight, height()),
        ],
      ),
      (
        l10n.horseSectionIdentification,
        [
          (l10n.horseFieldUeln, h.ueln),
          (l10n.horseFieldChip, h.chipNumber),
          (l10n.horseFieldPassport, h.passportNumber),
        ],
      ),
      (
        l10n.horseSectionPedigree,
        [(l10n.horseFieldSire, h.sire), (l10n.horseFieldDam, h.dam)],
      ),
      (
        l10n.horseSectionKeeping,
        [
          (l10n.horseFieldStable, h.stableLocation),
          (l10n.horseFieldKeeping, h.keepingType),
          (l10n.horseFieldOwner, h.owner),
          (l10n.horseFieldInsurance, h.insurance),
        ],
      ),
      (
        l10n.horseSectionHealth,
        [
          (l10n.horseFieldIntolerances, h.intolerances),
          (l10n.horseFieldMedicalHistory, h.medicalHistory),
        ],
      ),
      (l10n.horseSectionNotes, [(l10n.horseFieldNotes, h.notes)]),
    ];
    final filled = [
      for (final (title, fields) in groups)
        if (fields.any((f) => f.$2 != null))
          (
            title,
            [
              for (final f in fields)
                if (f.$2 != null) f,
            ],
          ),
    ];

    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        _Header(horse: h),
        if (filled.isEmpty)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(l10n.profileNoData, textAlign: TextAlign.center),
          ),
        for (final (title, fields) in filled)
          SectionCard(
            title: title,
            child: Column(
              children: [
                for (final (label, value) in fields)
                  ListTile(
                    dense: true,
                    title: Text(label),
                    subtitle: SelectableText(
                      value!,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
              ],
            ),
          ),
        ContactsSection(horse: h),
        WeightSection(horse: h),
        PhotosSection(horse: h),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.horse});

  final Horse horse;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final age = ageLabel(l10n, horse.birthDate, LocalDate.today());
    final facts = [
      ?horse.sex?.label(l10n),
      if (age != null)
        l10n.ageBirthday(age, Fmt.date(horse.birthDate!))
      else if (horse.birthDate != null)
        Fmt.date(horse.birthDate!),
      ?horse.breed,
    ];
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          HorseAvatar(horse: horse, radius: 44),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(horse.displayName, style: theme.textTheme.headlineSmall),
                if (facts.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(facts.join(' · '), style: theme.textTheme.bodyMedium),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
