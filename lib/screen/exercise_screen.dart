import 'package:flutter/material.dart';
import 'package:grammer_drill/model/answer.dart';
import 'package:grammer_drill/model/question.dart';
import 'package:grammer_drill/screen/result_screen.dart';
import 'package:grammer_drill/service/text_service.dart';
import 'package:grammer_drill/widget/button.dart';
import 'package:grammer_drill/widget/input.dart';

class ExerciseScreen extends StatefulWidget {
  static List<Question> initData(List<Question> data, int questionNumber, bool isRandom) {
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
  _ExerciseScreenState createState() => _ExerciseScreenState(questionNumber);
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  List<Answer> _answers;
  List<Widget> _widgets;
  int _currentQuestion = 0;

  _ExerciseScreenState(int questionNumber) : this._answers = List(questionNumber);

  void onCheckAnswers(Question question) {
    _widgets.forEach(((item) {
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
  }

  List<String> getResponses() {
    List<String> responses = [];
    _widgets.forEach(((item) {
      if (item is Input) {
        responses.add(item.text);
      }
    }));
    return responses;
  }

  void onPreviousQuestion(Question question) {
    setState(() {
      _answers[_currentQuestion] = Answer(question: question, responses: getResponses());
      --_currentQuestion;
    });
  }

  void onNextQuestion(Question question) {
    setState(() {
      _answers[_currentQuestion] = Answer(question: question, responses: getResponses());
      ++_currentQuestion;
    });
  }

  void onFinish(Question question) {
    _answers[_currentQuestion] = Answer(question: question, responses: getResponses());
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(answers: _answers),
        ));
  }

  @override
  Widget build(BuildContext context) {
    Question question = widget.data[_currentQuestion];
    bool isTheLastQuestion = _currentQuestion == widget.data.length - 1;
    List<String> responses = _answers[_currentQuestion] != null ? _answers[_currentQuestion].responses : [];
    _widgets = TextService.parseText(question.question, _currentQuestion, responses, context);
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
                  children: _widgets,
                ),
              ),
            ),
            Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('${_currentQuestion + 1} / ${widget.data.length}'),
                )
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                    child: Button(
                  text: 'Prev',
                  left: true,
                  disabled: _currentQuestion == 0,
                  onPressed: () => onPreviousQuestion(question),
                )),
                Expanded(
                    child: Button(
                        text: 'Check',
                        left: true,
                        key: Key(question.question),
                        onPressed: () => onCheckAnswers(question))),
                Expanded(
                    child: Button(
                  text: isTheLastQuestion ? 'Finish' : 'Next',
                  right: true,
                  onPressed: () => isTheLastQuestion ? onFinish(question) : onNextQuestion(question),
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
