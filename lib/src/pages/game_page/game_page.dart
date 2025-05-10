import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../database/database.dart';

@RoutePage()
class GamePage extends StatelessWidget {
  const GamePage({super.key, required this.game});

  final Game game;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Text('GamePage'));
  }
}
