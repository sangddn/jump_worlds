part of '../game_page.dart';

class _PuzzleCell extends StatelessWidget {
  const _PuzzleCell(this.node);

  final Node node;

  @override
  Widget build(BuildContext context) {
    final puzzle = context.selectState((s) => s.game.puzzlesMap[node]!);
    return Center(
      child: Container(
        padding: k8H4VPadding,
        decoration: ShapeDecoration(
          shape: Superellipse.border4,
          color: context.colors.gray100,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(puzzle.firstWord),
            const Divider(),
            Text(puzzle.thirdWord),
          ],
        ),
      ),
    );
  }
}
