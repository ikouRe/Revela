import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';

import '../theme/revela_colors.dart';
import '../theme/revela_motion.dart';
import 'revela_geometry.dart';
import 'revela_mark.dart';
import 'verdict.dart';

/// "Ta peau" meets "le produit": the closer the rings, the larger the revealed lens.
/// Purpose: state indication. Motion runs in the painter (repaint: controller), never via setState.
class VerdictIndicator extends StatefulWidget {
  const VerdictIndicator({super.key, required this.verdict, this.width = 240, this.ringColor, this.animate = true});

  final Verdict verdict;
  final double width;
  final Color? ringColor;

  /// false shows the final state at once, with no haptic — for a result the user already
  /// knows (history), where the reveal would teach nothing.
  final bool animate;

  /// Lerps only between two known verdicts. Arriving from (or leaving to) INCONNU, the lens keeps
  /// the known verdict's colour: a COMPATIBLE result must never flash red or amber on its way in.
  static Color lensColor(Verdict from, Verdict to, double distance) {
    if (to == Verdict.inconnu) return from.color;
    if (from == Verdict.inconnu) return to.color;
    return _VerdictPainter.colorAt(distance);
  }

  @override
  State<VerdictIndicator> createState() => _VerdictIndicatorState();
}

class _VerdictIndicatorState extends State<VerdictIndicator> with SingleTickerProviderStateMixin {
  static const _ringWidth = 7.0;

  late final AnimationController _distance = AnimationController.unbounded(vsync: this, value: Verdict.inconnu.distance)
    ..addListener(_hapticOnLanding);

  double? _target;
  bool _landed = true;
  Verdict _from = Verdict.inconnu;
  Verdict _to = Verdict.inconnu;
  Animation<double>? _route;

  // One haptic per verdict, the frame the rings visually land — not when the spring's
  // tail reaches its numeric tolerance much later.
  void _hapticOnLanding() {
    final target = _target;
    if (_landed || target == null) return;
    if ((_distance.value - target).abs() <= RevelaMotion.verdictHapticWithin) {
      _landed = true;
      HapticFeedback.lightImpact();
    }
  }

  bool _revealed = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // First reveal needs MediaQuery (reduced motion), which initState can't read.
    if (_revealed) return;
    _revealed = true;
    final route = ModalRoute.of(context)?.animation;
    if (!widget.animate || route == null || route.value >= RevelaMotion.verdictRevealAtPush) {
      _settleTo(widget.verdict);
    } else {
      // One thing moves at a time: the rings start as the page push lands, not under it.
      _route = route..addListener(_revealWithRoute);
    }
  }

  void _revealWithRoute() {
    if (_route!.value < RevelaMotion.verdictRevealAtPush) return;
    _stopWaitingForRoute();
    if (_target == null) _settleTo(widget.verdict);
  }

  void _stopWaitingForRoute() {
    _route?.removeListener(_revealWithRoute);
    _route = null;
  }

  @override
  void didUpdateWidget(VerdictIndicator old) {
    super.didUpdateWidget(old);
    if (old.verdict != widget.verdict) {
      _stopWaitingForRoute();
      _settleTo(widget.verdict);
    }
  }

  void _settleTo(Verdict v) {
    _target = v.distance;
    _from = _to;
    _to = v;
    if (!widget.animate || MediaQuery.disableAnimationsOf(context)) {
      _landed = true;
      _distance.value = v.distance;
      return;
    }
    _landed = false;
    // No overshoot: a verdict is information, not a toy. Starts from the current value and
    // velocity, so a new verdict mid-flight redirects smoothly instead of restarting.
    _distance.animateWith(
      SpringSimulation(RevelaMotion.verdictSpring, _distance.value, v.distance, _distance.velocity),
    );
  }

  @override
  void dispose() {
    _stopWaitingForRoute();
    _distance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height =
        widget.width *
        (2 * RevelaGeometry.r2 + _ringWidth) /
        RevelaGeometry.pairWidth(Verdict.inconnu.distance, _ringWidth);
    return Semantics(
      label: widget.verdict.label,
      // The spring repaints only this layer, not the screen around it.
      child: RepaintBoundary(
        child: CustomPaint(
          size: Size(widget.width, height),
          painter: _VerdictPainter(_distance, widget.ringColor ?? Theme.of(context).colorScheme.onSurface, _from, _to),
        ),
      ),
    );
  }
}

class _VerdictPainter extends RevelaMarkPainter {
  _VerdictPainter(this.animation, Color ringColor, this.from, this.to)
    : super(
        distance: Verdict.inconnu.distance,
        maxDistance: Verdict.inconnu.distance,
        ringColor: ringColor,
        lensColor: RevelaColors.uv,
        dashedWhenApart: true,
        repaint: animation,
      );

  final Animation<double> animation;
  final Verdict from;
  final Verdict to;

  /// The lens colour follows the distance, so a change of verdict travels through the scale
  /// (compatible → prudence → déconseillé) instead of snapping.
  static Color colorAt(double d) {
    const a = Verdict.compatible, b = Verdict.prudence, c = Verdict.deconseille;
    if (d <= a.distance) return a.color;
    if (d <= b.distance) return Color.lerp(a.color, b.color, (d - a.distance) / (b.distance - a.distance))!;
    if (d <= c.distance) return Color.lerp(b.color, c.color, (d - b.distance) / (c.distance - b.distance))!;
    return c.color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final d = animation.value;
    paintAt(canvas, size, d, VerdictIndicator.lensColor(from, to, d), 1);
  }

  @override
  bool shouldRepaint(_VerdictPainter old) =>
      old.animation != animation || old.ringColor != ringColor || old.from != from || old.to != to;
}

/// RG-37 label: colour + icon + text, never colour alone.
class VerdictBadge extends StatelessWidget {
  const VerdictBadge({super.key, required this.verdict});

  final Verdict verdict;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 6, 14, 6),
      decoration: BoxDecoration(color: verdict.color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(999)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(color: verdict.color, shape: BoxShape.circle),
            child: Icon(verdict.icon, size: 15, color: Colors.white),
          ),
          const SizedBox(width: 8),
          Text(verdict.label, style: Theme.of(context).textTheme.labelLarge),
        ],
      ),
    );
  }
}
