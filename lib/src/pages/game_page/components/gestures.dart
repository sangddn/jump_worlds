part of '../game_page.dart';

class _Gestures extends StatefulWidget {
  const _Gestures({required this.child});

  final Widget child;

  @override
  State<_Gestures> createState() => _GesturesState();
}

class _GesturesState extends State<_Gestures> {
  _GestureDetails _details = (Offset.zero, Axis.horizontal);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart:
          (details) =>
              setState(() => _details = (Offset.zero, Axis.horizontal)),
      onHorizontalDragUpdate:
          (details) => setState(() {
            _details = (_details.$1 + details.delta, Axis.horizontal);
          }),
      onHorizontalDragEnd: (details) {
        context.onDragSuccess(
          _details.$1.dx,
          details.velocity,
          Axis.horizontal,
        );
        setState(() => _details = (Offset.zero, Axis.horizontal));
      },
      onHorizontalDragCancel:
          () => setState(() => _details = (Offset.zero, Axis.horizontal)),
      onVerticalDragStart:
          (details) => setState(() => _details = (Offset.zero, Axis.vertical)),
      onVerticalDragUpdate:
          (details) => setState(() {
            _details = (_details.$1 + details.delta, Axis.vertical);
          }),
      onVerticalDragEnd: (details) {
        context.onDragSuccess(_details.$1.dy, details.velocity, Axis.vertical);
        setState(() => _details = (Offset.zero, Axis.vertical));
      },
      onVerticalDragCancel:
          () => setState(() => _details = (Offset.zero, Axis.vertical)),
      child: Provider<_GestureDetails?>.value(
        value: _details,
        child: widget.child,
      ),
    );
  }
}
