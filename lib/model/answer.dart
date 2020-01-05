import 'package:grammer_drill/model/question.dart';

class Answer {
  final Question question;
  final bool correct;
  Map<int, String> responses;

  Answer({
    this.question,
    this.correct,
    Map<int, String> responses,
  }) : this.responses = responses != null ? responses : {};
}
