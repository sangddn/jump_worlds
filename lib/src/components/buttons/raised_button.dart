import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_physics/flutter_physics.dart';

import '../../core_ui/core_ui.dart';
import '../../utils/utils.dart';
import '../components.dart';

class RaisedButton extends StatefulWidget {
  const RaisedButton({
    super.key,
    this.focusNode,
    this.tooltip,
    this.onFocusChange,
    required this.onTap,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.backgroundColor = CupertinoColors.activeBlue,
    this.raiseColor,
    this.foregroundColor = const CupertinoDynamicColor.withBrightness(
      color: Colors.white,
      darkColor: Colors.white,
    ),
    this.height = 60,
    this.shape = Superellipse.border2,
    this.raiseHeight = 6,
    this.padding = k24HPadding,
    this.margin = EdgeInsets.zero,
    this.enableHapticFeedback = true,
    required this.child,
  });

  final FocusNode? focusNode;
  final String? tooltip;
  final ValueChanged<bool>? onFocusChange;
  final CupertinoDynamicColor backgroundColor;
  final CupertinoDynamicColor? raiseColor;
  final CupertinoDynamicColor foregroundColor;
  final VoidCallback? onTap;
  final ValueChanged<TapDownDetails>? onTapDown;
  final ValueChanged<TapUpDetails>? onTapUp;
  final VoidCallback? onTapCancel;
  final double height;
  final ShapeBorder shape;
  final double raiseHeight;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final bool enableHapticFeedback;
  final Widget child;

  @override
  State<RaisedButton> createState() => _RaisedButtonState();
}

class _RaisedButtonState extends State<RaisedButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = widget.backgroundColor.resolveFrom(context);
    final raiseColor =
        widget.raiseColor?.resolveFrom(context) ?? backgroundColor.shade20;
    final foregroundColor = widget.foregroundColor.resolveFrom(context);

    return FocusableActionDetector(
      focusNode: widget.focusNode,
      onFocusChange: widget.onFocusChange,
      child: PTooltip(
        message: widget.tooltip,
        child: GestureDetector(
          onTapDown: (details) {
            if (widget.enableHapticFeedback) {
              Haptics.lightImpact();
            }
            widget.onTapDown?.call(details);
            setState(() => _isPressed = true);
          },
          onTapUp: (details) {
            widget.onTapUp?.call(details);
            // Wait for the animation to complete
            Future.delayed(const Duration(milliseconds: 200), () {
              maybeSetState(() => _isPressed = false);
            });
          },
          onTapCancel: () {
            widget.onTapCancel?.call();
            setState(() => _isPressed = false);
          },
          onTap: widget.onTap,
          child: Padding(
            padding: widget.margin,
            child: SizedBox(
              height: widget.height,
              child: Stack(
                children: [
                  // Raise color (bottom layer)
                  APositioned(
                    physics: Spring.snap,
                    top: _isPressed ? widget.raiseHeight : 0.0,
                    left: 0.0,
                    right: 0.0,
                    bottom: 0.0,
                    child: AContainer(
                      height: widget.height,
                      decoration: ShapeDecoration(
                        color: raiseColor,
                        shape: widget.shape,
                      ),
                    ),
                  ),
                  // Main button (top layer)
                  APositioned(
                    physics: Spring.snap,
                    left: 0,
                    right: 0,
                    top: _isPressed ? widget.raiseHeight : 0.0,
                    child: AContainer(
                      height: widget.height - widget.raiseHeight,
                      decoration: ShapeDecoration(
                        color: backgroundColor,
                        shape: widget.shape,
                      ),
                      padding: widget.padding.resolve(
                        Directionality.of(context),
                      ),
                      alignment: Alignment.center,
                      child: DefaultTextStyle(
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: foregroundColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                        child: IconTheme(
                          data: theme.iconTheme.copyWith(
                            color: widget.foregroundColor,
                            size: 20.0,
                          ),
                          child: widget.child,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
