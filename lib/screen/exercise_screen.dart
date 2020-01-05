import 'package:flutter/material.dart';
import 'package:grammer_drill/model/answer.dart';
import 'package:grammer_drill/model/question.dart';
import 'package:grammer_drill/screen/result_screen.dart';
import 'package:grammer_drill/service/text_service.dart';
import 'package:grammer_drill/widget/button.dart';

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
  Map<int, String> _responses = {};
  bool _showHint = false;
  bool _checkAnswer = false;
  int _currentQuestion = 0;

  _ExerciseScreenState(int questionNumber)
      : this._answers = List(questionNumber);

  void onCheckAnswers() => setState(() => _checkAnswer = true);

  void onChangeResponse(int index, String response) {
    setState(() {
      _checkAnswer = false;
      _responses = Map.of(_responses);
      _responses[index] = response;
    });
  }

  void onPreviousQuestion(Question question, List<Widget> widgets) {
    var index = _currentQuestion - 1;
    setState(() {
      _answers[_currentQuestion] = Answer(question: question, responses: _responses);
      _currentQuestion = index;
      _checkAnswer = false;
      _responses = _answers[index].responses;
    });
  }

  void onNextQuestion(Question question, List<Widget> widgets) {
    var index = _currentQuestion + 1;
    setState(() {
      _answers[_currentQuestion] = Answer(question: question, responses: _responses);
      _currentQuestion = index;
      _checkAnswer = false;
      _responses = _answers[index] == null ? {} : _answers[index].responses;
    });
  }

  void onFinish(Question question, List<Widget> widgets) {
    _answers[_currentQuestion] = Answer(question: question, responses: _responses);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(answers: _answers),
        ));
  }

  void showAnswers(Question question) {
    setState(() {
      _responses = widget.data[_currentQuestion].answer.asMap();
    });
  }

  @override
  Widget build(BuildContext context) {
    Question question = widget.data[_currentQuestion];
    bool isTheLastQuestion = _currentQuestion == widget.data.length - 1;
    var widgets =
        TextService.parseText(question.question, _responses, question.answer, _checkAnswer, onChangeResponse, context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Wrap(
                      runSpacing: 4,
                      children: widgets,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                        child: Text("answers", style: TextStyle(color: Colors.blueGrey)),
                        onPressed: () => showAnswers(question),
                      ),
                      FlatButton(
                        child: Text(_showHint ? "hide hint" : "show hint", style: TextStyle(color: Colors.blueGrey)),
                        onPressed: () => setState(() => _showHint = !_showHint),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    question.hint,
                    style: TextStyle(color: _showHint ? Colors.grey : Colors.transparent),
                  ),
                ),
              ],
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
                  onPressed: () => onPreviousQuestion(question, widgets),
                )),
                Expanded(
                    child: Button(text: 'Check', left: true, key: Key(question.question), onPressed: onCheckAnswers)),
                Expanded(
                    child: Button(
                  text: isTheLastQuestion ? 'Finish' : 'Next',
                  right: true,
                  onPressed: () => isTheLastQuestion ? onFinish(question, widgets) : onNextQuestion(question, widgets),
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
