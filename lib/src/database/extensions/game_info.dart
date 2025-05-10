part of '../database.dart';

extension GameLevelInfoX on DatabaseInterface {
  int getGamesDoneForLevel(Difficulty difficulty) =>
      getTotalGamesForLevel(difficulty) - getGamesLeftForLevel(difficulty);

  String describeDifficulty(Difficulty difficulty) => switch (difficulty) {
        Difficulty.easy => '4x3',
        Difficulty.medium => '5x4',
        Difficulty.hard => '6x5',
      };
}
