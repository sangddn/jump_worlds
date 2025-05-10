import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../transitions/route_transition_animation.dart';

enum RouteTransitionAdapterType {
  /// Use the primary animation only.
  primaryOnly,

  /// Use the secondary animation only.
  secondaryOnly,

  /// Use the primary animation if the route is on top, or the secondary
  /// animation if the route is below the primary route.
  adaptive,
}

/// {@template animations.adapters.route_transition_adapter}
/// A route transition adapter drives an [Animate] animation based on a
/// [RouteTransitionAnimation].
///
/// For example, this starts fading/sliding in the text with the primary route
/// transition:
///
/// ```
/// Text("Hello").animate(
///   adapter: RouteTransitionAdapter.primaryOf(context),
/// ).fadeIn().slide();
/// ```
///
/// Note that this remains static when another route is pushed on top of it,
/// since `.primaryOf` only listens to the primary animation.
///
/// Usually, you'd use this adapter with an extension method from
/// [RouteTransitionExtension] to animate a widget with the route that it's
/// inside:
///
/// ```
/// Text("Hello").animateWithRoute(context).fadeIn().slide();
/// ```
///
/// Super parameters:
/// - [super.direction]: whether to only trigger updates when the route is being
///   pushed or popped respectively.
/// {@endtemplate}
final class RouteTransitionAdapter extends Adapter {
  /// Creates a [RouteTransitionAdapter] from a [RouteTransitionAnimation].
  ///
  /// {@macro animations.adapters.route_transition_adapter}
  RouteTransitionAdapter(
    this.animation, {
    this.type = RouteTransitionAdapterType.adaptive,
    this.transform,
    super.direction,
  });

  /// Creates a [RouteTransitionAdapter] from the nearest [RouteTransitionAnimation]
  /// in the widget tree.
  ///
  /// {@macro animations.adapters.route_transition_adapter}
  RouteTransitionAdapter.of(
    BuildContext context, {
    this.type = RouteTransitionAdapterType.adaptive,
    this.transform,
    super.direction,
  }) : animation = RouteTransitionAnimation.of(context);

  /// The [RouteTransitionAnimation] that this adapter is driving.
  final RouteTransitionAnimation animation;

  /// Whether to trigger updates when the route is driven by the
  /// primary or secondary animation or both (adaptive based on the position
  /// of the route in the stack).
  final RouteTransitionAdapterType type;

  /// An optional transform function to apply to the value.
  final double Function(double)? transform;

  double _getValue() {
    final effectiveAnimation = switch (type) {
      RouteTransitionAdapterType.primaryOnly => animation.primary,
      RouteTransitionAdapterType.secondaryOnly => animation.secondary,
      RouteTransitionAdapterType.adaptive => animation.active,
    };
    final value = effectiveAnimation.value;
    return transform?.call(value) ?? value;
  }

  void _notify() {
    final value = _getValue();
    updateValue(value);
  }

  @override
  void attach(AnimationController controller) {
    animation.addListener(_notify);
    config(controller, _getValue());
  }

  @override
  void detach() {
    super.detach();
    animation.removeListener(_notify);
  }
}

extension RouteTransitionExtension on Widget {
  /// Animates the widget with the route transition animation.
  ///
  /// {@macro animations.adapters.route_transition_adapter}
  Animate animateWithRoute(
    BuildContext context, {
    Direction? direction,
    RouteTransitionAdapterType type = RouteTransitionAdapterType.adaptive,
    double Function(double)? transform,
    // ignore: strict_raw_type
    List<Effect>? effects,
    AnimateCallback? onInit,
    AnimateCallback? onPlay,
    AnimateCallback? onComplete,
    bool autoPlay = true,
    AnimationController? controller,
  }) => animate(
    adapter: RouteTransitionAdapter.of(
      context,
      direction: direction,
      type: type,
      transform: transform,
    ),
    effects: effects,
    onInit: onInit,
    onPlay: onPlay,
    onComplete: onComplete,
    autoPlay: autoPlay,
    controller: controller,
  );
}
