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
    final image = ref.watch(profilePhotoImageProvider(horse));
    final scheme = Theme.of(context).colorScheme;
    final initial = horse.displayName.isEmpty
        ? '?'
        : horse.displayName.characters.first.toUpperCase();
    return ExcludeSemantics(
      child: CircleAvatar(
        radius: radius,
        backgroundColor: scheme.primaryContainer,
        foregroundColor: scheme.onPrimaryContainer,
        foregroundImage: image == null
            ? null
            : ResizeImage(
                image,
                width: (radius * 2 * MediaQuery.devicePixelRatioOf(context))
                    .round(),
              ),
        onForegroundImageError: image == null ? null : (_, _) {},
        child: Text(initial, style: TextStyle(fontSize: radius * 0.9)),
      ),
    );
  }
}
