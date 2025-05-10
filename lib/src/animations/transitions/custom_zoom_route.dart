import 'package:flutter/material.dart';

import '../animations.dart';

class CustomZoomTransitionsBuilder extends ZoomPageTransitionsBuilder {
  /// Constructs a page transition animation that matches the transition used on
  /// Android Q.
  const CustomZoomTransitionsBuilder({
    super.allowSnapshotting = true,
    super.allowEnterRouteSnapshotting = true,
    super.backgroundColor,
  });

  @override
  DelegatedTransitionBuilder get delegatedTransition =>
      (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        bool allowSnapshotting,
        Widget? child,
      ) => RouteTransitionAnimationProvider(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        child:
            super.delegatedTransition!(
              context,
              animation,
              secondaryAnimation,
              allowSnapshotting,
              child,
            )!,
      );

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return RouteTransitionAnimationProvider(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      child: super.buildTransitions(
        route,
        context,
        animation,
        secondaryAnimation,
        child,
      ),
    );
  }
}
