import 'dart:convert';
import 'package:http/http.dart' as http;

final String apiUrl = "https://facha-help.herokuapp.com/questions";

class DiscussionApi {
  Future<List> getData() async {
    final response = await http.get(apiUrl);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
      return null;
    }
  }

  Future<void> postData(String question, String writer) async {
    await http.post(apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{"q_body": question, "writer_name": writer},
        ));
  }

  Future<void> deleteQuestion(String id) async {
    await http.delete(
      apiUrl,
      headers: <String, String>{},
    );
  }
}
