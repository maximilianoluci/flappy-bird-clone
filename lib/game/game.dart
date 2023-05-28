import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flappybirdclone/game/background.dart';
import 'package:flappybirdclone/game/bird.dart';
import 'package:flappybirdclone/game/floor.dart';
import 'package:flappybirdclone/game/pipegroup.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  FlappyBirdGame();

  double speed = 200;
  late Bird _bird;
  double _timeSinceLastPipeGroup = 0;
  late PipeGroup _currentPipeGroup;
  var _nextPipeGroup;

  @override
  Future<void> onLoad() async {
    FlameAudio.bgm.play("bgm.mp3");

    _currentPipeGroup = PipeGroup();

    addAll([
      Background(),
      Floor(),
      _bird = Bird(),
      _currentPipeGroup,
    ]);
  }

  restartGame() {
    _bird.reset();
    _currentPipeGroup.removeFromParent();
  }

  @override
  void onTap() {
    super.onTap();
    _bird.fly();
    FlameAudio.play("jump.wav");
  }

  @override
  void update(double dt) {
    super.update(dt);
    _timeSinceLastPipeGroup += dt;

    if (_timeSinceLastPipeGroup > 1.7) {
      _nextPipeGroup = PipeGroup();
      add(_nextPipeGroup);
      _timeSinceLastPipeGroup = 0;
    }

    if (_nextPipeGroup != null && _timeSinceLastPipeGroup > 1) {
      _currentPipeGroup = _nextPipeGroup;
    }
  }
}
