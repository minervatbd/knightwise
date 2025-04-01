import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile_test/models.dart';

String uri = "http://www.dirediredocks.xyz/api/";

Future<ResetPassword> resetPassword(String email, String password) async {
  final response = await http.post(
    Uri.parse('${uri}auth/resetPassword'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'email': email, 'password': password}),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return ResetPassword.fromJson(jsonDecode(response.body));
  } else if (response.statusCode >= 400 && response.statusCode < 500) {
    return ResetPassword.fromJson(jsonDecode(response.body));
  }else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

Future<Login> createLogin(String username, String password) async {
  final response = await http.post(
    Uri.parse('${uri}auth/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'username': username, 'password': password}),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Login.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    final resBody = jsonDecode(response.body);
    throw Exception(resBody['message'] ?? 'Login failed');
  }
}

Future<Verify> verifyEmail(String email, String otp) async {
  final response = await http.post(
    Uri.parse('${uri}auth/verify'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'email': email, 'otp': otp}),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Verify.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

Future<SendOtp> sendEmailCode(String email, String reason) async {
  final response = await http.post(
    Uri.parse('${uri}auth/sendotp'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'email': email, 'purpose': reason}),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return SendOtp.fromJson(jsonDecode(response.body));
  } else if (response.statusCode >= 400 && response.statusCode < 500) {
    return SendOtp.fromJson(jsonDecode(response.body));
  }else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to fetch album');
  }
}

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
  CurrentUser currUser = CurrentUser();
  var token = currUser.token;

  final response = await http.post(
    Uri.parse("${uri}test/submit"),
    body: jsonEncode(Answer.toJson(answer)),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Bearer $token",
    }
  );

  if (response.statusCode != 201) {
    throw Exception("Failed: ${response.statusCode} - ${response.body}");
  }
}

// Sends new user data to server
Future <http.Response> postData({
  required String firstName,
  required String lastName,
  required String userName,
  required String password,
  required String email,
})async{
  try{
    var response = await http.post(
      Uri.parse("${uri}auth/signup"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
      "username": userName,
      "password": password,
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      }),
    );
    return response;

  } catch (e){
    throw Exception("Error: $e");
  }
}

class Topic{
  final int correct;
  final int total;
  final double percentage;
  final String name;

  const Topic({
    required this.correct,
    required this.total,
    required this.percentage,
    required this.name,
  });

  factory Topic.fromJson(String topic, Map<String, dynamic> json) {
    return  Topic(
      correct: json["correct"],
      total: json["total"],
      percentage: double.parse(json["percentage"]),
      name: topic,
    );

  }
}

class Progress {
  //final List<Topic> topics;
  //there are 17 topics
  final Topic AlgorithmAnalysis;
  final Topic AVLTrees;
  final Topic Backtracking;
  final Topic BaseConversion;
  final Topic BinaryTrees;
  final Topic BitwiseOperators;
  final Topic DynamicMemory;
  final Topic HashTables;
  final Topic Heaps;
  final Topic LinkedLists;
  final Topic Queues;
  final Topic RecurrenceRelations;
  final Topic Recursion;
  final Topic Sorting;
  final Topic Stacks;
  final Topic Summations;
  final Topic Tries;

  const Progress ({
    //required this.topics,

    required this.AlgorithmAnalysis,
    required this.AVLTrees,
    required this.Backtracking,
    required this.BaseConversion,
    required this.BinaryTrees,
    required this.BitwiseOperators,
    required this.DynamicMemory,
    required this.HashTables,
    required this.Heaps,
    required this.LinkedLists,
    required this.Queues,
    required this.RecurrenceRelations,
    required this.Recursion,
    required this.Sorting,
    required this.Stacks,
    required this.Summations,
    required this.Tries,
  });

  factory Progress.fromJson(Map<String, dynamic> json) {
    json = json['progress'];
    return Progress(
      //topics[0]: Topic.fromJson('Algorithm Analysis', json['Algorithm Analysis']),
      AlgorithmAnalysis: !(json['Algorithm Analysis'] == null) ?
        Topic.fromJson('Algorithm Analysis', json['Algorithm Analysis']) :
        Topic(correct: 0, total: 0, percentage: 0, name: 'Algorithm Analysis'),
      AVLTrees: !(json['AVL Trees'] == null) ?
        Topic.fromJson('AVL Trees', json['AVL Trees']):
        Topic(correct: 0, total: 0, percentage: 0, name: 'AVL Trees'),
      Backtracking: !(json['Backtracking'] == null) ?
        Topic.fromJson('Backtracking', json['Backtracking']):
        Topic(correct: 0, total: 0, percentage: 0, name: 'Backtracking'),
      BaseConversion: !(json['Base Conversion'] == null) ?
        Topic.fromJson('Base Conversion', json['Base Conversion']):
        Topic(correct: 0, total: 0, percentage: 0, name: 'Base Conversion'),
      BinaryTrees: !(json['Binary Trees'] == null) ?
        Topic.fromJson('Binary Trees', json['Binary Trees']):
        Topic(correct: 0, total: 0, percentage: 0, name: 'Binary Trees'),
      BitwiseOperators: !(json['Bitwise Operators'] == null) ?
        Topic.fromJson('Bitwise Operators', json['Bitwise Operators']):
        Topic(correct: 0, total: 0, percentage: 0, name: 'Bitwise Operators'),
      DynamicMemory: !(json['Dynamic Memory'] == null) ?
        Topic.fromJson('Dynamic Memory', json['Dynamic Memory']):
        Topic(correct: 0, total: 0, percentage: 0, name: 'Dynamic Memory'),
      HashTables: !(json['Hash Tables'] == null) ?
        Topic.fromJson('Hash Tables', json['Hash Tables']):
        Topic(correct: 0, total: 0, percentage: 0, name: 'Hash Tables'),
      Heaps: !(json['Heaps'] == null) ?
        Topic.fromJson('Heaps', json['Heaps']):
        Topic(correct: 0, total: 0, percentage: 0, name: 'Heaps'),
      LinkedLists: !(json['Linked Lists'] == null) ?
        Topic.fromJson('Linked Lists', json['Linked Lists']):
        Topic(correct: 0, total: 0, percentage: 0, name: 'Linked Lists'),
      Queues: !(json['Queues'] == null) ?
        Topic.fromJson('Queues', json['Queues']):
        Topic(correct: 0, total: 0, percentage: 0, name: 'Queues'),
      RecurrenceRelations: !(json['Recurrence Relations'] == null) ?
        Topic.fromJson('Recurrence Relations', json['Recurrence Relations']):
        Topic(correct: 0, total: 0, percentage: 0, name: 'Recurrence Relations'),
      Recursion: !(json['Recursion'] == null) ?
        Topic.fromJson('Recursion', json['Recursion']):
        Topic(correct: 0, total: 0, percentage: 0, name: 'Recursion'),
      Sorting: !(json['Sorting'] == null) ?
        Topic.fromJson('Sorting', json['Sorting']):
        Topic(correct: 0, total: 0, percentage: 0, name: 'Sorting'),
      Stacks: !(json['Stacks'] == null) ?
        Topic.fromJson('Stacks', json['Stacks']):
        Topic(correct: 0, total: 0, percentage: 0, name: 'Stacks'),
      Summations: !(json['Summations'] == null) ?
        Topic.fromJson('Summations', json['Summations']):
        Topic(correct: 0, total: 0, percentage: 0, name: 'Summations'),
      Tries: !(json['Tries'] == null) ?
        Topic.fromJson('Tries', json['Tries']):
        Topic(correct: 0, total: 0, percentage: 0, name: 'Tries'),
    );
  }
}
