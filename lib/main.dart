import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'quiz_brain.dart';
//import 'questions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('imagesss/nature1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: const Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: MyhomePage(),
          ),
        ),
      ),
    );
  }
}

class MyhomePage extends StatefulWidget {
  const MyhomePage({Key? key}) : super(key: key);

  @override
  State<MyhomePage> createState() => _MyhomePageState();
}

class _MyhomePageState extends State<MyhomePage> {
  List<Icon> Iconlist = [];

  Quizbrain qb = new Quizbrain();
  int score = 0;
  int qnum = 1;

  void checkAnswer(bool k) {
    setState(
      () {
        bool checkAnswer = qb.getAnswer();
        if (qnum < 13) {
          qnum++;
        }
        if (checkAnswer == k) {
          if (qnum < 13) {
            qb.scoreIncrease();
          }
          score = qb.getScore();
          if (Iconlist.length < 13) {
            Iconlist.add(
              const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
              ),
            );
          }
        } else {
          if (Iconlist.length < 13) {
            Iconlist.add(
              const Icon(
                Icons.cancel,
                color: Colors.red,
              ),
            );
          }
        }
        if (qb.nextQuestion()) {
        } else {
          Alert(
            context: context,
            type: AlertType.warning,
            title: "The Quiz is Over",
            desc: "Your Final Score is: $score/13 !",
            buttons: [
              DialogButton(
                child: const Text(
                  "Play Again! ",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  setState(() {
                    Iconlist = [];
                    qnum = 1;
                    score = 0;
                    qb.startQuizAgain();
                    Navigator.pop(context);
                  });
                },
                color: Color.fromRGBO(0, 179, 134, 1.0),
              ),
              DialogButton(
                child: const Text(
                  "Exit",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  SystemNavigator.pop();
                },
                gradient: const LinearGradient(colors: [
                  Color.fromRGBO(116, 116, 191, 1.0),
                  Color.fromRGBO(52, 138, 199, 1.0)
                ]),
              )
            ],
          ).show();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Card(
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          color: const Color.fromARGB(102, 54, 48, 69),
          shadowColor: Colors.white54,
          child: Row(
            children: [
              const Icon(
                Icons.water_damage,
                color: Colors.green,
              ),
              Text(
                ':\tScore : $score/13',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              const Icon(
                Icons.star,
                color: Colors.green,
              ),
              Text(
                ':\tQ.No : $qnum/13',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                qb.getQuestion(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Row(
          children: Iconlist,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () {
                checkAnswer(true);
              },
              child: const Center(
                child: Text(
                  'True',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                checkAnswer(false);
              },
              child: const Center(
                child: Text(
                  'False',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
