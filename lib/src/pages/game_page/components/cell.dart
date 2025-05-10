part of '../game_page.dart';

class _Cell extends StatelessWidget {
  _Cell(this.cellHeight, this.cellWidth, this.node)
    : super(key: ValueKey(node));

  final double cellHeight;
  final double cellWidth;
  final Node node;

  @override
  Widget build(BuildContext context) {
    final isBurger = context.selectState((s) => s.isBurger(node));
    final isPuzzle = context.selectState((s) => s.isPuzzle(node));
    final child =
        isBurger
            ? const _Burger()
            : isPuzzle
            ? const _PuzzleCell()
            : const SizedBox.shrink();
    final offset = isBurger ? context.watchGestureDetails().$1 : Offset.zero;
    return APositionedDirectional(
      start: cellWidth * node.col + offset.dx,
      top: cellHeight * node.row + offset.dy,
      width: cellWidth,
      height: cellHeight,
      child: child,
    );
  }
}
