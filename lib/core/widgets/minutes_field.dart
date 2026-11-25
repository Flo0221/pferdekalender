import 'package:material_ui/material_ui.dart';

import '../../l10n/generated/app_localizations.dart';

/// Minuten-Eingabe mit Schnellwahl-Chips (0, 30, 60, …).
class MinutesField extends StatelessWidget {
  const MinutesField({
    super.key,
    required this.controller,
    required this.label,
    this.helper,
    this.choices = const [0, 20, 30, 45, 60, 90, 120, 150, 180],
    this.onChanged,
  });

  final TextEditingController controller;
  final String label;
  final String? helper;
  final List<int> choices;
  final VoidCallback? onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final current = int.tryParse(controller.text.trim());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: label,
            helperText: helper,
            helperMaxLines: 3,
            suffixText: 'min',
          ),
          onChanged: (_) => onChanged?.call(),
          validator: (v) {
            final n = int.tryParse(v?.trim() ?? '');
            return (n == null || n < 0 || n > 24 * 60)
                ? l10n.fieldInvalidNumber
                : null;
          },
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 4,
          children: [
            for (final c in choices)
              ChoiceChip(
                label: Text(l10n.minutesValue(c)),
                selected: current == c,
                onSelected: (_) {
                  controller.text = '$c';
                  onChanged?.call();
                },
              ),
          ],
        ),
      ],
    );
  }
}
