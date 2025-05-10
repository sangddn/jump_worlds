part of '../database.dart';

class Database with LocalDbMixin, GameInfoMixin implements DatabaseInterface {
  factory Database() => instance;
  Database._();

  static final instance = Database._();

  bool isInitialized = false;

  @override
  Future<void> initialize() async {
    if (isInitialized) {
      return;
    }
    debugPrint('Initializing AppDatabase...');
    await initializeLocalDb();
    isInitialized = true;
    debugPrint('Local database initialized. 🚀');
    return;
  }
}

mixin LocalDbMixin implements LocalKeyValueStore {
  String get localDbName => kDebugMode ? 'Jumper (Debug)' : 'Jumper';

  @override
  late final Box<bool> boolRef;

  @override
  late final Box<String> stringRef;

  @override
  late final Box<double> doubleRef;

  @override
  late final Box<DateTime> dateTimeRef;

  Future<void> initializeLocalDb() async {
    Hive.init(await _getPath());
    boolRef = await Hive.openBox<bool>('boolMap');
    stringRef = await Hive.openBox<String>('stringMap');
    doubleRef = await Hive.openBox<double>('doubleMap');
    dateTimeRef = await Hive.openBox<DateTime>('dateTimeMap');
    return;
  }

  Future<String> _getPath() async =>
      '${(await getApplicationDocumentsDirectory()).path}/$localDbName';

  @mustCallSuper
  void dispose() {
    boolRef.close();
    stringRef.close();
    doubleRef.close();
    dateTimeRef.close();
  }
}

mixin GameInfoMixin implements GameLevelInfo {
  @override
  Game getGame(String id) => _mockGame;

  @override
  Game getGameAtLevel(Difficulty difficulty, int index) => _mockGame;

  @override
  int getGamesLeftForLevel(Difficulty difficulty) => 9;

  @override
  int getTotalGamesForLevel(Difficulty difficulty) => 10;
}

const _mockGame = Game(
  id: '2',
  numRows: 4,
  grid: [3, 2, 2, 0, 0, 0, 1, 2, 2, 2, 0, 2],
  puzzles: [
    Puzzle(
      id: '1',
      firstWord: 'river',
      secondWord: 'bank',
      thirdWord: 'money',
      difficulty: Difficulty.easy,
      asset: UiAsset.bun,
    ),
    Puzzle(
      id: '2',
      firstWord: 'cave',
      secondWord: 'bat',
      thirdWord: 'baseball',
      difficulty: Difficulty.easy,
      asset: UiAsset.bun,
    ),
    Puzzle(
      id: '3',
      firstWord: 'elephant',
      secondWord: 'trunk',
      thirdWord: 'car',
      difficulty: Difficulty.easy,
      asset: UiAsset.bun,
    ),
    Puzzle(
      id: '4',
      firstWord: 'galaxy',
      secondWord: 'star',
      thirdWord: 'movie',
      asset: UiAsset.bun,
      difficulty: Difficulty.easy,
    ),
    Puzzle(
      id: '5',
      firstWord: 'tree',
      secondWord: 'bark',
      thirdWord: 'dog',
      asset: UiAsset.bun,
      difficulty: Difficulty.easy,
    ),
    Puzzle(
      id: '6',
      firstWord: 'tree',
      secondWord: 'branch',
      thirdWord: 'git',
      asset: UiAsset.bun,
      difficulty: Difficulty.easy,
    ),
  ],
);
