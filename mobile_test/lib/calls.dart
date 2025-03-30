import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_test/models.dart';

String uri = "http://www.dirediredocks.xyz/api/";

// returns list of problems of topic
Future<List<Problem>> fetchProblems(String topic) async {
  final response = await http.get(
    Uri.parse("${uri}test/topic/$topic")
  );

  if (response.statusCode == 200) {
    // decode the json response
    var p = jsonDecode(response.body);
    // build a list of problem objects
    var problems = List<Problem>.empty(growable: true);
    for (int i = 0; i < p.length; i++) {
      // throw each problem json into the factory to add to the problemlist
      problems.add(Problem.fromJson(p[i]));
    }
    return problems;
  } else {
    throw Exception('Failed to load problems!');
  }
}

// returns list of mocktest problems
Future<List<Problem>> fetchMockTest() async {
  final response = await http.get(
    Uri.parse("${uri}test/mocktest")
  );

  if (response.statusCode == 200) {
    // decode the json response
    var p = jsonDecode(response.body)["problems"];
    // build a list of problem objects
    var problems = List<Problem>.empty(growable: true);
    for (int i = 0; i < p.length; i++) {
      // throw each problem json into the factory to add to the problemlist
      problems.add(Problem.fromJson(p[i]));
    }
    return problems;
  } else {
    throw Exception('Failed to load problems!');
  }
}

// submits an answer object to the database
void postAnswer(Answer answer) async {
  var token = ""; //TODO
  final response = await http.post(
    Uri.parse("${uri}test/submit"),
    body: jsonEncode(Answer.toJson(answer)),
    headers: {
      "Authorization": "Bearer ${token}",
    }
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to submit answer!');
  }
}