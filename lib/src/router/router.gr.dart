// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:jump_worlds/src/pages/game_page/game_page.dart' as _i1;
import 'package:jump_worlds/src/pages/home_page/home_page.dart' as _i2;
import 'package:jump_worlds/src/pages/intro_page/intro_page.dart' as _i3;
import 'package:jump_worlds/src/pages/room_page/room_page.dart' as _i4;

/// generated route for
/// [_i1.GamePage]
class GameRoute extends _i5.PageRouteInfo<void> {
  const GameRoute({List<_i5.PageRouteInfo>? children})
    : super(GameRoute.name, initialChildren: children);

  static const String name = 'GameRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.GamePage();
    },
  );
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
/// [_i4.RoomPage]
class RoomRoute extends _i5.PageRouteInfo<void> {
  const RoomRoute({List<_i5.PageRouteInfo>? children})
    : super(RoomRoute.name, initialChildren: children);

  static const String name = 'RoomRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.RoomPage();
    },
  );
}
