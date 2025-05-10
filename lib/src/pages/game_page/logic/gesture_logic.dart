part of '../game_page.dart';

typedef _GestureDetails = (Offset offset, Axis axis);

extension GestureDetailsContext on BuildContext {
  _GestureDetails get gestureDetails => read();
  _GestureDetails watchGestureDetails() => watch();
  T selectGestureDetails<T>(T Function(_GestureDetails d) fn) => select(fn);
  bool isDragging() => selectGestureDetails((d) => d.$1 != Offset.zero);
}
