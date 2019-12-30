import 'package:flutter/foundation.dart';

class Question {
  final String question;
  final List<String> answer;
  final String hint;
  final String type;

  Question({
    @required this.question,
    @required this.answer,
    @required this.hint,
    @required this.type,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'] as String,
      answer: new List<String>.from(json['answer']),
      hint: json['hint'] as String,
      type: json['type'] as String,
    );
  }
}
