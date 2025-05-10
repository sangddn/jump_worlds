part of '../home_page.dart';

class _HeadBackground extends StatelessWidget {
  const _HeadBackground();

  @override
  Widget build(BuildContext context) {
    const extent = 300.0;
    return Stack(
      children: [
        Container(
          height: extent,
          decoration: BoxDecoration(
            gradient: SmoothGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              fromColor: context.colors.blue500,
              toColor: context.colors.blue500.fade(0),
            ),
          ),
        ),
        SizedBox.square(
          dimension: extent,
          child: ShaderMask(
            shaderCallback:
                (rect) => LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white60, Colors.white.fade(0)],
                ).createShader(rect),
            child: CustomPaint(painter: _GridPainter()),
          ),
        ),
      ],
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const cellSize = 30.0;

    final paint =
        Paint()
          ..color = Colors.white24
          ..strokeWidth = 1.5;

    // Draw vertical lines
    for (double i = 0; i < size.width; i += cellSize) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }

    // Draw horizontal lines
    for (double i = 0; i < size.height; i += cellSize) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
