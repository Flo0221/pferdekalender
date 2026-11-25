import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../domain/horse.dart';
import '../horse_providers.dart';

/// Rundes Profilbild eines Pferdes; ohne Foto der Anfangsbuchstabe.
class HorseAvatar extends ConsumerWidget {
  const HorseAvatar({super.key, required this.horse, this.radius = 18});

  final Horse horse;
  final double radius;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final file = ref.watch(profilePhotoFileProvider(horse));
    final scheme = Theme.of(context).colorScheme;
    final initial = horse.displayName.isEmpty
        ? '?'
        : horse.displayName.characters.first.toUpperCase();
    return ExcludeSemantics(
      child: CircleAvatar(
        radius: radius,
        backgroundColor: scheme.primaryContainer,
        foregroundColor: scheme.onPrimaryContainer,
        foregroundImage: file == null
            ? null
            : ResizeImage(
                FileImage(file),
                width: (radius * 2 * MediaQuery.devicePixelRatioOf(context))
                    .round(),
              ),
        onForegroundImageError: file == null ? null : (_, _) {},
        child: Text(initial, style: TextStyle(fontSize: radius * 0.9)),
      ),
    );
  }
}
