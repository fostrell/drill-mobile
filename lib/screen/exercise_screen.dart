import 'package:flutter/material.dart';
import 'package:grammer_drill/model/answer.dart';
import 'package:grammer_drill/model/question.dart';
import 'package:grammer_drill/service/text_service.dart';
import 'package:grammer_drill/widget/button.dart';
import 'package:grammer_drill/widget/input.dart';

class ExerciseScreen extends StatefulWidget {
  static initData(List<Question> data, int questionNumber, bool isRandom) {
    if (isRandom) {
      data.shuffle();
    }
    return data.sublist(0, questionNumber);
  }

  final List<Question> data;
  final int questionNumber;
  final bool isRandom;

  ExerciseScreen(data, questionNumber, isRandom)
      : this.data = initData(data, questionNumber, isRandom),
        this.questionNumber = questionNumber,
        this.isRandom = isRandom;

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  List<Answer> _answers = [];
  int _currentQuestion = 1;

  @override
  Widget build(BuildContext context) {
    Question question = widget.data[_answers.length];
    var widgets = TextService.parseText(question.question, context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Wrap(
                  runSpacing: 4,
                  children: widgets,
                ),
              ),
            ),
            Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('$_currentQuestion / ${widget.data.length}'),
                )
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                    child: Button(
                  text: 'Previous',
                  left: true,
                  disabled: _currentQuestion == 1,
                )),
                Expanded(child: Button(text: 'Check', right: true, onPressed: () {
                  widgets.forEach(((item) {
                    if (item is Input) {
                      if (question.answer[item.gapNumber] == item.text) {
                        item.success(true);
                        item.error(false);
                      } else {
                        item.success(false);
                        item.error(true);
                      }
                    }
                  }));
                },)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
