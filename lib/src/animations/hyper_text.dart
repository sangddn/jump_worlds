import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../core_ui/core_ui.dart';

/// A widget that animates text characters.
///
/// This widget is useful for creating a hypertext effect, where text characters
/// are animated to create a dynamic and engaging effect.
///
/// Lightly modified from https://github.com/flutterfx/flutterfx_widgets/blob/main/lib/fx_10_hyper_text/hyper_text.dart
class HyperText extends StatefulWidget {
  const HyperText(
    this.data, {
    super.key,
    this.duration = Effects.shortDuration,
    this.style,
    this.animationTrigger = false,
    this.animateOnLoad = false,
  });

  /// Whether to animate the text on load.
  final bool animateOnLoad;

  /// The animation is triggered when this value changes.
  final bool animationTrigger;

  /// The duration of the animation.
  final Duration duration;

  /// The style of the text.
  final TextStyle? style;

  /// The text to display.
  final String data;

  @override
  State<HyperText> createState() => _HyperTextState();
}

class _HyperTextState extends State<HyperText> {
  int animationCount = 0;
  late List<String> displayText;
  bool isFirstRender = true;
  double iterations = 0;

  final Random _random = Random();
  Timer? _timer;

  @override
  void didUpdateWidget(HyperText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animationTrigger != oldWidget.animationTrigger &&
        widget.animationTrigger) {
      _startAnimation();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    displayText = widget.data.split('');
    if (widget.animateOnLoad) {
      _startAnimation();
    }
  }

  void _startAnimation() {
    iterations = 0;
    _timer?.cancel();
    animationCount++;
    final currentAnimationCount = animationCount;

    _timer = Timer.periodic(
      widget.duration ~/
          (widget.data.isNotEmpty ? widget.data.length * 10 : 10),
      (timer) {
        if (!widget.animateOnLoad && isFirstRender) {
          timer.cancel();
          isFirstRender = false;
          return;
        }
        if (iterations < widget.data.length &&
            currentAnimationCount == animationCount) {
          setState(() {
            displayText = List.generate(
              widget.data.length,
              (i) =>
                  widget.data[i] == ' '
                      ? ' '
                      : i <= iterations
                      ? widget.data[i]
                      : String.fromCharCode(_random.nextInt(26) + 65),
            );
          });
          iterations += 0.1;
        } else {
          timer.cancel();
          if (currentAnimationCount == animationCount) {
            setState(() {
              displayText = widget.data.split('');
            });
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: List.generate(displayText.length, (index) {
          final animatedSwitcher = AnimatedSwitcher(
            duration: const Duration(milliseconds: 50),
            child: Text(
              displayText[index],
              key: ValueKey<String>('$animationCount-$index'),
              style: widget.style,
            ),
          );
          return WidgetSpan(child: animatedSwitcher);
        }),
      ),
    );
  }
}
