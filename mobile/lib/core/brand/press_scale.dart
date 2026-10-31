import 'package:flutter/material.dart';

import '../theme/revela_motion.dart';

/// Press feedback: shrink to 0.97 on press-in, commit on release. Same on iOS and Android.
class PressScale extends StatefulWidget {
  const PressScale({super.key, required this.child, required this.onTap});

  final Widget child;
  final VoidCallback onTap;

  @override
  State<PressScale> createState() => _PressScaleState();
}

class _PressScaleState extends State<PressScale> {
  bool _down = false;

  void _set(bool down) {
    if (_down != down) setState(() => _down = down);
  }

  @override
  Widget build(BuildContext context) {
    // Feedback on the raw pointer: GestureDetector.onTapDown waits ~100 ms inside a scrollable
    // (and fires with onTapUp on a quick tap), so the press would show late or not at all.
    return Listener(
      behavior: HitTestBehavior.opaque,
      onPointerDown: (_) => _set(true),
      onPointerUp: (_) => _set(false),
      onPointerCancel: (_) => _set(false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapCancel: () => _set(false), // the list started scrolling
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _down ? RevelaMotion.pressScale : 1,
          duration: RevelaMotion.press,
          curve: RevelaMotion.easeOut,
          child: widget.child,
        ),
      ),
    );
  }
}
