// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'database.dart';

class DifficultyMapper extends EnumMapper<Difficulty> {
  DifficultyMapper._();

  static DifficultyMapper? _instance;
  static DifficultyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DifficultyMapper._());
    }
    return _instance!;
  }

  static Difficulty fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  Difficulty decode(dynamic value) {
    switch (value) {
      case r'easy':
        return Difficulty.easy;
      case r'medium':
        return Difficulty.medium;
      case r'hard':
        return Difficulty.hard;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(Difficulty self) {
    switch (self) {
      case Difficulty.easy:
        return r'easy';
      case Difficulty.medium:
        return r'medium';
      case Difficulty.hard:
        return r'hard';
    }
  }
}

extension DifficultyMapperExtension on Difficulty {
  String toValue() {
    DifficultyMapper.ensureInitialized();
    return MapperContainer.globals.toValue<Difficulty>(this) as String;
  }
}

class PuzzleMapper extends ClassMapperBase<Puzzle> {
  PuzzleMapper._();

  static PuzzleMapper? _instance;
  static PuzzleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PuzzleMapper._());
      DifficultyMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Puzzle';

  static String _$id(Puzzle v) => v.id;
  static const Field<Puzzle, String> _f$id = Field('id', _$id);
  static String _$firstWord(Puzzle v) => v.firstWord;
  static const Field<Puzzle, String> _f$firstWord =
      Field('firstWord', _$firstWord);
  static String _$secondWord(Puzzle v) => v.secondWord;
  static const Field<Puzzle, String> _f$secondWord =
      Field('secondWord', _$secondWord);
  static String _$thirdWord(Puzzle v) => v.thirdWord;
  static const Field<Puzzle, String> _f$thirdWord =
      Field('thirdWord', _$thirdWord);
  static Difficulty _$difficulty(Puzzle v) => v.difficulty;
  static const Field<Puzzle, Difficulty> _f$difficulty =
      Field('difficulty', _$difficulty);
  static UiAsset _$asset(Puzzle v) => v.asset;
  static const Field<Puzzle, UiAsset> _f$asset = Field('asset', _$asset);

  @override
  final MappableFields<Puzzle> fields = const {
    #id: _f$id,
    #firstWord: _f$firstWord,
    #secondWord: _f$secondWord,
    #thirdWord: _f$thirdWord,
    #difficulty: _f$difficulty,
    #asset: _f$asset,
  };

  static Puzzle _instantiate(DecodingData data) {
    return Puzzle(
        id: data.dec(_f$id),
        firstWord: data.dec(_f$firstWord),
        secondWord: data.dec(_f$secondWord),
        thirdWord: data.dec(_f$thirdWord),
        difficulty: data.dec(_f$difficulty),
        asset: data.dec(_f$asset));
  }

  @override
  final Function instantiate = _instantiate;

  static Puzzle fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Puzzle>(map);
  }

  static Puzzle fromJson(String json) {
    return ensureInitialized().decodeJson<Puzzle>(json);
  }
}

mixin PuzzleMappable {
  String toJson() {
    return PuzzleMapper.ensureInitialized().encodeJson<Puzzle>(this as Puzzle);
  }

  Map<String, dynamic> toMap() {
    return PuzzleMapper.ensureInitialized().encodeMap<Puzzle>(this as Puzzle);
  }

  PuzzleCopyWith<Puzzle, Puzzle, Puzzle> get copyWith =>
      _PuzzleCopyWithImpl<Puzzle, Puzzle>(this as Puzzle, $identity, $identity);
  @override
  String toString() {
    return PuzzleMapper.ensureInitialized().stringifyValue(this as Puzzle);
  }

  @override
  bool operator ==(Object other) {
    return PuzzleMapper.ensureInitialized().equalsValue(this as Puzzle, other);
  }

  @override
  int get hashCode {
    return PuzzleMapper.ensureInitialized().hashValue(this as Puzzle);
  }
}

extension PuzzleValueCopy<$R, $Out> on ObjectCopyWith<$R, Puzzle, $Out> {
  PuzzleCopyWith<$R, Puzzle, $Out> get $asPuzzle =>
      $base.as((v, t, t2) => _PuzzleCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PuzzleCopyWith<$R, $In extends Puzzle, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? id,
      String? firstWord,
      String? secondWord,
      String? thirdWord,
      Difficulty? difficulty,
      UiAsset? asset});
  PuzzleCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PuzzleCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Puzzle, $Out>
    implements PuzzleCopyWith<$R, Puzzle, $Out> {
  _PuzzleCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Puzzle> $mapper = PuzzleMapper.ensureInitialized();
  @override
  $R call(
          {String? id,
          String? firstWord,
          String? secondWord,
          String? thirdWord,
          Difficulty? difficulty,
          UiAsset? asset}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (firstWord != null) #firstWord: firstWord,
        if (secondWord != null) #secondWord: secondWord,
        if (thirdWord != null) #thirdWord: thirdWord,
        if (difficulty != null) #difficulty: difficulty,
        if (asset != null) #asset: asset
      }));
  @override
  Puzzle $make(CopyWithData data) => Puzzle(
      id: data.get(#id, or: $value.id),
      firstWord: data.get(#firstWord, or: $value.firstWord),
      secondWord: data.get(#secondWord, or: $value.secondWord),
      thirdWord: data.get(#thirdWord, or: $value.thirdWord),
      difficulty: data.get(#difficulty, or: $value.difficulty),
      asset: data.get(#asset, or: $value.asset));

  @override
  PuzzleCopyWith<$R2, Puzzle, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _PuzzleCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class GameMapper extends ClassMapperBase<Game> {
  GameMapper._();

  static GameMapper? _instance;
  static GameMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GameMapper._());
      PuzzleMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Game';

  static String _$id(Game v) => v.id;
  static const Field<Game, String> _f$id = Field('id', _$id);
  static int _$numRows(Game v) => v.numRows;
  static const Field<Game, int> _f$numRows = Field('numRows', _$numRows);
  static List<int> _$grid(Game v) => v.grid;
  static const Field<Game, List<int>> _f$grid = Field('grid', _$grid);
  static List<Puzzle> _$puzzles(Game v) => v.puzzles;
  static const Field<Game, List<Puzzle>> _f$puzzles =
      Field('puzzles', _$puzzles);

  @override
  final MappableFields<Game> fields = const {
    #id: _f$id,
    #numRows: _f$numRows,
    #grid: _f$grid,
    #puzzles: _f$puzzles,
  };

  static Game _instantiate(DecodingData data) {
    return Game(
        id: data.dec(_f$id),
        numRows: data.dec(_f$numRows),
        grid: data.dec(_f$grid),
        puzzles: data.dec(_f$puzzles));
  }

  @override
  final Function instantiate = _instantiate;

  static Game fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Game>(map);
  }

  static Game fromJson(String json) {
    return ensureInitialized().decodeJson<Game>(json);
  }
}

mixin GameMappable {
  String toJson() {
    return GameMapper.ensureInitialized().encodeJson<Game>(this as Game);
  }

  Map<String, dynamic> toMap() {
    return GameMapper.ensureInitialized().encodeMap<Game>(this as Game);
  }

  GameCopyWith<Game, Game, Game> get copyWith =>
      _GameCopyWithImpl<Game, Game>(this as Game, $identity, $identity);
  @override
  String toString() {
    return GameMapper.ensureInitialized().stringifyValue(this as Game);
  }

  @override
  bool operator ==(Object other) {
    return GameMapper.ensureInitialized().equalsValue(this as Game, other);
  }

  @override
  int get hashCode {
    return GameMapper.ensureInitialized().hashValue(this as Game);
  }
}

extension GameValueCopy<$R, $Out> on ObjectCopyWith<$R, Game, $Out> {
  GameCopyWith<$R, Game, $Out> get $asGame =>
      $base.as((v, t, t2) => _GameCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class GameCopyWith<$R, $In extends Game, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>> get grid;
  ListCopyWith<$R, Puzzle, PuzzleCopyWith<$R, Puzzle, Puzzle>> get puzzles;
  $R call({String? id, int? numRows, List<int>? grid, List<Puzzle>? puzzles});
  GameCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _GameCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Game, $Out>
    implements GameCopyWith<$R, Game, $Out> {
  _GameCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Game> $mapper = GameMapper.ensureInitialized();
  @override
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>> get grid => ListCopyWith(
      $value.grid,
      (v, t) => ObjectCopyWith(v, $identity, t),
      (v) => call(grid: v));
  @override
  ListCopyWith<$R, Puzzle, PuzzleCopyWith<$R, Puzzle, Puzzle>> get puzzles =>
      ListCopyWith($value.puzzles, (v, t) => v.copyWith.$chain(t),
          (v) => call(puzzles: v));
  @override
  $R call({String? id, int? numRows, List<int>? grid, List<Puzzle>? puzzles}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (numRows != null) #numRows: numRows,
        if (grid != null) #grid: grid,
        if (puzzles != null) #puzzles: puzzles
      }));
  @override
  Game $make(CopyWithData data) => Game(
      id: data.get(#id, or: $value.id),
      numRows: data.get(#numRows, or: $value.numRows),
      grid: data.get(#grid, or: $value.grid),
      puzzles: data.get(#puzzles, or: $value.puzzles));

  @override
  GameCopyWith<$R2, Game, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _GameCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
