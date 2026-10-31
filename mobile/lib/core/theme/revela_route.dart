import 'package:flutter/material.dart';

import 'revela_motion.dart';

/// Screen-to-screen push, same as brand/prototype: 350 ms on the sheet curve, the new page slides
/// in from the right while the old one drifts 30% left. Reduced motion: a 300 ms fade instead.
// shortcut: no iOS edge-swipe back; switch to CupertinoRouteTransitionMixin if users ask for it.
class RevelaPageRoute<T> extends PageRoute<T> {
  RevelaPageRoute({required this.builder, super.settings});

  final WidgetBuilder builder;

  bool get _reduced {
    final context = navigator?.context;
    return context != null && MediaQuery.maybeDisableAnimationsOf(context) == true;
  }

  @override
  Duration get transitionDuration => _reduced ? RevelaMotion.routeFade : RevelaMotion.push;

  @override
  bool get opaque => true;

  @override
  bool get barrierDismissible => false;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) =>
      builder(context);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (MediaQuery.disableAnimationsOf(context)) {
      return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: RevelaMotion.easeOut),
        child: child,
      );
    }
    return SlideTransition(
      position: Tween(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: RevelaMotion.sheet)),
      child: SlideTransition(
        position: Tween(
          begin: Offset.zero,
          end: const Offset(-0.3, 0),
        ).animate(CurvedAnimation(parent: secondaryAnimation, curve: RevelaMotion.sheet)),
        child: child,
      ),
    );
  }
}
