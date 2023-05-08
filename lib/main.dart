import 'package:flame/game.dart';
import 'package:flappybirdclone/game/game.dart';
import 'package:flappybirdclone/game/gameover.dart';
import 'package:flutter/material.dart';

void main() {
  final game = FlappyBirdGame();
  runApp(
    GameWidget(
      game: game,
      overlayBuilderMap: {
        'gameOver': (context, _) => GameOver(game: game),
      },
    ),
  );
}
