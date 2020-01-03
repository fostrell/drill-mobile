import 'package:grammer_drill/model/question.dart';

class Answer {
  final Question question;
  final bool correct;
  List<String> responses;

  Answer({
    this.question,
    this.correct,
    List<String> responses,
  }) : this.responses = responses != null ? responses : [];
}
