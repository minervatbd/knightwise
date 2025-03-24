import 'package:flutter/material.dart';
import 'package:mobile_test/icons.dart';
import 'package:mobile_test/models.dart';

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
          Text(widget.problem.question),
          ElevatedButton(
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

class QuestionBarMenu extends StatefulWidget {
  const QuestionBarMenu({
    super.key,
    required this.problemCount,
    this.currentPageIndex = 0,
    required this.changeIndex,
  });

  final int problemCount;
  final int currentPageIndex;
  final ValueChanged<int> changeIndex;

  @override
  State<QuestionBarMenu> createState() => _QuestionBarMenuState();
}

class _QuestionBarMenuState extends State<QuestionBarMenu> {
  bool previousEnabled = false;
  bool nextEnabled = true;
  bool submitEnabled = false;

  void switchButtons () {
    if (widget.currentPageIndex == 0) {
      previousEnabled = false;
    } else {
      previousEnabled = true;
    }
    if (widget.currentPageIndex == widget.problemCount - 1) {
      nextEnabled = false;
      submitEnabled = true;
    } else {
      nextEnabled = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        children: [
          // previous
          IconButton.filled(
            onPressed: previousEnabled?() {
              setState(() {
                widget.changeIndex(widget.currentPageIndex - 1);
              });
              switchButtons();
            }: null,
            icon: NavigationIcons.previous
          ),
          // submit quiz
          ElevatedButton(
            onPressed: submitEnabled?() {
              Navigator.pop(context);
            }: null,
            child: Text("Submit")
          ),
          // next
          IconButton.filled(
            onPressed: nextEnabled?() {
              setState(() {
                widget.changeIndex(widget.currentPageIndex + 1);
              });
              switchButtons();
            }: null,
            icon: NavigationIcons.next
          ),
        ],
      )
    );
  }
}