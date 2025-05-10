import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../core_ui/core_ui.dart';
import '../utils/utils.dart';

part 'database.mapper.dart';
part 'models/puzzle.dart';
part 'models/game.dart';
part 'models/game_state.dart';
part 'implementations/database.dart';
part 'extensions/game_info.dart';
part 'extensions/puzzle_info.dart';

abstract interface class DatabaseInterface
    implements LocalKeyValueStore, GameLevelInfo {
  Future<void> initialize();
  void dispose();
}

abstract interface class LocalKeyValueStore {
  Box<bool> get boolRef;
  Box<String> get stringRef;
  Box<double> get doubleRef;
  Box<DateTime> get dateTimeRef;
}

abstract interface class GameLevelInfo {
  Game getGame(String id);
  Game getGameAtLevel(Difficulty difficulty, int index);
  int getGamesLeftForLevel(Difficulty difficulty);
  int getTotalGamesForLevel(Difficulty difficulty);
}
