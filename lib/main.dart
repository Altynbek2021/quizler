import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scorekeeper = [];
  List<String> questions = [
    "The black box in a plane is black", // false
    "There are five different blood groups", // false
    "The only letter not in the periodic table is the letter J", //true
    "Thomas Edison discovered gravity", // false
    "Venus is the hottest planet in the solar system" //true
  ];

  int currentIndex = 0;

  String question() {
    if (currentIndex < questions.length) {
      return questions[currentIndex++];
    } else {
      currentIndex = 0; // Reset to start over if needed
      return questions[currentIndex++];
    }
  }

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
                question(),
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              )),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(400, 100)),
                  onPressed: () {
                    setState(() {
                      scorekeeper.add(const Icon(
                        Icons.check,
                        color: Colors.blueAccent,
                        size: 30,
                      ));
                    });
                  },
                  child: const Text("True"),
                ),
              ),
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size(400, 100)),
                  onPressed: () {
                    setState(() {
                      scorekeeper.add(const Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 30,
                      ));
                    });
                  },
                  child: const Text("False"),
                ),
              ),
            ],
          ),
          Row(
            children: scorekeeper,
          ),
        ],
      ),
    );
  }
}
