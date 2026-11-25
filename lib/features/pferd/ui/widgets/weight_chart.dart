import 'package:material_ui/material_ui.dart';

import '../../../../core/format/formatters.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../domain/horse.dart';

/// Kleines Liniendiagramm des Gewichtsverlaufs (ohne externe Bibliothek).
/// Die x-Achse ist zeitlich skaliert, nicht nach Eintragsindex.
class WeightChart extends StatelessWidget {
  const WeightChart({super.key, required this.entries, this.height = 140});

  /// Älteste zuerst, mindestens zwei Einträge.
  final List<WeightEntry> entries;
  final double height;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme.labelSmall!;
    final weights = entries.map((e) => e.weightKg);
    final min = weights.reduce((a, b) => a < b ? a : b);
    final max = weights.reduce((a, b) => a > b ? a : b);
    return Semantics(
      label: l10n.weightChartLabel(
        Fmt.date(entries.first.date),
        Fmt.date(entries.last.date),
        Fmt.decimal(min),
        Fmt.decimal(max),
      ),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: CustomPaint(
          painter: _WeightPainter(
            entries: entries,
            min: min,
            max: max,
            line: scheme.primary,
            grid: scheme.outlineVariant,
            textStyle: textStyle.copyWith(color: scheme.onSurfaceVariant),
          ),
        ),
      ),
    );
  }
}

class _WeightPainter extends CustomPainter {
  _WeightPainter({
    required this.entries,
    required this.min,
    required this.max,
    required this.line,
    required this.grid,
    required this.textStyle,
  });

  final List<WeightEntry> entries;
  final double min;
  final double max;
  final Color line;
  final Color grid;
  final TextStyle textStyle;

  @override
  void paint(Canvas canvas, Size size) {
    const leftPad = 44.0;
    const bottomPad = 18.0;
    const topPad = 8.0;
    final chart = Rect.fromLTRB(
      leftPad,
      topPad,
      size.width - 8,
      size.height - bottomPad,
    );

    // Wertebereich etwas aufweiten, damit flache Verläufe lesbar bleiben.
    final span = (max - min).abs() < 1 ? 10.0 : (max - min);
    final lo = min - span * 0.15;
    final hi = max + span * 0.15;

    final firstDay = entries.first.date;
    final totalDays = firstDay.daysUntil(entries.last.date).clamp(1, 1 << 30);

    Offset point(WeightEntry e) => Offset(
      chart.left + chart.width * firstDay.daysUntil(e.date) / totalDays,
      chart.bottom - chart.height * (e.weightKg - lo) / (hi - lo),
    );

    final gridPaint = Paint()
      ..color = grid
      ..strokeWidth = 1;
    for (final v in [min, max]) {
      final y = chart.bottom - chart.height * (v - lo) / (hi - lo);
      canvas.drawLine(Offset(chart.left, y), Offset(chart.right, y), gridPaint);
      _text(canvas, Fmt.decimal(v), Offset(0, y - 7), leftPad - 6, right: true);
    }
    _text(
      canvas,
      Fmt.dateShort(entries.first.date),
      Offset(chart.left, chart.bottom + 3),
      80,
    );
    _text(
      canvas,
      Fmt.dateShort(entries.last.date),
      Offset(chart.right - 80, chart.bottom + 3),
      80,
      right: true,
    );

    final path = Path();
    for (var i = 0; i < entries.length; i++) {
      final p = point(entries[i]);
      i == 0 ? path.moveTo(p.dx, p.dy) : path.lineTo(p.dx, p.dy);
    }
    canvas.drawPath(
      path,
      Paint()
        ..color = line
        ..strokeWidth = 2.5
        ..style = PaintingStyle.stroke
        ..strokeJoin = StrokeJoin.round,
    );
    final dot = Paint()..color = line;
    for (final e in entries) {
      canvas.drawCircle(point(e), 3.5, dot);
    }
  }

  void _text(
    Canvas canvas,
    String s,
    Offset at,
    double width, {
    bool right = false,
  }) {
    final tp = TextPainter(
      text: TextSpan(text: s, style: textStyle),
      textDirection: TextDirection.ltr,
      textAlign: right ? TextAlign.right : TextAlign.left,
      maxLines: 1,
    )..layout(minWidth: width, maxWidth: width);
    tp.paint(canvas, at);
  }

  @override
  bool shouldRepaint(_WeightPainter old) =>
      old.entries != entries || old.line != line || old.grid != grid;
}
