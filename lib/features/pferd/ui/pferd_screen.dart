import 'package:material_ui/material_ui.dart';

import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/tab_scaffold.dart';
import '../../../l10n/generated/app_localizations.dart';

class PferdScreen extends StatelessWidget {
  const PferdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return TabScaffold(
      title: l10n.titlePferd,
      body: EmptyState(
        icon: Icons.pets_outlined,
        title: l10n.emptyPferdTitle,
        message: l10n.emptyPferdMessage,
      ),
    );
  }
}
