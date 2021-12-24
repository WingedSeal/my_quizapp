import 'package:flutter/material.dart';

void main() => runApp(const Quizzler());

class Question {
  final bool answer;
  final String question;
  const Question(this.question, this.answer);
}

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Quiz App",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            backgroundColor: Colors.grey[850]),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  List<Icon> lastScoreKeeper = [];
  List<Question> questions = const [
    Question(
        'Bob bought 10 apples, for 5\$ each. Is temperature at the surface of the sun more than 6,600 Celsius?',
        false),
    Question(
        'From the fact that there is a quantum property of electrons called spin, does electron actually spin?',
        false),
    Question(
        'In python programming lanuage, you can put as many "yield" keyword as you want in a function.',
        true),
    Question('Github was created in 2007.', false),
    Question(
        'In python programming lanuage, default of "str(object)" will call "__str__" and then "__repr__" if that "__str__" method is not found.',
        true),
    Question('HTML with CSS is turing complete.', true),
    Question('Does every program that works on C work on C++?', false),
    Question('"React" is a frontend framework.', false),
    Question('Squirrel can survive impacts at their terminal velocity.', true),
  ];

  int questionNumber = 0;
  int score = 0;
  int lastScore = 0;

  void processAnswer(bool isCorrect) {
    setState(() {
      if (isCorrect) {
        score += 1;
        scoreKeeper.add(Icon(
          Icons.check,
          color: Colors.green[800],
        ));
      } else {
        scoreKeeper.add(const Icon(
          Icons.close,
          color: Colors.red,
        ));
      }
      // Next Question
      if (questionNumber < questions.length - 1) {
        questionNumber++;
      } else {
        lastScoreKeeper = scoreKeeper;
        lastScore = score;
        scoreKeeper = [];
        questionNumber = 0;
        score = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questions[questionNumber].question,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.green),
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                processAnswer(questions[questionNumber].answer);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              // color: Colors.red,
              style: ElevatedButton.styleFrom(primary: Colors.red),
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                processAnswer(!questions[questionNumber].answer);
              },
            ),
          ),
        ),
        //แสดงผล icon สำหรับ scoreKeeper
        Column(
          children: [
            Row(
              children: [
                const Text("Current Score: "),
                Row(
                  children: scoreKeeper,
                ),
              ],
            ),
            Row(
              children: [
                const Text("Last Score: "),
                Row(
                  children: lastScoreKeeper,
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                Text("Total: $lastScore"),
              ],
            ),
          ],
        )
      ],
    );
  }
}
