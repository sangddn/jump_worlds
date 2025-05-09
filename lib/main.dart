import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'game/jump_worlds_game.dart'; // Import your game file

void main() {
  final game = JumpWorldsGame();
  runApp(GameWidget(game: game));
}
