import 'package:flutter/material.dart';
import 'package:mobile_test/models.dart';
import 'package:mobile_test/overlays.dart';
import 'package:mobile_test/pages/questionbody.dart';

class QuestionSequence extends StatefulWidget {
  const QuestionSequence({
    super.key,
    required this.problemCount,
    required this.problemList,
    required this.statusList,
    
  });

  final int problemCount;
  final List<Problem> problemList;
  final List<QuestionBodyStatus> statusList;

  @override
  State<QuestionSequence> createState() => _QuestionSequenceState();
}

class _QuestionSequenceState extends State<QuestionSequence> {
  int currentPageIndex = 0;

  void refreshIndex(int newIndex) {
    setState(() {
      currentPageIndex = newIndex;
    });
  }

  void refreshStatus(QuestionBodyStatus newStatus) {
    setState(() {
      widget.statusList[currentPageIndex] = newStatus;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    // build list of questionbodies first
    List<QuestionBody> questions = List<QuestionBody>.empty(growable: true);

    for (int x = 0; x < widget.problemCount; x++) {
      questions.add(
        QuestionBody(
          problem: widget.problemList[x],
          status: widget.statusList[x],
          changeIndex: refreshIndex,
          changeStatus: refreshStatus,
        )
      );
    }

    return Scaffold(
      appBar: TopBarBlank(),
      body: questions[currentPageIndex],
      bottomNavigationBar: QuestionBarMenu(problemCount: widget.problemCount, changeIndex: refreshIndex),
    );
  }
}