import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_physics/flutter_physics.dart';
import 'package:provider/provider.dart';

import '../../animations/animations.dart';
import '../../core_ui/core_ui.dart';
import '../../utils/utils.dart';
import '../components.dart';

class BButton extends StatelessWidget {
  const BButton({
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.color,
    this.side = BorderSide.none,
    this.cornerRadius = 8.0,
    this.clipBehavior = Clip.antiAlias,
    this.tooltipTriggerMode = TooltipTriggerMode.longPress,
    this.tooltipPreferBelow,
    this.focusNode,
    this.addFeedback = false,
    this.shadows = const [],
    this.onTapDown,
    this.onTapUp,
    required this.tooltip,
    required this.onTap,
    required this.child,
    super.key,
  }) : _getShape = null;

  const BButton.stadium({
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.color,
    this.side = BorderSide.none,
    this.clipBehavior = Clip.antiAlias,
    this.tooltipTriggerMode = TooltipTriggerMode.longPress,
    this.tooltipPreferBelow,
    this.focusNode,
    this.addFeedback = false,
    this.shadows,
    this.onTapDown,
    this.onTapUp,
    required this.tooltip,
    required this.onTap,
    required this.child,
    super.key,
  }) : cornerRadius = 0.0,
       _getShape = _stadiumShape;

  const BButton.circle({
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.color,
    this.side = BorderSide.none,
    this.clipBehavior = Clip.antiAlias,
    this.tooltipTriggerMode = TooltipTriggerMode.longPress,
    this.tooltipPreferBelow,
    this.focusNode,
    this.addFeedback = false,
    this.shadows = const [],
    this.onTapDown,
    this.onTapUp,
    required this.tooltip,
    required this.onTap,
    required this.child,
    super.key,
  }) : cornerRadius = 0.0,
       _getShape = _circleShape;

  static ShapeBorder _stadiumShape(BorderSide side) =>
      SquircleStadiumBorder(side: side);
  static ShapeBorder _circleShape(BorderSide side) => CircleBorder(side: side);

  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final BorderSide side;
  final double cornerRadius;
  final ShapeBorder Function(BorderSide side)? _getShape;
  final List<BoxShadow>? shadows;
  final Color? color;
  final TooltipTriggerMode tooltipTriggerMode;
  final bool? tooltipPreferBelow;
  final FocusNode? focusNode;
  final bool addFeedback;
  final String? tooltip;
  final Clip clipBehavior;
  final VoidCallback? onTap;
  final ValueChanged<TapDownDetails>? onTapDown;
  final ValueChanged<TapUpDetails>? onTapUp;
  final Widget child;

  void _callback() {
    return onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableProvider<FocusNode?>(
      create: (_) => focusNode == null ? FocusNode() : null,
      builder: (context, child) {
        final focusNode = this.focusNode ?? context.watch<FocusNode?>()!;
        final hasFocus = focusNode.hasFocus;
        final extraPadding = hasFocus ? 1.5 : 0.0;
        final side = this.side.copyWith(
          color:
              hasFocus ? CupertinoColors.activeBlue.resolveFrom(context) : null,
          width: hasFocus ? this.side.width * 2.0 : null,
        );
        final backgroundColor =
            hasFocus ? Theme.of(context).highlightColor : color;
        return FocusableActionDetector(
          focusNode: focusNode,
          child: BouncingObject(
            onTap:
                onTap == null
                    ? null
                    : addFeedback
                    ? () {
                      Haptics.selection();
                      Feedback.wrapForTap(_callback, context)?.call();
                    }
                    : _callback,
            onTapDown: onTapDown,
            onTapUp: onTapUp,
            child: AContainer(
              decoration: ShapeDecoration(
                shape:
                    _getShape?.call(side) ??
                    Superellipse.all(cornerRadius + extraPadding, side: side),
                gradient:
                    backgroundColor == null
                        ? null
                        : SmoothGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.center,
                          fromColor: backgroundColor.shade(.05),
                          toColor: backgroundColor,
                          to: .4,
                        ),
                shadows:
                    shadows ??
                    [
                      BoxShadow(
                        color: backgroundColor ?? Colors.black,
                        spreadRadius: 2,
                      ),
                      BoxShadow(
                        color: Colors.white.fade(.3),
                        blurRadius: 1,
                        offset: const Offset(0, -1),
                        blurStyle: BlurStyle.inner,
                      ),
                      const BoxShadow(
                        color: Color(0x33000000),
                        offset: Offset(0, 1),
                      ),
                    ],
              ),
              padding:
                  padding.resolve(Directionality.of(context)) +
                  EdgeInsets.all(extraPadding),
              margin: margin.resolve(Directionality.of(context)),
              clipBehavior: clipBehavior,
              child: PTooltip(
                message: tooltip,
                triggerMode: tooltipTriggerMode,
                preferBelow: tooltipPreferBelow,
                child: DefaultTextStyle(
                  style: context.textTheme.title
                      .addWeight(1)
                      .copyWith(
                        shadows: [
                          Shadow(
                            color: backgroundColor?.shade20 ?? Colors.black38,
                            offset: const Offset(0, .75),
                          ),
                        ],
                      ),
                  child: child!,
                ),
              ),
            ),
          ),
        );
      },
      child: child,
    );
  }
}
