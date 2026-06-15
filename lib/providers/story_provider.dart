import 'package:flutter/material.dart';
import '../services/tts_service.dart';
import '../utils/constants.dart';

class StoryProvider extends ChangeNotifier {
  final TTSService _ttsService = TTSService();

  bool isLoading = false;
  bool isSpeaking = false;
  bool showQuiz = false;
  bool isSuccess = false;

  String? errorMessage;
  String? feedbackMessage;

  Future<void> readStory() async {
    try {
      isLoading = true;
      errorMessage = null;
      feedbackMessage = null;
      showQuiz = false;
      isSuccess = false;

      notifyListeners();

      await _ttsService.initialize();

      _ttsService.setCompletionHandler(() {
        isSpeaking = false;
        showQuiz = true;
        notifyListeners();
      });

      isLoading = false;
      isSpeaking = true;
      notifyListeners();

      await _ttsService.speak(
        AppConstants.storyText,
      );
    } catch (e) {
      isLoading = false;
      isSpeaking = false;
      errorMessage = "Failed to play story";
      notifyListeners();
    }
  }

  void checkAnswer(String selectedAnswer) {
    if (selectedAnswer ==
        AppConstants.quizJson["answer"]) {
      isSuccess = true;
      feedbackMessage = "Correct Answer!";
    } else {
      feedbackMessage = "Oops! Try Again.";
    }

    notifyListeners();
  }

  void markSuccess() {
    isSuccess = true;
    notifyListeners();
  }

  void resetQuiz() {
    isSuccess = false;
    feedbackMessage = null;
    notifyListeners();
  }
}

