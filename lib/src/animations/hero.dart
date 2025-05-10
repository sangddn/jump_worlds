import 'package:flutter/material.dart';

extension HeroFlightDirectionX on HeroFlightDirection {
  bool get isPush => this == HeroFlightDirection.push;
  bool get isPop => this == HeroFlightDirection.pop;
}

class HeroContainer extends StatelessWidget {
  const HeroContainer({
    super.key,
    required this.tag,
    this.createRectTween,
    this.placeholderBuilder,
    this.transitionOnUserGestures = false,
    this.fromDecoration,
    this.toDecoration,
    this.fadeContent = false,
    this.fromFlightBuilder,
    this.toFlightBuilder,
    required this.child,
  });

  final Object tag;
  final CreateRectTween? createRectTween;
  final HeroPlaceholderBuilder? placeholderBuilder;
  final bool transitionOnUserGestures;
  final ShapeDecoration? fromDecoration;
  final ShapeDecoration? toDecoration;
  final bool fadeContent;
  final Widget Function(BuildContext, double)? fromFlightBuilder;
  final Widget Function(BuildContext, double)? toFlightBuilder;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      createRectTween: createRectTween,
      placeholderBuilder: placeholderBuilder,
      transitionOnUserGestures: transitionOnUserGestures,
      flightShuttleBuilder: (_, anim, dir, _, toHeroContext) {
        return Material(
          color: Colors.transparent,
          child: AnimatedBuilder(
            animation: anim,
            builder: (context, child) {
              final isPush = dir.isPush;
              final value = anim.value;
              var child =
                  isPush
                      ? fromFlightBuilder?.call(context, value)
                      : toFlightBuilder?.call(context, value);
              child ??= (toHeroContext.widget as Hero).child;
              return Container(
                decoration: Decoration.lerp(
                  toDecoration,
                  fromDecoration,
                  value,
                ),
                child:
                    fadeContent
                        ? Opacity(
                          opacity: isPush ? value : 1.0 - value,
                          child: child,
                        )
                        : child,
              );
            },
          ),
        );
      },
      child: child,
    );
  }
}
