part of '../level_page.dart';

class _GameWheel extends StatelessWidget {
  const _GameWheel();

  @override
  Widget build(BuildContext context) {
    final difficulty = context.watch<Difficulty>();
    final numGames = context.db.getTotalGamesForLevel(difficulty);
    return PageView.builder(
      controller: context.read<_GameWheelController>(),
      itemCount: numGames,
      itemBuilder: (context, index) => Center(child: _GameItem(index)),
    );
  }
}

class _GameItem extends StatelessWidget {
  const _GameItem(this.index);

  final int index;

  @override
  Widget build(BuildContext context) {
    final difficulty = context.watch<Difficulty>();
    final game = context.db.getGameAtLevel(difficulty, index);
    return Padding(
      padding: k32APadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RepresentativeGrid(game: game),
          const Gap(32.0),
          RaisedButton(
            onTap: () => context.router.push(GameRoute(game: game)),
            child: const Text('Play'),
          ),
        ],
      ),
    );
  }
}
