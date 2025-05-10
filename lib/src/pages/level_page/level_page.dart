import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

import '../../animations/animations.dart';
import '../../app/app.dart';
import '../../components/components.dart';
import '../../core_ui/core_ui.dart';
import '../../database/database.dart';
import '../../router/router.gr.dart';
import '../../utils/colors.dart';

part 'components/head.dart';
part 'components/head_background.dart';
part 'components/game_wheel.dart';

part 'logic/page_controller.dart';

@RoutePage()
class LevelPage extends MultiProviderWidget {
  const LevelPage({super.key, required this.difficulty});

  final Difficulty difficulty;

  @override
  List<SingleChildWidget> getProviders(BuildContext context) {
    return [
      Provider<Difficulty>.value(value: difficulty),
      ChangeNotifierProvider<_GameWheelController>(
        create: (_) => _GameWheelController(),
      ),
    ];
  }

  @override
  Widget buildChild(BuildContext context) {
    return const Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          _HeadBackground(),
          CustomScrollView(
            slivers: [_Head(), SliverFillRemaining(child: _GameWheel())],
          ),
        ],
      ),
    );
  }
}
