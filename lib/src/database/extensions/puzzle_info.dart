part of '../database.dart';

extension PuzzleInfoX on Puzzle {
  double get score => switch (difficulty) {
    Difficulty.easy => 10,
    Difficulty.medium => 20,
    Difficulty.hard => 30,
  };
}
