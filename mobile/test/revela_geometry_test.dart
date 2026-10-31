import 'package:flutter_test/flutter_test.dart';
import 'package:revela/core/brand/revela_geometry.dart';
import 'package:revela/core/brand/verdict.dart';

void main() {
  const w = 7.0;

  // Path.getBounds() is loose around arcs, so measure on points sampled along the outline.
  List<Offset> outline(double d) {
    final (c1, c2) = RevelaGeometry.centres(d, 0);
    final lens = RevelaGeometry.floatingLens(c1, c2, 0, w);
    if (lens == null) return const [];
    return [
      for (final m in lens.computeMetrics())
        for (var t = 0.0; t <= m.length; t += 0.5) m.getTangentForOffset(t)!.position,
    ];
  }

  double lensWidth(double d) {
    final pts = outline(d);
    if (pts.isEmpty) return 0;
    final xs = pts.map((p) => p.dx);
    return xs.reduce((a, b) => a > b ? a : b) - xs.reduce((a, b) => a < b ? a : b);
  }

  test('the lens never touches the rings', () {
    final inner1 = RevelaGeometry.r1 - w / 2 - RevelaGeometry.gapFor(w) + 0.01;
    final inner2 = RevelaGeometry.r2 - w / 2 - RevelaGeometry.gapFor(w) + 0.01;
    for (var d = 30.0; d <= 110; d += 2) {
      final (c1, c2) = RevelaGeometry.centres(d, 0);
      for (final p in outline(d)) {
        expect((p - Offset(c1, 0)).distance, lessThanOrEqualTo(inner1), reason: 'd=$d');
        expect((p - Offset(c2, 0)).distance, lessThanOrEqualTo(inner2), reason: 'd=$d');
      }
    }
  });

  test('the closer the verdict, the larger the revealed lens', () {
    expect(lensWidth(Verdict.compatible.distance), greaterThan(lensWidth(Verdict.prudence.distance)));
    expect(lensWidth(Verdict.prudence.distance), greaterThan(lensWidth(Verdict.deconseille.distance)));
    expect(lensWidth(Verdict.deconseille.distance), greaterThan(8)); // still visible
  });

  test('INCONNU reveals nothing and keeps the rings apart', () {
    expect(lensWidth(Verdict.inconnu.distance), 0);
    expect(RevelaGeometry.apart(Verdict.inconnu.distance, w), isTrue);
    expect(RevelaGeometry.apart(Verdict.deconseille.distance, w), isFalse);
  });

  test('the logo lens matches brand/build.py', () {
    // build.py: inset radii r - (w/2 + gap + tip), tips grown back by tip
    final width = lensWidth(RevelaGeometry.logoDistance);
    final k = w / 2 + RevelaGeometry.gapFor(w) + RevelaGeometry.tip;
    final expected =
        (RevelaGeometry.r1 - k) + (RevelaGeometry.r2 - k) - RevelaGeometry.logoDistance + 2 * RevelaGeometry.tip;
    expect(width, closeTo(expected, 0.5));
  });
}
