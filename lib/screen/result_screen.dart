import 'package:flutter/material.dart';
import 'package:grammer_drill/model/answer.dart';
import 'package:grammer_drill/widget/button.dart';

class ResultScreen extends StatelessWidget {
  final List<Answer> _answers;
  final int _correctAnswersNumber;

  static int _calculateCorrectAnswers(List<Answer> answers) {
    int result = 0;
    answers.forEach((answer) {
      bool isCorrect = true;
      for (var i = 0; i < answer.responses.length; ++i) {
        if (answer.responses[i] != answer.question.answer[i]) {
          isCorrect = false;
        }
      }
      if (isCorrect) {
        ++result;
      }
    });
    return result;
  }

  ResultScreen({Key key, List<Answer> answers})
      : this._correctAnswersNumber = _calculateCorrectAnswers(answers),
        this._answers = answers,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var percent = _correctAnswersNumber > 0 ? (_correctAnswersNumber * 100 / _answers.length) : 0;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Correct answers: ',
                  ),
                  Text(
                    '$_correctAnswersNumber of ${_answers.length} / ${percent.toInt()}%',
                    style: Theme.of(context).textTheme.title,
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Button(text: 'Done', onPressed: () => Navigator.popUntil(context, (route) => route.isFirst)),
            ],
          ),
        ),
      ),
    );
  }
}
