import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './quiz_data.dart'; // Import the questions

class QuizProvider with ChangeNotifier {
  final List<Map<String, Object>> _questions;
  int _questionIndex = 0;
  int _totalScore = 0;

  // Constructor to initialize questions
  QuizProvider() : _questions = questionslist {
    loadProgress(); // Load progress when the QuizProvider is initialized
  }

  List<Map<String, Object>> get questions => _questions;
  int get questionIndex => _questionIndex;
  int get totalScore => _totalScore;

  // Reset quiz to start fresh
  void resetQuiz() {
    _questionIndex = 0;
    _totalScore = 0;
    saveProgress(); // Save reset progress
    notifyListeners();
  }

  // Answer the question and move to the next one
  void answerQuestion(int score) {
    _totalScore += score;
    _questionIndex++;
    saveProgress(); // Save progress after each question is answered
    notifyListeners();
  }

  // Check if there are more questions left
  bool get hasMoreQuestions => _questionIndex < _questions.length;

  // Save progress to shared preferences
  Future<void> saveProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('questionIndex', _questionIndex);
    prefs.setInt('totalScore', _totalScore);
  }

  // Load progress from shared preferences
  Future<void> loadProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _questionIndex = prefs.getInt('questionIndex') ?? 0;
    _totalScore = prefs.getInt('totalScore') ?? 0;
    notifyListeners();
  }
}
