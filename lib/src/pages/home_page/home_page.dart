import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

import '../../components/buttons/buttons.dart';
import '../../components/components.dart';
import '../../components/images/images.dart';
import '../../core_ui/core_ui.dart';

part 'components/head_background.dart';
part 'components/head.dart';
part 'components/title.dart';
part 'components/options.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          _HeadBackground(),
          CustomScrollView(
            slivers: [
              _Head(),
              SliverGap(16.0),
              _Title(),
              SliverGap(32.0),
              _Options(),
            ],
          ),
        ],
      ),
    );
  }
}
