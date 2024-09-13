import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nar_app2/models/question_model.dart';

class DBconnect {
  final url = Uri.parse(
      'https://quizapp-a375d-default-rtdb.firebaseio.com/questionsbtwo.json');
  Future<void> addQuestion(Question question) async {
    http.post(url,
        body: json.encode({
          'title': question.title,
          'options': question.options,
        }));
  }

  Future<List<Question>> fetchQuestions() async {
    return http.get(url).then((response) {
      var data = json.decode(response.body) as Map<String, dynamic>;
      List<Question> newQuestions = [];

      data.forEach((key, value) {
        var newQuestion = Question(
          id: key,
          title: value['title'],
          options: Map.castFrom(value['options']),
        );
        newQuestions.add(newQuestion);
      });
      //print(newQuestions);
      return newQuestions;
    });
  }
}
