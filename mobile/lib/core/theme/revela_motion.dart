import 'package:flutter/animation.dart';

/// Revela motion tokens — identical to docs/design/motion-tokens.json
/// (canonical copy: reveala/brand/motion/motion-tokens.json). test/motion_tokens_test.dart
/// fails if the two drift apart.
abstract final class RevelaMotion {
  // Never ease-in on UI: it delays the moment the user is watching.
  static const easeOut = Cubic(0.23, 1, 0.32, 1);
  static const easeInOut = Cubic(0.77, 0, 0.175, 1);
  static const sheet = Cubic(0.32, 0.72, 0, 1);

  static const press = Duration(milliseconds: 120);
  static const select = Duration(milliseconds: 180);
  static const routeFade = Duration(milliseconds: 300);
  static const push = Duration(milliseconds: 350);
  static const sheetDuration = Duration(milliseconds: 300);
  static const splashFull = Duration(milliseconds: 1100);

  /// First launch with reduced motion: the finished mark fades in. Later launches show no splash.
  static const splashReduced = Duration(milliseconds: 300);
  static const splashHold = Duration(milliseconds: 250);
  static const scanLock = Duration(milliseconds: 160);

  /// The verdict badge and sentence follow the spring's start by this much.
  static const badgeDelay = Duration(milliseconds: 80);

  static const pressScale = 0.97;

  static const splashStartDistance = 260.0;
  static const splashRings = (0.0, 0.14);
  static const splashMeet = (0.0, 0.75);
  static const splashLens = (0.5, 0.8);
  static const splashName = (0.65, 1.0);
  static const splashNameScaleFrom = 0.96;

  static const verdictSpringDuration = Duration(milliseconds: 400);
  static const verdictSpringBounce = 0.0;

  /// Haptic fires when the rings visually land (within this many grid units),
  /// not when the simulation's tail reaches its numeric tolerance ~0.8 s later.
  static const verdictHapticWithin = 0.5;

  /// The reveal starts when the incoming page has covered 70% of its push.
  static const verdictRevealAtPush = 0.7;

  static final verdictSpring = SpringDescription.withDurationAndBounce(
    duration: verdictSpringDuration,
    bounce: verdictSpringBounce,
  );
}
