// api calls here

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_test/models.dart';

String uri = "http://www.dirediredocks.xyz/api/";

// returns json list of problems of topic
Future<List<Problem>> fetchProblems(String topic) async {
  final response = await http.get(
    Uri.parse("${uri}test/topic/$topic")
  );

  if (response.statusCode == 200) {
    var p = jsonDecode(response.body);
    var problems = List<Problem>.empty(growable: true);
    for (int i = 0; i < p.length; i++) {
      problems.add(Problem.fromJson(p[i]));
    }
    return problems;
  } else {
    throw Exception('Failed to load problems!');
  }
}