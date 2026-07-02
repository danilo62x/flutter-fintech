import 'package:flutter/material.dart';

/// Draws a decorative, QR-like matrix with a CustomPainter (no image/network).
///
/// It is not a scannable code — the module pattern is derived deterministically
/// from [data] so the same key always paints the same picture, with the three
/// finder squares in the corners that make it read as a real QR code.
class QrPainter extends CustomPainter {
  QrPainter({
    required this.data,
    required this.foreground,
    required this.background,
    this.modules = 29,
  });

  final String data;
  final Color foreground;
  final Color background;
  final int modules;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = background;
    final RRect card = RRect.fromRectAndRadius(
      Offset.zero & size,
      const Radius.circular(16),
    );
    canvas.drawRRect(card, bg);

    // Quiet zone: keep a 2-module margin.
    const int quiet = 2;
    final int grid = modules + quiet * 2;
    final double cell = size.width / grid;
    final Paint fg = Paint()..color = foreground;

    final int seed = data.hashCode;

    bool isFinder(int x, int y) {
      bool inBox(int ox, int oy) =>
          x >= ox && x < ox + 7 && y >= oy && y < oy + 7;
      return inBox(0, 0) || inBox(modules - 7, 0) || inBox(0, modules - 7);
    }

    for (int y = 0; y < modules; y++) {
      for (int x = 0; x < modules; x++) {
        if (isFinder(x, y)) continue;
        // Deterministic pseudo-random fill.
        final int h = (x * 73856093) ^ (y * 19349663) ^ seed;
        if ((h & 3) == 0 || (h & 7) == 3) {
          final double px = (x + quiet) * cell;
          final double py = (y + quiet) * cell;
          canvas.drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromLTWH(px, py, cell * 0.92, cell * 0.92),
              Radius.circular(cell * 0.25),
            ),
            fg,
          );
        }
      }
    }

    void drawFinder(int gx, int gy) {
      final double x = (gx + quiet) * cell;
      final double y = (gy + quiet) * cell;
      final double outer = cell * 7;
      // Outer ring.
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, y, outer, outer),
          Radius.circular(cell * 1.6),
        ),
        fg,
      );
      // Inner cut-out.
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x + cell, y + cell, cell * 5, cell * 5),
          Radius.circular(cell * 1.1),
        ),
        Paint()..color = background,
      );
      // Center dot.
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x + cell * 2, y + cell * 2, cell * 3, cell * 3),
          Radius.circular(cell * 0.8),
        ),
        fg,
      );
    }

    drawFinder(0, 0);
    drawFinder(modules - 7, 0);
    drawFinder(0, modules - 7);
  }

  @override
  bool shouldRepaint(covariant QrPainter oldDelegate) {
    return oldDelegate.data != data ||
        oldDelegate.foreground != foreground ||
        oldDelegate.background != background;
  }
}
