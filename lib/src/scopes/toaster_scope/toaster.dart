import 'package:flutter/material.dart';
import 'package:flutter_physics/flutter_physics.dart';
import 'package:provider/provider.dart';

import '../../components/components.dart';
import '../../core_ui/core_ui.dart';

class Toaster extends StatefulWidget {
  const Toaster({super.key, required this.child});

  final Widget child;

  static ToasterState of(BuildContext context) => context.read<ToasterState>();

  @override
  State<Toaster> createState() => ToasterState();
}

class ToasterState extends State<Toaster> with SingleTickerProviderStateMixin {
  late final _controller = PhysicsController(
    vsync: this,
    defaultPhysics: Spring.playful,
  );

  IconData? _icon;
  String? _message;

  Future<void> showToast(String message, [IconData? icon]) async {
    setState(() {
      _message = message;
      _icon = icon;
    });
    return _controller.forward().then((_) {
      if (!mounted) return null;
      return _controller.reverse().then((_) {
        _dismissToast();
      });
    });
  }

  Future<void> showError(String message) async {
    await showToast(message, Icons.error);
  }

  void _dismissToast() {
    maybeSetState(() {
      _message = null;
      _icon = null;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ToasterState>.value(
      value: this,
      child: Stack(
        children: [
          widget.child,
          if (_message != null)
            Align(
              alignment: Alignment.topCenter,
              child: SafeArea(
                bottom: false,
                child: ScaleTransition(
                  scale: _controller,
                  alignment: Alignment.topCenter,
                  child: FadeTransition(
                    opacity: _controller,
                    child: Container(
                      decoration: ShapeDecoration(
                        color: context.brightSurface,
                        shape: Superellipse.border24,
                        shadows: focusedShadows(elevation: .25),
                      ),
                      padding: k16H12VPadding,
                      margin: k24H12VPadding,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_icon != null) ...[
                            Icon(_icon, size: 20.0),
                            const Gap(8.0),
                          ],
                          Flexible(
                            child: Text(
                              _message!,
                              style: context.textTheme.p.addWeight(.5),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
