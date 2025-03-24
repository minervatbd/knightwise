import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';
import 'package:mobile_test/models.dart';
import '../styles.dart';

// this class will compose a list that stores info abt each question's status
class QuestionPageStatus {
  QuestionPageStatus(
    this.isSubmitted,
  );

  bool isSubmitted = false;
}

// generates a list of dummy problems for test purposes
List<Problem> generateDummyProblems(int count) {
  List<Problem> problemsOut = new List<Problem>.empty(growable: true);

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

// returns a list filled with default statuses
List<QuestionPageStatus> generateStatusList(int count) {
  return List<QuestionPageStatus>.filled(
    count,
    QuestionPageStatus(false)
  );
}

class QuestionSequence extends StatefulWidget {
  const QuestionSequence({
    super.key,
    required this.problemCount,
    required this.problemList,
    required this.statusList,
    this.currentPageIndex = 0,
  });

  final int problemCount;
  final List<Problem> problemList;
  final List<QuestionPageStatus> statusList;
  final int currentPageIndex;

  @override
  State<QuestionSequence> createState() => _QuestionSequenceState();
}

class _QuestionSequenceState extends State<QuestionSequence> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: null,
      bottomNavigationBar: null,
    );
  }
}