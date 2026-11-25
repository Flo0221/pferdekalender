import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/widgets/confirm_dialog.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../domain/horse.dart';
import '../horse_providers.dart';
import 'section_card.dart';

class PhotosSection extends ConsumerWidget {
  const PhotosSection({super.key, required this.horse});

  final Horse horse;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final photos = ref.watch(horsePhotosProvider(horse.id)).value ?? const [];
    return SectionCard(
      title: l10n.horseSectionPhotos,
      action: IconButton(
        tooltip: l10n.photoAdd,
        icon: const Icon(Icons.add_a_photo_outlined),
        onPressed: () => _add(context, ref),
      ),
      child: photos.isEmpty
          ? Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Text(l10n.photosEmpty),
            )
          : SizedBox(
              height: 112,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                itemCount: photos.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, i) =>
                    _Thumb(horse: horse, photo: photos[i], index: i + 1),
              ),
            ),
    );
  }

  Future<void> _add(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: Text(l10n.photoFromGallery),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: Text(l10n.photoFromCamera),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
          ],
        ),
      ),
    );
    if (source == null) return;
    try {
      // Web: kleiner speichern (kein Dateisystem, Speicher im Browser
      // begrenzt) – längste Seite 1600 px, JPEG ~80 %.
      final picked = await ImagePicker().pickImage(
        source: source,
        maxWidth: kIsWeb ? 1600 : 2400,
        maxHeight: kIsWeb ? 1600 : 2400,
        imageQuality: kIsWeb ? 80 : 85,
      );
      if (picked == null) return;
      final repo = ref.read(horseRepositoryProvider);
      if (kIsWeb) {
        await repo.addPhoto(
          horse.id,
          null,
          bytes: await picked.readAsBytes(),
          extension: '.jpg',
        );
      } else {
        await repo.addPhoto(horse.id, picked.path);
      }
    } on Exception {
      messenger.showSnackBar(SnackBar(content: Text(l10n.photoError)));
    }
  }
}

class _Thumb extends ConsumerWidget {
  const _Thumb({required this.horse, required this.photo, required this.index});

  final Horse horse;
  final HorsePhoto photo;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final image = ref.watch(photoImageProvider(photo.relativePath));
    final isProfile = horse.profilePhotoId == photo.id;
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      button: true,
      label:
          '${l10n.photoOf(horse.displayName)} $index'
          '${isProfile ? ', ${l10n.photoIsProfile}' : ''}',
      excludeSemantics: true,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _open(context, ref),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 104,
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest,
              border: isProfile
                  ? Border.all(color: scheme.primary, width: 3)
                  : null,
              borderRadius: BorderRadius.circular(12),
            ),
            child: image == null
                ? null
                : Image(
                    image: ResizeImage(image, width: 312),
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) =>
                        const Icon(Icons.broken_image_outlined),
                  ),
          ),
        ),
      ),
    );
  }

  Future<void> _open(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final image = ref.read(photoImageProvider(photo.relativePath));
    final repo = ref.read(horseRepositoryProvider);
    final isProfile = horse.profilePhotoId == photo.id;
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => Dialog(
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (image != null)
              Flexible(
                child: InteractiveViewer(
                  child: Image(
                    image: image,
                    semanticLabel: l10n.photoOf(horse.displayName),
                  ),
                ),
              ),
            OverflowBar(
              alignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  icon: const Icon(Icons.delete_outline),
                  label: Text(l10n.actionDelete),
                  onPressed: () async {
                    final ok = await showConfirmDialog(
                      dialogContext,
                      title: l10n.photoDeleteConfirm,
                      message: l10n.photoDeleteConfirmText,
                      confirmLabel: l10n.actionDelete,
                      destructive: true,
                    );
                    if (!ok) return;
                    await repo.deletePhoto(photo.id);
                    if (dialogContext.mounted) Navigator.pop(dialogContext);
                  },
                ),
                if (!isProfile)
                  TextButton.icon(
                    icon: const Icon(Icons.account_circle_outlined),
                    label: Text(l10n.photoSetProfile),
                    onPressed: () async {
                      await repo.setProfilePhoto(horse.id, photo.id);
                      if (dialogContext.mounted) Navigator.pop(dialogContext);
                    },
                  ),
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: Text(l10n.actionClose),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
