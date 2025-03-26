import 'package:flutter/material.dart';
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
  // positions of the answers, the values index the answerlist
  List<int> answerOrder = [0,1,2,3];

  @override
  Widget build(BuildContext context) {
    var correct = widget.problem.answerCorrect;
    var wrong = widget.problem.answersWrong;
    List<String> answerList = <String>[correct, wrong[0], wrong[1], wrong[2]];

    answerOrder.shuffle();

    return Center(
      child: ListView(
        children: <Widget>[
          Text(widget.problem.question, style: Styles.buttonTextStyle),
          ElevatedButton(
            style: Styles.yellowButtonStyle,
            onPressed: () {
              widget.changeStatus(QuestionBodyStatus(true));
            },
            child: Text(answerList[answerOrder[0]])
          ),
          ElevatedButton(
            style: Styles.yellowButtonStyle,
            onPressed: () {
              widget.changeStatus(QuestionBodyStatus(true));
            },
            child: Text(answerList[answerOrder[1]])
          ),
          ElevatedButton(
            style: Styles.yellowButtonStyle,
            onPressed: () {
              widget.changeStatus(QuestionBodyStatus(true));
            },
            child: Text(answerList[answerOrder[2]])
          ),
          ElevatedButton(
            style: Styles.yellowButtonStyle,
            onPressed: () {
              widget.changeStatus(QuestionBodyStatus(true));
            },
            child: Text(answerList[answerOrder[3]])
          ),
        ]
      ),
    );
  }
}

