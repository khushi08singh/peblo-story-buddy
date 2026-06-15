import 'package:flutter_tts/flutter_tts.dart';

class TTSService {
  final FlutterTts flutterTts = FlutterTts();

  Future<void> initialize() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.45);
  }

  Future<void> speak(String text) async {
    await flutterTts.speak(text);
  }

  void setCompletionHandler(Function() onComplete) {
    flutterTts.setCompletionHandler(() {
      onComplete();
    });
  }

  Future<void> stop() async {
    await flutterTts.stop();
  }
}