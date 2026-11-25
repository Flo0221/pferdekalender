import 'package:material_ui/material_ui.dart';

import '../../domain/shift.dart';

/// Farbiges Kürzel einer Schicht (z. B. „F“ auf gelb).
class ShiftBadge extends StatelessWidget {
  const ShiftBadge({super.key, required this.template, this.size = 36});

  final ShiftTemplate template;
  final double size;

  @override
  Widget build(BuildContext context) {
    final color = Color(template.colorValue);
    final onColor =
        ThemeData.estimateBrightnessForColor(color) == Brightness.dark
        ? Colors.white
        : Colors.black;
    return ExcludeSemantics(
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(size / 4),
        ),
        child: Text(
          template.shortCode,
          style: TextStyle(color: onColor, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
