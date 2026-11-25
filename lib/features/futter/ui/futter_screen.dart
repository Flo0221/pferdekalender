import 'package:material_ui/material_ui.dart';

import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/tab_scaffold.dart';
import '../../../l10n/generated/app_localizations.dart';

class FutterScreen extends StatelessWidget {
  const FutterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return TabScaffold(
      title: l10n.titleFutter,
      body: EmptyState(
        icon: Icons.grass_outlined,
        title: l10n.emptyFutterTitle,
        message: l10n.emptyFutterMessage,
      ),
    );
  }
}
