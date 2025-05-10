import 'package:flutter/material.dart';
import 'package:flutter_physics/flutter_physics.dart';

class PhysicsAnimate extends StatefulWidget {
  const PhysicsAnimate({
    super.key,
    this.value = 0.0,
    this.lowerBound = 0.0,
    this.upperBound = 1.0,
    this.animationBehavior = AnimationBehavior.preserve,
    this.defaultPhysics,
    this.defaultDuration,
    this.defaultReverseDuration,
    this.onInitialized,
    this.onStatusChanged,
    required this.builder,
  });

  final PhysicsSimulation? defaultPhysics;
  final Duration? defaultDuration;
  final Duration? defaultReverseDuration;
  final double value;
  final double lowerBound;
  final double upperBound;
  final AnimationBehavior animationBehavior;
  final void Function(PhysicsController controller)? onInitialized;
  final void Function(PhysicsController controller, AnimationStatus status)?
  onStatusChanged;
  final Widget Function(BuildContext context, PhysicsController controller)
  builder;

  @override
  State<PhysicsAnimate> createState() => _PhysicsAnimateState();
}

class _PhysicsAnimateState extends State<PhysicsAnimate>
    with SingleTickerProviderStateMixin {
  late PhysicsController _controller;
  bool _isInitialized = false;

  void _initController() {
    if (_isInitialized) _disposeController();
    final controller = PhysicsController(
      vsync: this,
      defaultPhysics: widget.defaultPhysics,
      duration: widget.defaultDuration,
      reverseDuration: widget.defaultReverseDuration,
      value: widget.value,
      lowerBound: widget.lowerBound,
      upperBound: widget.upperBound,
      animationBehavior: widget.animationBehavior,
    );
    _controller = controller;
    _isInitialized = true;
    widget.onInitialized?.call(controller);
    controller.addStatusListener((status) {
      // pass the frozen instance to the callback, not the var `_controller`
      widget.onStatusChanged?.call(controller, status);
    });
  }

  void _disposeController() {
    _controller.stop();
    _controller.dispose();
    _isInitialized = false;
  }

  @override
  void initState() {
    super.initState();
    _initController();
  }

  @override
  void didUpdateWidget(PhysicsAnimate oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _controller.value = widget.value;
    }
    if (oldWidget.defaultPhysics != widget.defaultPhysics) {
      _controller.defaultPhysics = widget.defaultPhysics ?? Spring.elegant;
    }
    if (oldWidget.defaultDuration != widget.defaultDuration) {
      _controller.duration = widget.defaultDuration;
    }
    if (oldWidget.defaultReverseDuration != widget.defaultReverseDuration) {
      _controller.reverseDuration = widget.defaultReverseDuration;
    }
    if (oldWidget.lowerBound != widget.lowerBound ||
        oldWidget.upperBound != widget.upperBound) {
      _initController();
    }
  }

  @override
  void dispose() {
    _disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _controller);
}
