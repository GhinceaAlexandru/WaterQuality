import 'dart:async';
import 'package:flutter/material.dart';
import 'question_model.dart';
import 'waterimportance.dart';

class QuizScreen extends StatefulWidget {
  // Declare a GlobalKey.
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> questionList = [];
  int currentQuestionIndex = 0;
  int score = 0;
  Answer? selectedAnswer;

  @override
  void initState() {
    super.initState();
    List<Question> allQuestions = getQuestions();
    allQuestions.shuffle(); // Shuffle all the questions
    questionList = allQuestions.sublist(
        0, 4); // Select the first four questions from the shuffled list
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: widget.navigatorKey, // Set the GlobalKey here.
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 5, 50, 80),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "Let's see what you got.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              _questionWidget(),
              _answerList(),
              _nextButton(),
            ],
          ),
        ),
      ),
    );
  }

  _questionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Question ${currentQuestionIndex + 1}/${questionList.length.toString()}",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.orangeAccent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Text(
                questionList[currentQuestionIndex].questionText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  _answerList() {
    return Column(
      children: questionList[currentQuestionIndex]
          .answersList
          .map((e) => _answerButton(e))
          .toList(),
    );
  }

  Widget _answerButton(Answer answer) {
    bool isSelected = answer == selectedAnswer;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 48,
      child: ElevatedButton(
        child: Text(answer.answerText),
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: isSelected ? Colors.orangeAccent : Colors.white,
          onPrimary: isSelected ? Colors.white : Colors.black,
        ),
        onPressed: () {
          if (mounted) {
            setState(() {
              selectedAnswer = answer;
            });
          }
        },
      ),
    );
  }

  _onPressedNextButton() {
    if (selectedAnswer == null) {
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) => AlertDialog(
          title: Text('Error'),
          content: Text('Please select an answer'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        ),
      );
    } else {
      _goToNextQuestion();
    }
  }

  _nextButton() {
    bool isLastQuestion = currentQuestionIndex == questionList.length - 1;

    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 48,
      child: ElevatedButton(
        child: Text(isLastQuestion ? "Submit" : "Next"),
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: Colors.blueAccent,
          onPrimary: Colors.white,
        ),
        onPressed: _onPressedNextButton, // Call the function here
      ),
    );
  }

  void _goToNextQuestion() {
    if (selectedAnswer != null && selectedAnswer!.isCorrect) {
      score++;
    }

    if (currentQuestionIndex == questionList.length - 1) {
      // Display score
      _showScoreDialog();
    } else {
      // Next question
      if (mounted) {
        setState(() {
          selectedAnswer = null;
          currentQuestionIndex++;
        });
      }
    }
  }

  _showScoreDialog() {
    bool isPassed = score >= questionList.length * 0.6;
    String title = isPassed ? "Congratulations," : "Unfortunately ...";

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) => WillPopScope(
        onWillPop: () async => false, // block Android back button
        child: AlertDialog(
          title: Text(
            '$title you got $score correct',
            style: TextStyle(color: isPassed ? Colors.green : Colors.redAccent),
          ),
          content: ElevatedButton(
            child: const Text("Go back"),
            onPressed: () {
              Navigator.of(dialogContext).pop(); // Here we use dialogContext

              Future.delayed(Duration(milliseconds: 500), () {
                if (mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WaterImportanceApp(),
                    ),
                  );
                }
              });
            },
          ),
        ),
      ),
    );
  }
}
