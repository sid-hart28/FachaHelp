import 'dart:convert';
import 'package:http/http.dart' as http;

final String apiUrl = "https://facha-help.herokuapp.com";

class DiscussionApi {
  Future<List> getQuestions() async {
    final response = await http.get("$apiUrl/questions");
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
      return null;
    }
  }

  Future<void> postQuestion(String question, String writer) async {
    await http.post("$apiUrl/questions",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{"q_body": question, "writer_name": writer},
        ));
  }

  Future<void> deleteQuestion(String qId) async {
    await http.delete(
      "$apiUrl/questions/$qId",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }

  Future<void> updateQuestion(String qId, String editedQuestion) async {
    await http.patch("$apiUrl/questions/$qId",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{"q_body": editedQuestion},
        ));
  }

  Future<List> getAnswers(String qId) async {
    final response = await http.get(
      "$apiUrl/answers/$qId",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("error in get ${response.statusCode}");
      return null;
    }
  }

  Future<void> postAnswer(String qId, String answer, String writer) async {
    await http.post("$apiUrl/answers/$qId",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            "a_body": answer,
            "writer_name": writer,
          },
        ));
  }

  Future<void> deleteAnswer(String qId, String ansId) async {
    await http.delete(
      "$apiUrl/answers/$qId/$ansId",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }

  Future<void> updateAnswer(
      String qId, String ansId, String editedAnswer) async {
    await http.patch("$apiUrl/answers/$qId/$ansId",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{"a_body": editedAnswer},
        ));
  }
}
