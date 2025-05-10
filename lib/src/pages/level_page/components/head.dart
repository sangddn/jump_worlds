part of '../level_page.dart';

class _Head extends StatelessWidget {
  const _Head();

  @override
  Widget build(BuildContext context) {
    final db = context.db;
    final difficulty = context.read<Difficulty>();
    final gamesDone = db.getGamesDoneForLevel(difficulty);
    final gamesTotal = db.getTotalGamesForLevel(difficulty);

    final color = difficulty.backgroundColor.resolveFrom(context);

    return SliverSafeArea(
      bottom: false,
      sliver: SuperSliverList.list(
        children: [
          const Gap(60.0),
          ShaderMask(
            shaderCallback:
                (rect) => LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [color.tint70, color.tint30],
                ).createShader(rect),
            blendMode: BlendMode.srcIn,
            child: Text(
              difficulty.name,
              style: context.textTheme.display1,
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            '$gamesDone / $gamesTotal',
            style: context.textTheme.h3.withColor(
              difficulty.backgroundColor.resolveFrom(context).tint70,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
