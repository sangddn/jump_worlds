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
  final List<int> grid;
  final List<Puzzle> puzzles;

  int get numColumns => grid.length ~/ numRows;
}
