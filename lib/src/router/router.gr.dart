// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:jump_worlds/src/database/database.dart' as _i7;
import 'package:jump_worlds/src/pages/game_page/game_page.dart' as _i1;
import 'package:jump_worlds/src/pages/home_page/home_page.dart' as _i2;
import 'package:jump_worlds/src/pages/intro_page/intro_page.dart' as _i3;
import 'package:jump_worlds/src/pages/level_page/level_page.dart' as _i4;

/// generated route for
/// [_i1.GamePage]
class GameRoute extends _i5.PageRouteInfo<GameRouteArgs> {
  GameRoute({
    _i6.Key? key,
    required _i7.Game game,
    List<_i5.PageRouteInfo>? children,
  }) : super(
         GameRoute.name,
         args: GameRouteArgs(key: key, game: game),
         initialChildren: children,
       );

  static const String name = 'GameRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<GameRouteArgs>();
      return _i1.GamePage(key: args.key, game: args.game);
    },
  );
}

class GameRouteArgs {
  const GameRouteArgs({this.key, required this.game});

  final _i6.Key? key;

  final _i7.Game game;

  @override
  String toString() {
    return 'GameRouteArgs{key: $key, game: $game}';
  }
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomePage();
    },
  );
}

/// generated route for
/// [_i3.IntroPage]
class IntroRoute extends _i5.PageRouteInfo<void> {
  const IntroRoute({List<_i5.PageRouteInfo>? children})
    : super(IntroRoute.name, initialChildren: children);

  static const String name = 'IntroRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i3.IntroPage();
    },
  );
}

/// generated route for
/// [_i4.LevelPage]
class LevelRoute extends _i5.PageRouteInfo<LevelRouteArgs> {
  LevelRoute({
    _i6.Key? key,
    required _i7.Difficulty difficulty,
    List<_i5.PageRouteInfo>? children,
  }) : super(
         LevelRoute.name,
         args: LevelRouteArgs(key: key, difficulty: difficulty),
         initialChildren: children,
       );

  static const String name = 'LevelRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LevelRouteArgs>();
      return _i4.LevelPage(key: args.key, difficulty: args.difficulty);
    },
  );
}

class LevelRouteArgs {
  const LevelRouteArgs({this.key, required this.difficulty});

  final _i6.Key? key;

  final _i7.Difficulty difficulty;

  @override
  String toString() {
    return 'LevelRouteArgs{key: $key, difficulty: $difficulty}';
  }
}
