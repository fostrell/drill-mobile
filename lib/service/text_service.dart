import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grammer_drill/utils/text_utils.dart';
import 'package:grammer_drill/widget/input.dart';

class TextService {
  static int currentGapNumber = 0;

  static List<Widget> parseText(String text, int currentNumber, List<String> responses, BuildContext context) {
    currentGapNumber = 0;
    List<Widget> result = [];
    text
        .split(' ')
        .forEach((item) => result.addAll(TextService._creteWidgets(item, currentNumber, responses, context)));
    return result;
  }

  static List<Widget> _creteWidgets(String text, int currentNumber, List<String> responses, BuildContext context) {
    List<String> items = text.replaceAll('__', "\$\$\$__\$\$\$").split('\$\$\$');
    List<Widget> result = [];
    for (var item in items) {
      if (item == '__') {
        result.add(Input(
          key: Key('$currentNumber$currentGapNumber'),
          gapNumber: currentGapNumber,
          text: responses.length > currentGapNumber ? responses[currentGapNumber] : null,
        ));
        ++currentGapNumber;
      } else {
        result
            .add(Text(item, style: Theme.of(context).textTheme.title.copyWith(fontFamily: TextUtils.getFontFamily())));
      }
    }
    result.add(Text(' ', style: Theme.of(context).textTheme.title));
    return result;
  }
}
