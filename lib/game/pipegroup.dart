import 'dart:math';

import 'package:flame/components.dart';
import 'package:flappybirdclone/game/game.dart';
import 'package:flappybirdclone/game/pipe.dart';

class PipeGroup extends PositionComponent with HasGameRef<FlappyBirdGame> {
  PipeGroup();

  final Random _random = Random();

  late Pipe _topPipe;
  late Pipe _bottomPipe;

  @override
  Future<void> onLoad() async {
    position.x = gameRef.size.x;
    final heightMinusGround = gameRef.size.y - 110;
    final spacing = 90 + _random.nextDouble() * (heightMinusGround / 4);
    final centerY =
        spacing + _random.nextDouble() * (heightMinusGround - spacing);

    _topPipe =
        Pipe(pipePosition: PipePosition.top, height: centerY - spacing / 2);
    _bottomPipe = Pipe(
        pipePosition: PipePosition.bottom,
        height: heightMinusGround - (centerY + spacing / 2));

    addAll([
      _topPipe,
      _bottomPipe,
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.x -= gameRef.speed * dt;
    if (position.x < -50) {
      removeFromParent();
    }
  }
}
