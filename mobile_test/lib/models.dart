class CurrentUser{
  static final CurrentUser _currentUser = CurrentUser._internal();

  late String token;
  late String firstName;
  late String lastName;
  late String id;

  factory CurrentUser(){
    return _currentUser;
  }

  CurrentUser._internal();

  // user logout
  void clear() {
    token = '';
    firstName = '';
    lastName = '';
    id = '';
  }
}

class ResetPassword{
  final String message;

  ResetPassword({
    required this.message,
  });

  factory ResetPassword.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "message": String message,
      } => ResetPassword(message: message),
      _ => throw const FormatException('Failed to load problem.'),
    };
  }
}

class SendOtp{
  final String message;

  SendOtp({
    required this.message,
  });

  factory SendOtp.fromJson(Map<String, dynamic> json) {
    return SendOtp(
      message: json['message'],
    );
  }
}

class Verify{
  final String message;

  Verify({
    required this.message,
  });

  factory Verify.fromJson(Map<String, dynamic> json) {
    return Verify(
      message: json['message'],
    );
  }
}

class User {
  final String id;
  final String name;
  final String email;

  //final String password;
  final String firstName;
  final String lastName;
  //final bool isVerified;

  User({
    required this.id,
    required this.name,
    required this.email,
    //required this.password,
    required this.firstName,
    required this.lastName,
    //this.isVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }
}

class Login {
  final String message;
  final String token;
  final User user;

  const Login({
    required this.message,
    required this.token,
    required this.user,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
        message: json['message'],
        token: json['token'],
        user: User.fromJson(json['user'])
    );
  }
}

class Problem {
  const Problem(
      this.id,
      this.exam_id,
      this.section,
      this.category,
      this.subcategory,
      this.points,
      this.question,
      this.answerCorrect,
      this.answersWrong,
    );
  
  final String id;
  final String exam_id;
  final String section;
  final String category;
  final String subcategory;
  final int points;
  final String question;
  final String answerCorrect;
  final List<dynamic> answersWrong;

  factory Problem.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "_id": String id,
        "exam_id": String exam_id,
        "section": String section,
        "category": String category,
        "subcategory": String subcategory,
        "points": int points,
        "question": String question,
        "answerCorrect": String answerCorrect,
        "answersWrong": List<dynamic> answersWrong,
      } => Problem(
        id,
        exam_id,
        section,
        category,
        subcategory,
        points,
        question,
        answerCorrect,
        answersWrong,
      ),
      _ => throw const FormatException('Failed to load problem.'),
    };
  }

}

class Answer {
  Answer(
    this.id,
    this.user_id,
    this.problem_id,
    this.datetime,
    this.isCorrect,
    this.category,
    this.topic,
  );

  // answer constructor for a new answer object to be submitted to database
  Answer.newAnswer(
    this.user_id,
    this.problem_id,
    this.isCorrect,
    this.category,
    this.topic
  ) {
    id = "";
    datetime = DateTime.now();
  }

  late String id;
  String user_id;
  String problem_id;
  late DateTime datetime;
  bool isCorrect;
  String category;
  String topic;

  factory Answer.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "_id": String id,
        "user_id": String user_id,
        "problem_id": String problem_id,
        "datetime": DateTime datetime,
        "isCorrect": bool isCorrect,
        "category": String category,
        "topic": String topic,
      } => Answer(
        id,
        user_id,
        problem_id,
        datetime,
        isCorrect,
        category,
        topic,
      ),
      _ => throw const FormatException('Failed to load Answer.'),
    };
  }

  static Map<String, dynamic> toJson(Answer answer) =>
    {
      "user_id": answer.user_id,
      "problem_id": answer.problem_id,
      "datetime": answer.datetime.toIso8601String(),
      "isCorrect": answer.isCorrect,
      "category": answer.category,
      "topic": answer.topic,
    };
}

class History{
  final String datetime;
  final String topic;

  const History({
    required this.datetime,
    required this.topic,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    return  History(
      datetime: json["datetime"],
      topic: json["topic"],
    );
  }
}

class Mastery{
  final Map<String, dynamic> topics;
  //could do the same thing as the progress model is worst comes to worst...

  const Mastery({
    required this.topics,
  });
  
  /*
  factory Master.fromJson(Map<String, dynamic> json){
    allTopics.map(topic) => {
      
    };
  }
  
   */
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
