import 'package:material_ui/material_ui.dart';

import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/tab_scaffold.dart';
import '../../../l10n/generated/app_localizations.dart';

class DienstplanScreen extends StatelessWidget {
  const DienstplanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return TabScaffold(
      title: l10n.titleDienst,
      body: EmptyState(
        icon: Icons.work_history_outlined,
        title: l10n.emptyDienstTitle,
        message: l10n.emptyDienstMessage,
      ),
    );
  }
}
