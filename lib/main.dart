import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';

QuizBrain quizBrain = new QuizBrain();
void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
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
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  void checkAnswer(userPickedAnswer) {
    if (quizBrain.isFinnished()) {
      Alert(
          context: context,
          type: AlertType.success,
          title: "QUIZZLER",
          desc: "YOU HAVE FINNISHED THE QUIZ",
          buttons: [
            DialogButton(
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    scoreKeeper.clear();
                    quizBrain.reset();
                  });
                  Navigator.pop(context);
                }),
          ]).show();
    } else {
      bool correctAnswer = quizBrain.getQuestionAnswer();
      if (userPickedAnswer == correctAnswer) {
        scoreKeeper.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
      } else {
        scoreKeeper.add(Icon(
          Icons.close,
          color: Colors.red,
        ));
      }
      setState(() {
        //increment question Number
        quizBrain.nextQuestion();
      });
    }
  }

  //List<String> questions = [
  //  'You can lead a cow down stairs but not up stairs.',
  //  'Approximately one quarter of human bones are in the feet.',
  //  'A slug\'s blood is green.',
  //];

  //int questionNumber = 0;

  //List<bool> answers = [
  //  false,
  //  true,
  //  true,
  //];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              onPressed: () {
                checkAnswer(true);
              },
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}

/*
question1: , false,
question2: , true,
question3: , true,
*/
