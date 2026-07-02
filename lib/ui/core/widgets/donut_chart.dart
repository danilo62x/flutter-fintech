import 'dart:math' as math;

import 'package:flutter/material.dart';

/// A single slice of the donut chart.
class DonutSlice {
  const DonutSlice({required this.value, required this.color});

  final double value;
  final Color color;
}

/// Donut / ring chart drawn entirely with a CustomPainter.
class DonutChart extends StatelessWidget {
  const DonutChart({
    super.key,
    required this.slices,
    required this.centerTop,
    required this.centerBottom,
    this.size = 168,
    this.stroke = 26,
  });

  final List<DonutSlice> slices;
  final String centerTop;
  final String centerBottom;
  final double size;
  final double stroke;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _DonutPainter(
          slices: slices,
          stroke: stroke,
          track: scheme.surfaceContainerHighest,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                centerTop,
                style: textTheme.labelMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                centerBottom,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  _DonutPainter({
    required this.slices,
    required this.stroke,
    required this.track,
  });

  final List<DonutSlice> slices;
  final double stroke;
  final Color track;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Rect arcRect = rect.deflate(stroke / 2 + 2);
    final double total =
        slices.fold<double>(0, (double s, DonutSlice e) => s + e.value);

    final Paint trackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..color = track;
    canvas.drawArc(arcRect, 0, 2 * math.pi, false, trackPaint);

    if (total <= 0) return;

    const double gap = 0.05;
    double start = -math.pi / 2 + gap / 2;
    for (final DonutSlice slice in slices) {
      final double sweep = (slice.value / total) * (2 * math.pi) - gap;
      final Paint p = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..strokeCap = StrokeCap.round
        ..color = slice.color;
      canvas.drawArc(arcRect, start, sweep < 0 ? 0 : sweep, false, p);
      start += sweep + gap;
    }
  }

  @override
  bool shouldRepaint(covariant _DonutPainter oldDelegate) => true;
}
