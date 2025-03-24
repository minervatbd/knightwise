import 'package:flutter/material.dart';
import 'package:mobile_test/models.dart';

// this class will compose a list that stores info abt each question's status
class QuestionBodyStatus {
  QuestionBodyStatus(
    this.isSubmitted,
  );

  bool isSubmitted = false;
}

// returns a list filled with default statuses
List<QuestionBodyStatus> generateStatusList(int count) {
  return List<QuestionBodyStatus>.filled(
    count,
    QuestionBodyStatus(false)
  );
}

class QuestionBody extends StatefulWidget {
  const QuestionBody({
    super.key,
    required this.problem,
    required this.status,
  });

  final Problem problem;
  final QuestionBodyStatus status;

  @override
  State<QuestionBody> createState() => _QuestionBodyState();
}

class _QuestionBodyState extends State<QuestionBody> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: null,
    );
  }
}