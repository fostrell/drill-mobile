import 'package:flutter/material.dart';
import 'package:grammer_drill/model/question.dart';
import 'package:grammer_drill/screen/exercise_screen.dart';
import 'package:grammer_drill/widget/button.dart';

class SettingsScreen extends StatefulWidget {
  final List<Question> data;

  SettingsScreen(this.data);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double _questionNumber = 10;
  bool _isRandom = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: ListView(children: <Widget>[
                Container(
                    child: Text('Settings', style: Theme.of(context).textTheme.title),
                    padding: const EdgeInsets.all(16.0)),
                Container(
                    child: Text('Number of questions ${_questionNumber.toInt()}/${widget.data.length}'),
                    padding: const EdgeInsets.only(left: 16.0, top: 16.0)),
                Slider(
                  activeColor: Theme.of(context).accentColor,
                  min: 1.0,
                  max: widget.data.length.toDouble(),
                  onChanged: (newNumber) {
                    setState(() => _questionNumber = newNumber);
                  },
                  value: _questionNumber,
                ),
                Divider(),
                CheckboxListTile(
                  activeColor: Theme.of(context).accentColor,
                  title: Text('Questions in random order', style: Theme.of(context).textTheme.body1),
                  onChanged: (value) {
                    setState(() => _isRandom = value);
                  },
                  value: _isRandom,
                ),
                Divider(),
              ]),
            ),
            Button(
                text: 'Start',
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExerciseScreen(widget.data, _questionNumber.toInt(), _isRandom),
                    ))),
          ],
        ),
      ),
    );
  }
}
