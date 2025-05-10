part of '../database.dart';

@MappableClass()
class Puzzle with PuzzleMappable {
  const Puzzle({
    required this.id,
    required this.firstWord,
    required this.secondWord,
    required this.thirdWord,
    required this.difficulty,
    required this.asset,
  });

  final String id;
  final String firstWord;
  final String secondWord;
  final String thirdWord;
  final Difficulty difficulty;
  final UiAsset asset;
}

@MappableEnum()
enum Difficulty {
  easy,
  medium,
  hard,
}
