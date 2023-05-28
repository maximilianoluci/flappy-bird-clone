import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flappybirdclone/game/background.dart';
import 'package:flappybirdclone/game/bird.dart';
import 'package:flappybirdclone/game/floor.dart';
import 'package:flappybirdclone/game/pipegroup.dart';
import 'package:flappybirdclone/game/score.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  FlappyBirdGame();

  double speed = 200;
  late Bird _bird;
  double _timeSinceLastPipeGroup = 0;
  int counter = -1;
  var _currentPipeGroup;
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
      Score(),
    ]);
  }

  restartGame() {
    _bird.reset();
    _currentPipeGroup.removeFromParent();
    _currentPipeGroup = null;
    counter = 0;
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

    if (_timeSinceLastPipeGroup > 0.71 &&
        _timeSinceLastPipeGroup < 0.72 &&
        _currentPipeGroup != null) {
      counter++;
    }
    if (_nextPipeGroup != null && _timeSinceLastPipeGroup > 1) {
      _currentPipeGroup = _nextPipeGroup;
    }
  }
}
