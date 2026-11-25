import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/router/routes.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../domain/training.dart';
import '../training_labels.dart';

/// Eine Trainingseinheit in Listen.
class SessionTile extends StatelessWidget {
  const SessionTile({super.key, required this.session, this.dense = false});

  final TrainingSession session;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final s = session;
    final color = levelColor(s.level);
    final cancelled = s.status == SessionStatus.cancelled;
    return ListTile(
      dense: dense,
      leading: CircleAvatar(
        backgroundColor: color.withValues(alpha: 0.2),
        foregroundColor: color,
        child: Text(
          '${s.level}',
          semanticsLabel: l10n.trainingLevel(s.level),
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      title: Text(
        s.title,
        style: cancelled
            ? TextStyle(
                decoration: TextDecoration.lineThrough,
                color: theme.colorScheme.onSurfaceVariant,
              )
            : null,
      ),
      subtitle: Text(
        [
          l10n.trainingSessionMeta(s.level, s.durationMinutes),
          if (s.status != SessionStatus.planned) statusName(l10n, s.status),
          if (s.rating != null) '★ ${s.rating}',
        ].join(' · '),
      ),
      trailing: switch (s.status) {
        SessionStatus.done => Icon(
          Icons.check_circle,
          color: theme.colorScheme.primary,
          semanticLabel: l10n.trainingStatus_done,
        ),
        SessionStatus.cancelled => Icon(
          Icons.cancel_outlined,
          semanticLabel: l10n.trainingStatus_cancelled,
        ),
        SessionStatus.planned =>
          s.pinned
              ? Icon(
                  Icons.push_pin_outlined,
                  semanticLabel: l10n.trainingPinned,
                )
              : null,
      },
      onTap: () => context.push(Routes.trainingEdit(s.id)),
    );
  }
}
