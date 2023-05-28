import 'package:flame/components.dart';
import 'package:flappybirdclone/game/game.dart';

class Score extends TextComponent with HasGameRef<FlappyBirdGame> {
  late String score;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    positionType = PositionType.viewport;
    text = getScore();
    anchor = Anchor.topCenter;
    position = Vector2(gameRef.size.x / 2, 60);
    scale = Vector2(3, 3);
  }

  @override
  void update(double dt) {
    super.update(dt);
    // score = gameRef.counter.toString();
    text = getScore();
  }

  String getScore() {
    int counter = gameRef.counter;

    if (counter < 0) {
      counter = 0;
    }

    return counter.toString();
  }
}
