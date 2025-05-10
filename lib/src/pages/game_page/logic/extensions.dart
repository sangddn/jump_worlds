part of '../game_page.dart';

extension GameStateContext on BuildContext {
  GameStateNotifier get gameState => read();
  GameStateNotifier watchGameState() => watch();
  T selectState<T>(T Function(GameStateNotifier) fn) => select(fn);

  bool isSolved() => selectState((s) => s.isSolved());
  double watchScore() => selectState((s) => s.getScore());
}

extension GestureHandlingContext on BuildContext {
  void onDragSuccess(double delta, Velocity velocity, Axis axis) {
    var shouldMove = false;
    if (velocity.pixelsPerSecond.distance > 1000) {
      shouldMove = true;
    } else if (delta > 100) {
      shouldMove = true;
    }
    if (shouldMove) {
      final direction = switch ((axis, delta)) {
        (Axis.horizontal, < 0) => MoveDirection.left,
        (Axis.horizontal, >= 0) => MoveDirection.right,
        (Axis.vertical, < 0) => MoveDirection.up,
        (Axis.vertical, >= 0) => MoveDirection.down,
        (Axis.horizontal, _) => throw UnimplementedError(),
        (Axis.vertical, _) => throw UnimplementedError(),
      };
      gameState.moveByAxis(direction);
    }
  }
}
