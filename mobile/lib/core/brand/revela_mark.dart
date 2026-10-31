import 'package:flutter/material.dart';

import '../theme/revela_colors.dart';
import 'revela_geometry.dart';

/// The Revela symbol: two rings and the floating lens.
class RevelaMark extends StatelessWidget {
  const RevelaMark({super.key, this.size = 96, this.ringColor, this.lensColor = RevelaColors.uv, this.ringWidth = 7});

  /// Width of the symbol; height follows the rings' aspect.
  final double size;

  /// Defaults to the theme's onSurface, so the mark reads on light and dark.
  final Color? ringColor;
  final Color lensColor;

  /// In 256-grid units. Use 16 for the small-size cut (<= 48 px).
  final double ringWidth;

  @override
  Widget build(BuildContext context) {
    final w = RevelaGeometry.pairWidth(RevelaGeometry.logoDistance, ringWidth);
    return Semantics(
      label: 'Revela',
      child: CustomPaint(
        size: Size(size, size * (2 * RevelaGeometry.r2 + ringWidth) / w),
        painter: RevelaMarkPainter(
          distance: RevelaGeometry.logoDistance,
          ringColor: ringColor ?? Theme.of(context).colorScheme.onSurface,
          lensColor: lensColor,
          ringWidth: ringWidth,
        ),
      ),
    );
  }
}

/// Paints the rings at [distance]. [maxDistance] fixes the scale so the pair never
/// rescales while animating; [lensOpacity] lets the splash fill the lens in.
class RevelaMarkPainter extends CustomPainter {
  RevelaMarkPainter({
    required this.distance,
    required this.ringColor,
    required this.lensColor,
    this.ringWidth = 7,
    double? maxDistance,
    this.lensOpacity = 1,
    this.dashedWhenApart = false,
    super.repaint,
  }) : maxDistance = maxDistance ?? distance;

  final double distance;
  final double maxDistance;
  final Color ringColor;
  final Color lensColor;
  final double ringWidth;
  final double lensOpacity;
  final bool dashedWhenApart;

  @override
  void paint(Canvas canvas, Size size) {
    paintAt(canvas, size, distance, lensColor, lensOpacity);
  }

  /// Shared with animated painters that compute distance and colour per frame.
  void paintAt(Canvas canvas, Size size, double d, Color lens, double opacity) {
    final scale = size.width / RevelaGeometry.pairWidth(maxDistance, ringWidth);
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.scale(scale);
    final (c1, c2) = RevelaGeometry.centres(d, 0);
    final ring = Paint()
      ..color = ringColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = ringWidth;
    final dashed = dashedWhenApart && RevelaGeometry.apart(d, ringWidth);
    for (final (c, r) in [(c1, RevelaGeometry.r1), (c2, RevelaGeometry.r2)]) {
      final circle = Path()..addOval(Rect.fromCircle(center: Offset(c, 0), radius: r));
      canvas.drawPath(dashed ? _dash(circle, 10, 8) : circle, ring);
    }
    final lensPath = RevelaGeometry.floatingLens(c1, c2, 0, ringWidth);
    if (lensPath != null && opacity > 0) {
      canvas.drawPath(lensPath, Paint()..color = lens.withValues(alpha: lens.a * opacity));
    }
    canvas.restore();
  }

  static Path _dash(Path source, double on, double off) {
    final out = Path();
    for (final metric in source.computeMetrics()) {
      for (var t = 0.0; t < metric.length; t += on + off) {
        out.addPath(metric.extractPath(t, t + on), Offset.zero);
      }
    }
    return out;
  }

  @override
  bool shouldRepaint(RevelaMarkPainter old) =>
      old.distance != distance ||
      old.maxDistance != maxDistance ||
      old.ringColor != ringColor ||
      old.lensColor != lensColor ||
      old.ringWidth != ringWidth ||
      old.lensOpacity != lensOpacity ||
      old.dashedWhenApart != dashedWhenApart;
}
