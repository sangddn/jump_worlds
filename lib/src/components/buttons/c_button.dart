import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core_ui/core_ui.dart';
import '../components.dart';

class CButton extends StatelessWidget {
  const CButton({
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.color,
    this.side = BorderSide.none,
    this.cornerRadius = 2.0,
    this.clipBehavior = Clip.antiAlias,
    this.pressedOpacity = 0.4,
    this.tooltipTriggerMode = TooltipTriggerMode.longPress,
    this.tooltipPreferBelow,
    this.focusNode,
    this.addFeedback = false,
    this.mouseCursor = SystemMouseCursors.basic,
    this.highlightColor,
    this.hoverColor,
    this.focusColor,
    this.onHover,
    required this.tooltip,
    required this.onTap,
    required this.child,
    super.key,
  }) : assert(tooltip is String? || tooltip is InlineSpan?);

  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final BorderSide side;
  final double cornerRadius;
  final double pressedOpacity;
  final Color? color, highlightColor, focusColor, hoverColor;
  final TooltipTriggerMode tooltipTriggerMode;
  final bool? tooltipPreferBelow;
  final FocusNode? focusNode;
  final bool addFeedback;

  /// The tooltip to show when the button is pressed.
  ///
  /// Can be a [String]? or an [InlineSpan]?.
  ///
  final dynamic tooltip;
  final MouseCursor? mouseCursor;
  final Clip clipBehavior;
  final ValueChanged<bool>? onHover;
  final VoidCallback? onTap;
  final Widget child;

  void _callback() {
    return onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableProvider<FocusNode>(
      create: (_) => focusNode ?? FocusNode(),
      builder: (context, child) {
        final hasFocus = context.watch<FocusNode>().hasFocus;
        final extraPadding = hasFocus ? 1.5 : 0.0;
        return AnimatedContainer(
          duration: Effects.shortDuration,
          curve: Curves.ease,
          decoration: ShapeDecoration(
            shape: Superellipse.all(
              cornerRadius + extraPadding - 0.5,
              side: side.copyWith(
                color: Colors.blueAccent,
                width: side.width * 2.0,
              ),
            ),
          ),
          padding: EdgeInsets.all(extraPadding),
          margin: margin,
          clipBehavior: clipBehavior,
          child: Material(
            color: Colors.transparent,
            shape: Superellipse.all(cornerRadius),
            clipBehavior: clipBehavior,
            child: InkResponse(
              mouseCursor: mouseCursor,
              onTap: onTap == null ? null : () {},
              onHover: onHover,
              splashColor: Colors.transparent,
              highlightShape: BoxShape.rectangle,
              hoverColor: hoverColor ?? context.colors.gray200,
              highlightColor: highlightColor ?? context.colors.gray200,
              canRequestFocus: false,
              child: CupertinoButton(
                color: color,
                padding: padding,
                pressedOpacity: pressedOpacity,
                borderRadius: BorderRadius.circular(cornerRadius),
                focusNode: context.read(),
                focusColor: focusColor ?? context.colors.secondaryBackground,
                minimumSize: Size.zero,
                onPressed:
                    onTap == null
                        ? null
                        : addFeedback
                        ? () {
                          Feedback.wrapForTap(_callback, context)?.call();
                        }
                        : _callback,
                child: PTooltip(
                  message: tooltip is String? ? tooltip as String? : null,
                  richMessage:
                      tooltip is InlineSpan? ? tooltip as InlineSpan? : null,
                  triggerMode: tooltipTriggerMode,
                  preferBelow: tooltipPreferBelow,
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
