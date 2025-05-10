import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

extension WidgetEffects on Animate {
  Animate fadeSlide({
    Duration? delay,
    Duration? duration,
    Curve? curve,
    double? fadeBegin,
    double? fadeEnd,
    Offset? slideBegin,
    Offset? slideEnd,
  }) => fade(
    delay: delay,
    duration: duration,
    curve: curve,
    begin: fadeBegin,
    end: fadeEnd,
  ).slide(duration: duration, curve: curve, begin: slideBegin, end: slideEnd);

  Animate fadeInSlideY({
    Duration? delay,
    Duration? duration,
    Curve? curve,
    double? fadeBegin,
    double? slideBegin,
    double? slideEnd,
  }) => fadeIn(
    delay: delay,
    duration: duration,
    curve: curve,
    begin: fadeBegin,
  ).slideY(duration: duration, curve: curve, begin: slideBegin, end: slideEnd);
}
