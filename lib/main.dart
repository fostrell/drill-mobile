import 'package:flutter/material.dart';
import 'package:grammer_drill/model/question.dart';
import 'package:grammer_drill/screen/settings_screen.dart';
import 'package:grammer_drill/service/http_service.dart';
import 'package:grammer_drill/widget/button.dart';
import 'package:logger_flutter/logger_flutter.dart';

import 'model/http_response.dart';

void main() => runApp(Application());

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        accentColor: Colors.blueGrey,
      ),
      home: LogConsoleOnShake(child: HomePage()),
      /*routes: {*/ /**/ /*
        ExerciseScreen.id: (context) => ExerciseScreen(),
      }*/
    );
  }
}

class HomePage extends StatelessWidget {
  final HttpService httpService = HttpService();

  // FlushbarService.info("title", "message", Icons.access_alarm)..show(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: httpService.getQuestions(),
          // initialData: initialValue,
          builder: (BuildContext context, AsyncSnapshot<HttpResponse<List<Question>>> snapshot) {
            if (snapshot.hasData && snapshot.data.error == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'There are questions: ',
                        ),
                        Text(
                          '${snapshot.data.data.length}',
                          style: Theme.of(context).textTheme.title,
                        ),
                      ],
                    ),
                    SizedBox(height: 16,),
                    Button(
                        text: 'Start',
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettingsScreen(snapshot.data.data),
                            ))),
                  ],
                ),
              );
            } else if (snapshot.hasData && snapshot.data.error != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${snapshot.data.error}',
                      style: Theme.of(context).textTheme.display1,
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
