part of '../database.dart';

class Database with LocalDbMixin implements DatabaseInterface {
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
