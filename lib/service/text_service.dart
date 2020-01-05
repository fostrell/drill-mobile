import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grammer_drill/utils/text_utils.dart';
import 'package:grammer_drill/widget/input.dart';

class TextService {
  static int currentGapNumber = 0;

  static List<Widget> parseText(String text, Map<int, String> responses, List<String> answers, bool checkAnswer,
      Function onChangeResponse, BuildContext context) {
    currentGapNumber = 0;
    List<Widget> result = [];
    text.split(' ').forEach((item) =>
        result.addAll(TextService._creteWidgets(item, responses, answers, checkAnswer, onChangeResponse, context)));
    return result;
  }

  static List<Widget> _creteWidgets(String text, Map<int, String> responses, List<String> answers, bool checkAnswer,
      Function onChangeResponse, BuildContext context) {
    List<String> items = text.replaceAll('__', "\$\$\$__\$\$\$").split('\$\$\$');
    List<Widget> result = [];
    for (var item in items) {
      if (item == '__') {
        result.add(Input(
          index: currentGapNumber,
          isChecking: checkAnswer,
          onChange: onChangeResponse,
          correctAnswer: answers[currentGapNumber],
          text: responses[currentGapNumber] ?? '',
        ));
        ++currentGapNumber;
      } else if (item != '') {
        result
            .add(Text(item, style: Theme.of(context).textTheme.title.copyWith(fontFamily: TextUtils.getFontFamily())));
      }
    }
    result.add(Text(' ', style: Theme.of(context).textTheme.title));
    return result;
  }
}
