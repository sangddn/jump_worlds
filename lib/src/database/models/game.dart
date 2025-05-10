part of '../database.dart';

@MappableClass()
class Game with GameMappable {
  const Game({
    required this.id,
    required this.numRows,
    required this.grid,
    required this.puzzles,
  });

  final String id;
  final int numRows;

  /// The grid of the game.
  ///
  /// A list from top to bottom, left to right.
  ///
  /// Values:
  /// - 0 => empty
  /// - 1 => start point
  /// - 2 => puzzle / obstacle
  /// - 3 => end point
  final List<int> grid;

  /// The puzzles of the game.
  final List<Puzzle> puzzles;

  /// The number of columns in the game.
  int get numCols => grid.length ~/ numRows;
}
