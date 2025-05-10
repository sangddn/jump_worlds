import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

part 'database.mapper.dart';
part 'models/puzzle.dart';
part 'models/game.dart';
part 'models/game_state.dart';
part 'implementations/database.dart';

abstract interface class DatabaseInterface implements LocalKeyValueStore {
  Future<void> initialize();
  void dispose();
}

abstract interface class LocalKeyValueStore {
  Box<bool> get boolRef;
  Box<String> get stringRef;
  Box<double> get doubleRef;
  Box<DateTime> get dateTimeRef;
}
