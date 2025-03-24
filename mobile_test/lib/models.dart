import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';


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
  final String answersWrong;

  // generates a list of dummy problems for test purposes
  List<Problem> generateDummyProblems(int count) {
    List<Problem> problemsOut = List<Problem>.empty(growable: true);

    int x = 0;
    while (x < count) {
      problemsOut.add(Problem(
        "id",
        "exam_id",
        "section",
        "category",
        "subcategory",
        sprintf("question%d", [count]),
        "answersCorrect",
        "answersWrong",
      ));
    }

    return problemsOut;
  }
}