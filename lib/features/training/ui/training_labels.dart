import 'package:material_ui/material_ui.dart';

import '../../../core/format/formatters.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../domain/training.dart';

/// Farbe je Belastungsstufe (0–5): grün → rot.
const levelColors = <int>[
  0xFF9E9E9E,
  0xFF81C784,
  0xFF4DB6AC,
  0xFFFFB74D,
  0xFFF4511E,
  0xFFC62828,
];

Color levelColor(int level) => Color(levelColors[level.clamp(0, 5)]);

String levelName(AppLocalizations l10n, int level) => switch (level) {
  0 => l10n.trainingLevel_0,
  1 => l10n.trainingLevel_1,
  2 => l10n.trainingLevel_2,
  3 => l10n.trainingLevel_3,
  4 => l10n.trainingLevel_4,
  _ => l10n.trainingLevel_5,
};

String goalName(AppLocalizations l10n, TrainingGoal g) => switch (g) {
  TrainingGoal.muskelaufbau => l10n.trainingGoal_muskelaufbau,
  TrainingGoal.muskelerhalt => l10n.trainingGoal_muskelerhalt,
  TrainingGoal.kondition => l10n.trainingGoal_kondition,
  TrainingGoal.wiedereinstieg => l10n.trainingGoal_wiedereinstieg,
};

String goalHint(AppLocalizations l10n, TrainingGoal g) => switch (g) {
  TrainingGoal.muskelaufbau => l10n.trainingGoalHint_muskelaufbau,
  TrainingGoal.muskelerhalt => l10n.trainingGoalHint_muskelerhalt,
  TrainingGoal.kondition => l10n.trainingGoalHint_kondition,
  TrainingGoal.wiedereinstieg => l10n.trainingGoalHint_wiedereinstieg,
};

String statusName(AppLocalizations l10n, SessionStatus s) => switch (s) {
  SessionStatus.planned => l10n.trainingStatus_planned,
  SessionStatus.done => l10n.trainingStatus_done,
  SessionStatus.cancelled => l10n.trainingStatus_cancelled,
};

/// Begründung als Textzeilen (Regel 8).
List<String> reasonLines(AppLocalizations l10n, SessionReason? r) {
  if (r == null) return [l10n.trainingReasonManual];
  return [
    if (r.availableMinutes != null)
      r.assumedMinutes
          ? l10n.trainingReasonAssumed(r.availableMinutes!)
          : l10n.trainingReasonMinutes(
              r.shiftName == null ? '' : '${r.shiftName}, ',
              r.availableMinutes!,
            ),
    if (r.daysSinceIntensive != null)
      l10n.trainingReasonSinceIntensive(r.daysSinceIntensive!)
    else
      l10n.trainingReasonNoIntensive,
    if (r.intensive) l10n.trainingReasonIntensive,
    if (r.activePause) l10n.trainingReasonActivePause,
    if (r.afterNightShift) l10n.trainingReasonAfterNight,
    if (r.recoveryAfterHigh) l10n.trainingReasonRecovery,
    if (r.downgradedFrom != null)
      l10n.trainingReasonDowngraded(r.downgradedFrom!),
  ];
}

/// Belastungspunkte hübsch („12,5“).
String points(double p) => Fmt.decimal(p);
