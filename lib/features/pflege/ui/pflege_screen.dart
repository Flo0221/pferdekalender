import 'package:material_ui/material_ui.dart';

import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/tab_scaffold.dart';
import '../../../l10n/generated/app_localizations.dart';

class PflegeScreen extends StatelessWidget {
  const PflegeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return TabScaffold(
      title: l10n.titlePflege,
      body: EmptyState(
        icon: Icons.healing_outlined,
        title: l10n.emptyPflegeTitle,
        message: l10n.emptyPflegeMessage,
      ),
    );
  }
}
