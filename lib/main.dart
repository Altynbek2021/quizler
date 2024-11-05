import 'package:flutter/material.dart';
import 'package:quizler_app/quizbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Quizbrain quizBrain = Quizbrain();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scorekeeper = [];

  void checkAnswer(bool userSelectedAns) {
    bool correctAnswer = quizBrain.getguestionAnswer();
    setState(() {
      if (quizBrain.isFinised() == true) {
        Alert(
                context: context,
                title: "Finished",
                desc: "You have reached end of the quiz")
            .show();
        quizBrain.reset();
        scorekeeper = [];
      } else {
        if (correctAnswer == userSelectedAns) {
          scorekeeper.add(const Icon(
            Icons.close,
            color: Colors.red,
            size: 30,
          ));
        } else {
          scorekeeper.add(const Icon(
            Icons.check,
            color: Colors.blueAccent,
            size: 30,
          ));
        }
      }
      quizBrain.nextquestion();
    });
  }

  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                  child: Text(
                quizBrain.getquestionText(),
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              )),
            ),
          ),
          Row(
            children: [
              Expanded(
                /////////// True
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(400, 100)),
                  onPressed: () {
                    checkAnswer(true);
                  },
                  child: const Text("True"),
                ),
              ),
              Expanded(
                //////////// False
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size(400, 100)),
                  onPressed: () {
                    checkAnswer(false);
                  },
                  child: const Text("False"),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            reverse: true,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: scorekeeper,
            ),
          ),
          Text("you got $counter corect answer")
        ],
      ),
    );
  }
}
