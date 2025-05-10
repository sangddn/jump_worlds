import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

/// {@template route_transition_animation}
/// A thin wrapper that bundles the two `Animation<double>`s that Flutter gives
/// each `PageRoute` (`primary` and `secondary`) into a single
/// `Animation<(double,double)>`.
///
/// ### Why bother?
///
/// * **One place to listen** – Widgets can `context.watch<RouteTransitionAnimation>()`
///   and always get “whatever’s moving”, whether the page is entering, exiting,
///   half-covered, or being interactively dragged back.
/// * **Status propagation** – `AnimationStatus` listeners also work; the class
///   forwards the status of whichever child animation is currently active.
/// * **Route-agnostic** – It needs no knowledge of the `Route` itself; you can
///   hand it any two animations and it just works.
///
/// ```text
/// push:   [underlying ——> secondary]  ← slight shift
///         [incoming   ——> primary  ]  ← full slide in
///
/// pop:    reverse the same logic
/// ```
/// {@endtemplate}
final class RouteTransitionAnimation extends Animation<(double, double)>
    with
        AnimationLazyListenerMixin,
        AnimationLocalListenersMixin,
        AnimationLocalStatusListenersMixin {
  /// Creates a wrapper for the two route animations.
  ///
  /// Both animations must be non-null and have the usual `AnimationStatus`
  /// semantics (`forward == push`, `reverse == pop`).
  ///
  /// {@macro animations.transitions.route_transition_animation}
  RouteTransitionAnimation({required this.primary, required this.secondary});

  /// Shorthand to grab the nearest animation from a `Provider`.
  ///
  /// {@macro animations.transitions.route_transition_animation}
  static RouteTransitionAnimation of(
    BuildContext context, {
    bool listen = false,
  }) => Provider.of<RouteTransitionAnimation>(context, listen: listen);

  /// The animation driving the **top** route.
  final Animation<double> primary;

  /// The animation driving the route immediately **under** the top.
  final Animation<double> secondary;

  /// Whichever animation is *currently* changing.
  ///
  /// Priority:
  /// 1. An animation whose `isAnimating` is `true`.
  /// 2. An animation whose value is strictly between 0 and 1
  ///    (covers interactive swipe where `isAnimating == false`).
  /// 3. Fallback to [primary] if both are idle at a bound.
  Animation<double> get active {
    if (primary.isAnimating) return primary;
    if (secondary.isAnimating) return secondary;

    final primaryMid = primary.value != 0 && primary.value != 1;
    if (primaryMid) return primary;

    final secondaryMid = secondary.value != 0 && secondary.value != 1;
    if (secondaryMid) return secondary;

    return primary;
  }

  /// `true` while the primary route is being **pushed**.
  bool get isPush =>
      primary.isAnimating && primary.status == AnimationStatus.forward;

  /// `true` while the primary route is being **popped**.
  bool get isPop =>
      primary.isAnimating && primary.status == AnimationStatus.reverse;

  @override
  (double, double) get value => (primary.value, secondary.value);

  /// The status of whichever child animation is active.
  @override
  AnimationStatus get status => active.status;

  void _forwardStatus(AnimationStatus _) => notifyStatusListeners(status);

  @override
  void didStartListening() {
    primary.addListener(notifyListeners);
    secondary.addListener(notifyListeners);
    primary.addStatusListener(_forwardStatus);
    secondary.addStatusListener(_forwardStatus);
  }

  @override
  void didStopListening() {
    primary.removeListener(notifyListeners);
    secondary.removeListener(notifyListeners);
    primary.removeStatusListener(_forwardStatus);
    secondary.removeStatusListener(_forwardStatus);
  }

  @override
  String toString() =>
      'RouteTransitionAnimation(primary: $primary, secondary: $secondary)';
}
