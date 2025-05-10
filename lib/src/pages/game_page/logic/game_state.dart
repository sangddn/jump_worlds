part of '../game_page.dart';

typedef GameState = IList<Node>;

class GameStateNotifier extends ValueNotifier<GameState> {
  GameStateNotifier(this.game) : super(IList([game.firstPoint]));

  final Game game;

  Node get currentNode => value.last;

  void move(Node point) {
    value = value.add(point);
  }

  void moveByAxis(MoveDirection axis) {
    final current = value.last;
    debugPrint('moveByAxis. current: $current.');
    final legalMoves = getLegalMoves();
    debugPrint('moveByAxis. legalMoves: $legalMoves.');
    final nextMove = legalMoves.firstWhere(
      (move) => current.directionTo(move) == axis,
    );
    debugPrint('moveByAxis. nextMove: $nextMove.');
    move(nextMove);
  }

  bool isSolved() {
    return value.last == game.endPoint;
  }

  double getScore() {
    return getSolvedPuzzles().fold(0, (sum, puzzle) => sum + puzzle.score);
  }

  IList<Puzzle> getSolvedPuzzles() {
    return value.map((node) => game.puzzlesMap[node]).nonNulls.toIList();
  }

  bool isPuzzleSolved(Puzzle puzzle) {
    return getSolvedPuzzles().contains(puzzle);
  }

  bool isPuzzle(Node node) {
    return game.puzzlesMap.containsKey(node);
  }

  bool isBurger(Node node) => currentNode == node;

  IList<Node> getLegalMoves() {
    final allMoves = [...game.puzzlesMap.keys, game.endPoint, game.firstPoint];

    final current = value.last;
    final visited = value.toSet();
    final moves = <Node>[];

    // If we have a previous move, add it as an "undo" move
    if (value.length > 1) {
      moves.add(value[value.length - 2]);
    }

    final orthogonalMoves = allMoves.where(
      (move) => (move.col == current.col) != (move.row == current.row),
    );

    final notVisited = orthogonalMoves.where((move) => !visited.contains(move));

    // Among notVisited, we only the closest in each orthogonal direction
    final closestMoves = MoveDirection.values.map((direction) {
      final eligible = notVisited.where(
        (move) => move.directionTo(current) == direction,
      );
      if (eligible.isEmpty) return null;
      return eligible.reduce(
        (a, b) =>
            a.orthogonalDistanceTo(current) < b.orthogonalDistanceTo(current)
                ? a
                : b,
      );
    }).nonNulls;

    // Among the closest moves, we only add the ones that are not shadowed by
    // the previous move (if going in this direction, interpret as undo)
    final legalMoves = closestMoves.where((move) {
      final prevMove = value.elementAtOrNull(value.length - 2);
      if (prevMove == null) return true;
      return current.directionTo(prevMove) != current.directionTo(move);
    });

    moves.addAll(legalMoves);

    return IList(moves);
  }
}
