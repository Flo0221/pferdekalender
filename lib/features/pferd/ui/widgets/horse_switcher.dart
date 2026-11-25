import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/router/routes.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../domain/horse.dart';
import '../horse_providers.dart';
import 'horse_avatar.dart';

/// Pferde-Umschalter für die AppBar: Avatar + Name, Antippen öffnet die
/// Auswahl. Ohne Pferde wird [fallbackTitle] angezeigt.
class HorseSwitcher extends ConsumerWidget {
  const HorseSwitcher({super.key, required this.fallbackTitle});

  final String fallbackTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedHorseProvider).value;
    if (selected == null) return Text(fallbackTitle);
    final l10n = AppLocalizations.of(context);

    return Semantics(
      button: true,
      label: '${l10n.horseSwitcherTooltip}: ${selected.displayName}',
      excludeSemantics: true,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () => _showPicker(context, ref, selected),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              HorseAvatar(horse: selected),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  selected.displayName,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showPicker(
    BuildContext context,
    WidgetRef ref,
    Horse selected,
  ) async {
    final l10n = AppLocalizations.of(context);
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => Consumer(
        builder: (context, ref, _) {
          final horses = ref.watch(activeHorsesProvider).value ?? const [];
          return SafeArea(
            child: ListView(
              shrinkWrap: true,
              children: [
                for (final h in horses)
                  ListTile(
                    leading: HorseAvatar(horse: h),
                    title: Text(h.displayName),
                    subtitle: h.displayName != h.name ? Text(h.name) : null,
                    trailing: h.id == selected.id
                        ? const Icon(Icons.check)
                        : null,
                    selected: h.id == selected.id,
                    onTap: () {
                      ref.read(horseSelectionProvider).select(h.id);
                      Navigator.pop(sheetContext);
                    },
                  ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.list_alt_outlined),
                  title: Text(l10n.horseSwitcherManage),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    context.push(Routes.horseList);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
