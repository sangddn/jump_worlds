import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_physics/flutter_physics.dart';
import 'package:provider/provider.dart';

import '../../components/components.dart';
import '../../core_ui/core_ui.dart';
import '../../database/database.dart';
import '../../router/router.gr.dart';
import '../pages.dart';

part 'components/show_intro_if_needed.dart';
part 'components/head.dart';
part 'components/timer.dart';
part 'components/grid.dart';
part 'components/cell.dart';
part 'components/burger.dart';
part 'components/puzzle_cell.dart';
part 'components/end_cell.dart';
part 'components/gestures.dart';

part 'logic/game_state.dart';
part 'logic/gesture_logic.dart';
part 'logic/extensions.dart';

@RoutePage()
class GamePage extends MultiProviderWidget {
  const GamePage({super.key, required this.game});

  final Game game;

  @override
  List<SingleChildWidget> getProviders(BuildContext context) {
    return [
      Provider<Game>.value(value: game),
      ChangeNotifierProvider<GameStateNotifier>(
        create: (context) => GameStateNotifier(game),
      ),
    ];
  }

  @override
  Widget buildChild(BuildContext context) {
    return const _Gestures(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              _ShowIntroIfNeeded(),
              Gap(16),
              _Head(),
              Gap(32.0),
              Expanded(child: _Grid()),
            ],
          ),
        ),
      ),
    );
  }
}
