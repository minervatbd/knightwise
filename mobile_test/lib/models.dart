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
}
