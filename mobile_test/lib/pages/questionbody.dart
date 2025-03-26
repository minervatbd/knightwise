import 'package:flutter/material.dart';
import 'package:mobile_test/models.dart';
import '../styles.dart';

const scheme = Styles.schemeMain;

// this class will compose a list that stores info abt each question's status
class QuestionBodyStatus {
  QuestionBodyStatus(
    this.answerOrder,
    this.isSubmitted,
    this.selectedIndex,
  );

  QuestionBodyStatus.empty() {
    answerOrder = [0,1,2,3];
    answerOrder.shuffle();
    isSubmitted = false;
    selectedIndex = -1;
  }

  late List<int> answerOrder;
  late bool isSubmitted;
  late int selectedIndex;
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
    var correct = widget.problem.answerCorrect;
    var wrong = widget.problem.answersWrong;
    List<String> answerList = <String>[correct, wrong[0], wrong[1], wrong[2]];



    return Center(
      child: ListView(
        children: <Widget>[
          Text(widget.problem.question, style: Styles.buttonTextStyle),
          ElevatedButton(
            style: Styles.yellowButtonStyle,
            onPressed: () {
              widget.changeStatus(widget.status);
            },
            child: Text(answerList[widget.status.answerOrder[0]])
          ),
          ElevatedButton(
            style: Styles.yellowButtonStyle,
            onPressed: () {
              widget.changeStatus(widget.status);
            },
            child: Text(answerList[widget.status.answerOrder[1]])
          ),
          ElevatedButton(
            style: Styles.yellowButtonStyle,
            onPressed: () {
              widget.changeStatus(widget.status);
            },
            child: Text(answerList[widget.status.answerOrder[2]])
          ),
          ElevatedButton(
            style: Styles.yellowButtonStyle,
            onPressed: () {
              widget.changeStatus(widget.status);
            },
            child: Text(answerList[widget.status.answerOrder[3]])
          ),
          
        ]
      ),
    );
  }
}

