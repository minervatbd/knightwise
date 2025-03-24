import 'package:flutter/material.dart';
import 'package:mobile_test/icons.dart';
import 'package:mobile_test/models.dart';
import '../styles.dart';

const scheme = Styles.schemeMain;

// this class will compose a list that stores info abt each question's status
class QuestionBodyStatus {
  QuestionBodyStatus(
    this.isSubmitted,
  );

  bool isSubmitted = false;
}

class QuestionBody extends StatefulWidget {
  const QuestionBody({
    super.key,
    required this.problem,
    required this.status,
    this.currentPageIndex = 0,
    required this.changeIndex,
    required this.changeStatus,
  });

  final Problem problem;
  final QuestionBodyStatus status;
  final int currentPageIndex;
  final ValueChanged<int> changeIndex;
  final ValueChanged<QuestionBodyStatus> changeStatus;

  @override
  State<QuestionBody> createState() => _QuestionBodyState();
}

class _QuestionBodyState extends State<QuestionBody> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: <Widget>[
          Text(widget.problem.question, style: Styles.buttonTextStyle),
          ElevatedButton(
            style: Styles.yellowButtonStyle,
            onPressed: () {
              widget.changeStatus(QuestionBodyStatus(true));
            },
            child: Text("press to answer")
          ),
        ]
      ),
    );
  }
}

