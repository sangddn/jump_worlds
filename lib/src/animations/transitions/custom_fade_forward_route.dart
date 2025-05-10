import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'transitions.dart';

/// A custom version of [FadeForwardsPageTransitionsBuilder] that uses a more
/// engaging transition curve and exposes the [RouteTransitionAnimation] as a
/// [ListenableProvider].
class CustomFadeForwardsTransitionsBuilder
    extends FadeForwardsPageTransitionsBuilder {
  /// Constructs a page transition animation that matches the transition used on
  /// Android U.
  const CustomFadeForwardsTransitionsBuilder({super.backgroundColor});

  @override
  DelegatedTransitionBuilder? get delegatedTransition => (
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    bool allowSnapshotting,
    Widget? child,
  ) {
    return RouteTransitionAnimationProvider(
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
  };

  @override
  Widget buildTransitions<T>(
    PageRoute<T>? route,
    BuildContext? context,
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
