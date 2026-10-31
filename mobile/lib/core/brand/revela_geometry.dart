import 'dart:math' as math;
import 'dart:ui';

/// Port of reveala/brand/build.py — change both together.
///
/// Two rings: "ta peau" (r1, left) meets "le produit" (r2, right). The lens floats
/// inside their intersection, never touching or covering the rings.
abstract final class RevelaGeometry {
  static const double r1 = 58;
  static const double r2 = 68;
  static const double logoDistance = 72;
  static const double tip = 3;

  /// Air between ring and lens.
  static double gapFor(double ringWidth) => 3 + 0.25 * ringWidth;

  /// Ring centres for a pair whose bounding box is centred on [cx].
  static (double, double) centres(double distance, double cx) {
    final c1 = cx - distance / 2 - (r2 - r1) / 2;
    return (c1, c1 + distance);
  }

  /// Width of the pair's bounding box, rings included.
  static double pairWidth(double distance, double ringWidth) => r1 + r2 + distance + ringWidth;

  /// True when the two rings don't touch at all.
  static bool apart(double distance, double ringWidth) => distance >= r1 + r2 + ringWidth;

  /// Intersection of disc(c1, a) and disc(c2, b), grown by [rnd] so both tips are round.
  /// Null when the discs don't overlap.
  static Path? lens(double c1, double c2, double cy, double a, double b, {double rnd = tip}) {
    final d = c2 - c1;
    if (d >= a + b || d <= (b - a).abs()) return null;
    final x = (d * d + a * a - b * b) / (2 * d);
    final h = math.sqrt(a * a - x * x);
    final px = c1 + x;
    Offset off(double py, double c, double r) => Offset(px + rnd * (px - c) / r, py + rnd * (py - cy) / r);
    final top1 = off(cy - h, c1, a), bot1 = off(cy + h, c1, a); // circle 1's arc: the lens' right edge
    final bot2 = off(cy + h, c2, b), top2 = off(cy - h, c2, b); // circle 2's arc: the lens' left edge
    return Path()
      ..moveTo(top1.dx, top1.dy)
      ..arcToPoint(bot1, radius: Radius.circular(a + rnd), largeArc: x < 0)
      ..arcToPoint(bot2, radius: Radius.circular(rnd))
      ..arcToPoint(top2, radius: Radius.circular(b + rnd), largeArc: d - x < 0)
      ..arcToPoint(top1, radius: Radius.circular(rnd))
      ..close();
  }

  /// The brand lens for rings of [ringWidth]: inset by half the ring, the gap and the tip.
  static Path? floatingLens(double c1, double c2, double cy, double ringWidth) {
    final k = ringWidth / 2 + gapFor(ringWidth) + tip;
    return lens(c1, c2, cy, r1 - k, r2 - k);
  }
}
