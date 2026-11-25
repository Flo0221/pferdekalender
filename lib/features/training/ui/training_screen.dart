import 'package:material_ui/material_ui.dart';

import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/tab_scaffold.dart';
import '../../../l10n/generated/app_localizations.dart';

class TrainingScreen extends StatelessWidget {
  const TrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return TabScaffold(
      title: l10n.titleTraining,
      body: EmptyState(
        icon: Icons.fitness_center_outlined,
        title: l10n.emptyTrainingTitle,
        message: l10n.emptyTrainingMessage,
      ),
    );
  }
}
