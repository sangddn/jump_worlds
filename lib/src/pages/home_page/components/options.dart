part of '../home_page.dart';

class _Options extends StatelessWidget {
  const _Options();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: k24HPadding,
      sliver: SuperSliverList.list(
        children: [
          ...Difficulty.values.expand((e) => [_Button(e), const Gap(16.0)]),
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button(this.difficulty);

  final Difficulty difficulty;

  @override
  Widget build(BuildContext context) {
    final db = context.db;
    final gamesDone = db.getGamesDoneForLevel(difficulty);
    final gamesTotal = db.getTotalGamesForLevel(difficulty);
    return RaisedButton(
      onTap: () => context.router.push(LevelRoute(difficulty: difficulty)),
      backgroundColor: difficulty.backgroundColor,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(difficulty.name),
              Text(
                db.describeDifficulty(difficulty),
                style: context.textTheme.small.withColor(Colors.white),
              ),
            ],
          ),
          const Spacer(),
          Text('$gamesDone / $gamesTotal'),
        ],
      ),
    );
  }
}
