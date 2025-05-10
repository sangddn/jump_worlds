import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'transitions.dart';

class RouteTransitionAnimationProvider extends StatelessWidget {
  const RouteTransitionAnimationProvider({
    super.key,
    required this.animation,
    required this.secondaryAnimation,
    required this.child,
  });

  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final hasActiveParentRta = context.select((RouteTransitionAnimation? rta) {
      return rta != null && rta.isAnimating;
    });
    // Do not override the parent RTA if it is animating.
    if (hasActiveParentRta) return child;
    return ListenableProvider<RouteTransitionAnimation>.value(
      value: RouteTransitionAnimation(
        primary: animation,
        secondary: secondaryAnimation,
      ),
      child: child,
    );
  }
}
