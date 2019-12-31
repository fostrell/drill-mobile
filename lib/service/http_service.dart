import 'dart:convert';
import 'package:grammer_drill/model/http_response.dart';
import 'package:grammer_drill/model/question.dart';
import 'package:http/http.dart';

class HttpService {
  final String postsURL = "http://10.0.2.2:8080/data";

  Future<HttpResponse<List<Question>>> getQuestions() async {
    try {
      Response res = await get(postsURL);

      if (res.statusCode == 200) {
            List<dynamic> body = jsonDecode(res.body);

            List<Question> posts = body
                .map(
                  (dynamic item) => Question.fromJson(item),
            )
                .toList();

            return new HttpResponse<List<Question>>(data: posts);
          } else {
            return new HttpResponse<List<Question>>(error: '${res.statusCode} ${res.reasonPhrase}');
          }
    } catch (e) {
      return new HttpResponse<List<Question>>(error: e.toString());
    }
  }
}
