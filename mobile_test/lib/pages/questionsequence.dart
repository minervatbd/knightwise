import 'package:flutter/material.dart';
import 'package:mobile_test/models.dart';
import 'package:mobile_test/overlays.dart';
import '../styles.dart';

// this class will compose a list that stores info abt each question's status
class QuestionPageStatus {
  QuestionPageStatus(
    this.isSubmitted,
  );

  bool isSubmitted = false;
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
    required this.changeIndex,
    required this.changeStatus,
  });

  final int problemCount;
  final List<Problem> problemList;
  final List<QuestionPageStatus> statusList;
  final int currentPageIndex;
  final ValueChanged<int> changeIndex;
  final ValueChanged<QuestionPageStatus> changeStatus;

  @override
  State<QuestionSequence> createState() => _QuestionSequenceState();
}

class _QuestionSequenceState extends State<QuestionSequence> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBarBlank(),
      body: null,
      bottomNavigationBar: null,
    );
  }
}