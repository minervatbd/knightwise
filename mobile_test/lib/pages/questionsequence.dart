import 'package:flutter/material.dart';
import 'package:mobile_test/models.dart';
import 'package:mobile_test/overlays.dart';
import 'package:mobile_test/pages/questionbody.dart';
import '../styles.dart';

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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBarBlank(),
      body: null,
      bottomNavigationBar: null,
    );
  }
}