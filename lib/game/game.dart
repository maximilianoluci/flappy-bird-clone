import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappybirdclone/game/background.dart';
import 'package:flappybirdclone/game/bird.dart';
import 'package:flappybirdclone/game/floor.dart';
import 'package:flappybirdclone/game/pipegroup.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  FlappyBirdGame();

  double speed = 200;
  late Bird _bird;
  double _timeSinceLastPipeGroup = 0;

  @override
  Future<void> onLoad() async {
    addAll([
      Background(),
      Floor(),
      _bird = Bird(),
      PipeGroup(),
    ]);
  }

  restartGame() {
    _bird.reset();
  }

  @override
  void onTap() {
    super.onTap();
    _bird.fly();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _timeSinceLastPipeGroup += dt;

    if (_timeSinceLastPipeGroup > 1.7) {
      add(PipeGroup());
      _timeSinceLastPipeGroup = 0;
    }
  }
}
