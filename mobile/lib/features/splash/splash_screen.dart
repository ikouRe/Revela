import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/brand/revela_geometry.dart';
import '../../core/brand/revela_mark.dart';
import '../../core/brand/revela_wordmark.dart';
import '../../core/theme/revela_colors.dart';
import '../../core/theme/revela_motion.dart';

/// "La rencontre": the rings glide together, the lens fills once they meet, the name arrives.
/// Only on the very first launch (1.1 s, or a 300 ms fade with reduced motion). Later launches go
/// straight to the app: the native launch screen is already Nuit, and an app opened several
/// times a day must not make anyone wait.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.next});

  final WidgetBuilder next;

  static const seenKey = 'splash_seen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _t = AnimationController(vsync: this);
  bool _ready = false;
  bool _full = false;
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_started) {
      _started = true;
      _run(MediaQuery.disableAnimationsOf(context));
    }
  }

  Future<void> _run(bool reduceMotion) async {
    final prefs = await SharedPreferences.getInstance();
    final firstLaunch = !(prefs.getBool(SplashScreen.seenKey) ?? false);
    await prefs.setBool(SplashScreen.seenKey, true);
    if (!mounted) return;
    if (!firstLaunch) return _open(Duration.zero);
    setState(() {
      _ready = true;
      _full = !reduceMotion;
    });
    _t.duration = _full ? RevelaMotion.splashFull : RevelaMotion.splashReduced;
    await _t.forward();
    await Future<void>.delayed(RevelaMotion.splashHold);
    if (mounted) _open(RevelaMotion.routeFade);
  }

  void _open(Duration fade) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder<void>(
        pageBuilder: (context, _, _) => widget.next(context),
        transitionDuration: fade,
        transitionsBuilder: (_, animation, _, child) => FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: RevelaMotion.easeOut),
          child: child,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _t.dispose();
    super.dispose();
  }

  /// A phase of the full splash; with reduced motion every phase is already complete.
  Animation<double> _phase((double, double) range) => _full
      ? CurvedAnimation(
          parent: _t,
          curve: Interval(range.$1, range.$2, curve: RevelaMotion.easeOut),
        )
      : kAlwaysCompleteAnimation;

  @override
  Widget build(BuildContext context) {
    if (!_ready) return const Scaffold(backgroundColor: RevelaColors.nuit);
    final width = MediaQuery.sizeOf(context).width * 0.42;
    final name = _phase(RevelaMotion.splashName);
    return Scaffold(
      backgroundColor: RevelaColors.nuit,
      body: Center(
        child: FadeTransition(
          // Reduced motion: the finished mark fades in as a whole.
          opacity: _full ? kAlwaysCompleteAnimation : CurvedAnimation(parent: _t, curve: RevelaMotion.easeOut),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FadeTransition(
                opacity: _phase(RevelaMotion.splashRings), // the rings never pop in from the launch screen
                child: CustomPaint(
                  size: Size(
                    width,
                    width * (2 * RevelaGeometry.r2 + 7) / RevelaGeometry.pairWidth(RevelaGeometry.logoDistance, 7),
                  ),
                  painter: _SplashMarkPainter(_phase(RevelaMotion.splashMeet), _phase(RevelaMotion.splashLens), _t),
                ),
              ),
              const SizedBox(height: 40),
              FadeTransition(
                opacity: name,
                child: ScaleTransition(
                  scale: Tween(begin: RevelaMotion.splashNameScaleFrom, end: 1.0).animate(name),
                  child: const RevelaWordmark(height: 18, color: RevelaColors.nacre),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Repaints from the controller: no widget rebuild per frame.
class _SplashMarkPainter extends RevelaMarkPainter {
  _SplashMarkPainter(this.meet, this.lens, Listenable repaint)
    : super(
        distance: RevelaGeometry.logoDistance,
        maxDistance: RevelaGeometry.logoDistance,
        ringColor: RevelaColors.nacre,
        lensColor: RevelaColors.uv,
        repaint: repaint,
      );

  final Animation<double> meet;
  final Animation<double> lens;

  @override
  void paint(Canvas canvas, Size size) {
    final d =
        RevelaMotion.splashStartDistance +
        (RevelaGeometry.logoDistance - RevelaMotion.splashStartDistance) * meet.value;
    paintAt(canvas, size, d, lensColor, lens.value);
  }

  @override
  bool shouldRepaint(_SplashMarkPainter old) => old.meet != meet || old.lens != lens;
}
