import 'package:flutter/material.dart';
import 'package:mobile_test/models.dart';
import 'package:mobile_test/overlays.dart';
import 'package:mobile_test/pages/questions/questionbar.dart';
import 'package:mobile_test/pages/questions/questionbody.dart';
import 'package:mobile_test/pages/questions/questionresults.dart';

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
  int answerCount = 0;
  int correctCount = 0;

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

  void refreshAnswerCount(int newAnswerCount) {
    setState(() {
      answerCount = newAnswerCount;
    });
  }

  void refreshCorrectCount(int newCorrectCount) {
    setState(() {
      correctCount = newCorrectCount;
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
      body: questions[currentPageIndex],
      appBar: QuestionBarTop(
        currentPageIndex: currentPageIndex,
        problemCount: widget.problemCount,
        changeIndex: refreshIndex,
      ),
      bottomNavigationBar: QuestionBarMenu(
        problemCount: widget.problemCount,
        changeIndex: refreshIndex,
        status: widget.statusList[currentPageIndex],
        changeStatus: refreshStatus,
        problem: widget.problemList[currentPageIndex],
        answerCount: answerCount,
        changeAnswerCount: refreshAnswerCount,
        correctCount: correctCount,
        changeCorrectCount: refreshCorrectCount,
      ),
    );
  }
}