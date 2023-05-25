import 'package:flappybirdclone/game/game.dart';
import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {
  final FlappyBirdGame game;

  const GameOver({
    Key? key,
    required this.game,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black38,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'You crashed!',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                game.overlays.remove('gameOver');
                game.restartGame();
              },
              child: const Text(
                'Continue',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
