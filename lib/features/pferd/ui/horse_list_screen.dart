import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/router/routes.dart';
import '../../../core/widgets/confirm_dialog.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../domain/horse.dart';
import 'horse_providers.dart';
import 'widgets/horse_avatar.dart';

/// Alle Pferde: aktive oben, archivierte darunter.
class HorseListScreen extends ConsumerWidget {
  const HorseListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final active = ref.watch(activeHorsesProvider).value ?? const <Horse>[];
    final archived = ref.watch(archivedHorsesProvider).value ?? const <Horse>[];
    final selectedId = ref.watch(selectedHorseProvider).value?.id;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.horseListTitle)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(Routes.horseNew),
        icon: const Icon(Icons.add),
        label: Text(l10n.horseAdd),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 96),
        children: [
          _Header(l10n.horseListActive),
          for (final h in active)
            ListTile(
              leading: HorseAvatar(horse: h),
              title: Text(h.displayName),
              subtitle: h.displayName != h.name ? Text(h.name) : null,
              selected: h.id == selectedId,
              onTap: () {
                ref.read(horseSelectionProvider).select(h.id);
                context.pop();
              },
              trailing: _HorseMenu(horse: h),
            ),
          _Header(l10n.horseListArchived),
          if (archived.isEmpty)
            ListTile(title: Text(l10n.horseListEmptyArchived))
          else
            for (final h in archived)
              ListTile(
                leading: Opacity(opacity: 0.6, child: HorseAvatar(horse: h)),
                title: Text(h.displayName),
                trailing: _HorseMenu(horse: h),
              ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
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

enum _MenuAction { edit, archive, unarchive, delete }

class _HorseMenu extends ConsumerWidget {
  const _HorseMenu({required this.horse});
  final Horse horse;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return PopupMenuButton<_MenuAction>(
      onSelected: (action) => _handle(context, ref, action),
      itemBuilder: (context) => [
        PopupMenuItem(value: _MenuAction.edit, child: Text(l10n.actionEdit)),
        if (horse.archived)
          PopupMenuItem(
            value: _MenuAction.unarchive,
            child: Text(l10n.horseUnarchive),
          )
        else
          PopupMenuItem(
            value: _MenuAction.archive,
            child: Text(l10n.horseArchive),
          ),
        PopupMenuItem(
          value: _MenuAction.delete,
          child: Text(l10n.horseDeleteForever),
        ),
      ],
    );
  }

  Future<void> _handle(
    BuildContext context,
    WidgetRef ref,
    _MenuAction action,
  ) async {
    final l10n = AppLocalizations.of(context);
    final repo = ref.read(horseRepositoryProvider);
    final messenger = ScaffoldMessenger.of(context);
    switch (action) {
      case _MenuAction.edit:
        await context.push(Routes.horseEdit(horse.id));
      case _MenuAction.archive:
        final ok = await showConfirmDialog(
          context,
          title: l10n.horseArchiveConfirmTitle(horse.displayName),
          message: l10n.horseArchiveConfirmText,
          confirmLabel: l10n.horseArchive,
        );
        if (ok) {
          await repo.setArchived(horse.id, archived: true);
          messenger.showSnackBar(
            SnackBar(content: Text(l10n.horseArchived(horse.displayName))),
          );
        }
      case _MenuAction.unarchive:
        await repo.setArchived(horse.id, archived: false);
      case _MenuAction.delete:
        // Doppelte Bestätigung: erst Warnung, dann Namen eintippen.
        final first = await showConfirmDialog(
          context,
          title: l10n.horseDeleteConfirmTitle(horse.displayName),
          message: l10n.horseDeleteConfirmText,
          confirmLabel: l10n.horseDeleteConfirmContinue,
          destructive: true,
        );
        if (!first || !context.mounted) return;
        final second = await showTypeToConfirmDialog(
          context,
          title: l10n.horseDeleteConfirmTitle(horse.displayName),
          prompt: l10n.horseDeleteTypeName(horse.name),
          expected: horse.name,
          confirmLabel: l10n.horseDeleteForever,
        );
        if (!second) return;
        await repo.deleteHorsePermanently(horse.id);
        messenger.showSnackBar(
          SnackBar(content: Text(l10n.horseDeleted(horse.displayName))),
        );
    }
  }
}
