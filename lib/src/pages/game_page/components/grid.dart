part of '../game_page.dart';

class _Grid extends StatelessWidget {
  const _Grid();

  @override
  Widget build(BuildContext context) {
    final game = context.watch<Game>();
    final numRows = game.numRows;
    final numCols = game.numCols;
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;
        final height = size.height / numRows;
        final width = size.width / numCols;
        return Stack(
          clipBehavior: Clip.none,
          fit: StackFit.expand,
          children: [
            for (var row = 0; row < numRows; row++)
              for (var col = 0; col < numCols; col++)
                _CellBackground(height, width, Node(col, row)),
            for (var row = 0; row < numRows; row++)
              for (var col = 0; col < numCols; col++)
                _Cell(height, width, Node(col, row)),
          ],
        );
      },
    );
  }
}

class _CellBackground extends StatelessWidget {
  const _CellBackground(this.height, this.width, this.node);

  final double height;
  final double width;
  final Node node;

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      start: width * node.col,
      top: height * node.row,
      width: width,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: context.colors.gray300,
            strokeAlign: BorderSide.strokeAlignCenter,
          ),
        ),
      ),
    );
  }
}
