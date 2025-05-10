part of '../game_page.dart';

class _Burger extends StatelessWidget {
  const _Burger();

  @override
  Widget build(BuildContext context) {
    debugPrint(
      'burger build. at ${context.selectState((s) => s.currentNode)}: legal moves: ${context.selectState((s) => s.getLegalMoves())}',
    );
    return const Padding(
      padding: k8APadding,
      child: RoundedImage.fromAsset(UiAsset.happyBun, fit: BoxFit.contain),
    );
  }
}
