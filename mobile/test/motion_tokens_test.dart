import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:revela/core/brand/verdict.dart';
import 'package:revela/core/theme/revela_motion.dart';

/// The prototype (brand/prototype) reads the same JSON: if this fails, the app and the
/// prototype no longer move the same way.
void main() {
  final json = jsonDecode(File('../docs/design/motion-tokens.json').readAsStringSync()) as Map<String, dynamic>;
  List<double> nums(Object? v) => [for (final n in v as List) (n as num).toDouble()];
  int ms(String k) => (json['durationsMs'] as Map)[k] as int;

  test('curves', () {
    final c = json['curves'] as Map;
    for (final (name, cubic) in [
      ('easeOut', RevelaMotion.easeOut),
      ('easeInOut', RevelaMotion.easeInOut),
      ('sheet', RevelaMotion.sheet),
    ]) {
      expect(nums(c[name]), [cubic.a, cubic.b, cubic.c, cubic.d], reason: name);
    }
  });

  test('durations', () {
    expect(RevelaMotion.press.inMilliseconds, ms('press'));
    expect(RevelaMotion.select.inMilliseconds, ms('select'));
    expect(RevelaMotion.routeFade.inMilliseconds, ms('routeFade'));
    expect(RevelaMotion.push.inMilliseconds, ms('push'));
    expect(RevelaMotion.sheetDuration.inMilliseconds, ms('sheet'));
    expect(RevelaMotion.splashFull.inMilliseconds, ms('splashFull'));
    expect(RevelaMotion.splashReduced.inMilliseconds, ms('splashReduced'));
    expect(RevelaMotion.splashHold.inMilliseconds, ms('splashHold'));
    expect(RevelaMotion.scanLock.inMilliseconds, ms('scanLock'));
    expect(RevelaMotion.badgeDelay.inMilliseconds, ms('badgeDelay'));
  });

  test('splash, press and spring', () {
    final s = json['splash'] as Map;
    (double, double) range(String k) => (nums(s[k])[0], nums(s[k])[1]);
    expect(RevelaMotion.splashStartDistance, s['startDistance']);
    expect(RevelaMotion.splashRings, range('rings'));
    expect(RevelaMotion.splashMeet, range('meet'));
    expect(RevelaMotion.splashLens, range('lens'));
    expect(RevelaMotion.splashName, range('name'));
    expect(RevelaMotion.splashNameScaleFrom, s['nameScaleFrom']);
    expect(RevelaMotion.pressScale, (json['press'] as Map)['scale']);
    final v = json['verdictSpring'] as Map;
    expect(RevelaMotion.verdictSpringDuration.inMilliseconds, v['durationMs']);
    expect(RevelaMotion.verdictSpringBounce, v['bounce']);
    expect(RevelaMotion.verdictHapticWithin, v['hapticWithin']);
    expect(RevelaMotion.verdictRevealAtPush, v['revealAtPush']);
  });

  test('verdict distances', () {
    final d = json['verdictDistance'] as Map;
    for (final v in Verdict.values) {
      expect(v.distance, d[v.name], reason: v.name);
    }
  });

  test('ease-out is a real strong ease-out (no ease-in on UI)', () {
    expect(RevelaMotion.easeOut.transform(0.25), greaterThan(0.6));
  });
}
