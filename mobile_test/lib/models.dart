class Problem {
  const Problem(
      this.id,
      this.exam_id,
      this.section,
      this.category,
      this.subcategory,
      this.question,
      this.answerCorrect,
      this.answersWrong,
    );
  
  final String id;
  final String exam_id;
  final String section;
  final String category;
  final String subcategory;
  final String question;
  final String answerCorrect;
  final List<String> answersWrong;

}

class Answer {
  const Answer(
    this.id,
    this.user_id,
    this.problem_id,
    this.datetime,
    this.isCorrect,
    this.category,
    this.topic,
  );

  final String id;
  final String user_id;
  final String problem_id;
  final DateTime datetime;
  final bool isCorrect;
  final String category;
  final String topic;
}