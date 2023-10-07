import 'package:flutter/material.dart';

import 'package:qa_app/data/questions.dart';
import 'package:qa_app/questions_screen.dart';
import 'package:qa_app/results_screen.dart';
import 'package:qa_app/start_screen.dart';

enum ScreenName { startScreen, questionScreen, resultScreen }

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  ScreenName activeScreen = ScreenName.startScreen;
  List<String> selectedAnswers = [];

  void switchScreen() {
    setState(() {
      activeScreen = ScreenName.questionScreen;
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);
    if (selectedAnswers.length == questions.length) {
      setState(() {
        selectedAnswers = [];
        activeScreen = ScreenName.resultScreen;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget currentScreen = StartScreen(switchScreen);

    if (activeScreen == ScreenName.questionScreen) {
      currentScreen = QuestionsScreen(onSelectAnswer: chooseAnswer);
    } else if (activeScreen == ScreenName.resultScreen) {
      currentScreen = const ResultsScreen();
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 78, 13, 151),
                Color.fromARGB(255, 107, 15, 168),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: currentScreen,
        ),
      ),
    );
  }
}
