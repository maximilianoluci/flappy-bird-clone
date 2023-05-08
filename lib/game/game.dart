import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappybirdclone/game/background.dart';
import 'package:flappybirdclone/game/bird.dart';
import 'package:flappybirdclone/game/floor.dart';
import 'package:flappybirdclone/game/pipegroup.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  FlappyBirdGame();

  double speed = 200;
  late Bird _bird;
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  Future<void> onLoad() async {
    await _initSpeech();
    addAll([
      Background(),
      Floor(),
      _bird = Bird(),
      PipeGroup(),
    ]);
  }

  Future<void> _initSpeech() async {
    _speechEnabled =
        await _speechToText.initialize(onError: (e) => print('ERROR $e'));
    _startListening();
  }

  void _startListening() async {
    if (_speechEnabled) {
      await _speechToText.listen(onResult: _onSpeechResult);
    } else {
      _initSpeech();
    }
  }

  Future<void> stopListening() async {
    await _speechToText.cancel();
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    String newWords = result.recognizedWords.toLowerCase();
    newWords = newWords.replaceAll(_lastWords.toLowerCase(), '');
    _lastWords = result.recognizedWords;
    if (newWords.toLowerCase().contains('jump')) {
      _bird.fly();
    }
  }

  restartGame() {
    // _bird.reset();
  }

  @override
  void onTap() {
    super.onTap();
    _bird.fly();
  }
}
