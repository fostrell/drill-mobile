import 'dart:convert';
import 'package:grammer_drill/model/question.dart';
import 'package:http/http.dart';

class HttpService {
  final String postsURL = "http://10.0.2.2:8080/data";

  Future<List<Question>> getQuestions() async {
    Response res = await get(postsURL);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Question> posts = body
          .map(
            (dynamic item) => Question.fromJson(item),
      )
          .toList();

      return posts;
    } else {
      throw "Can't get posts.";
    }
  }
}
