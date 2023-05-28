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
  int _scrollCounter = 0;

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
    _scrollCounter = 0;
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
    _scrollCounter++;

    if (_scrollCounter >= 5 &&
        _scrollCounter < 6 &&
        _currentPipeGroup != null) {
      counter++;
    }

    if (_timeSinceLastPipeGroup > 1.7) {
      _nextPipeGroup = PipeGroup();
      add(_nextPipeGroup);
      _timeSinceLastPipeGroup = 0;
      _scrollCounter = 0;
    }

    if (_nextPipeGroup != null && _timeSinceLastPipeGroup > 1) {
      _currentPipeGroup = _nextPipeGroup;
    }
  }
}
