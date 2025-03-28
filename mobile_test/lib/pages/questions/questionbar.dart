import 'package:flutter/material.dart';
import 'package:mobile_test/icons.dart';
import 'package:mobile_test/models.dart';
import 'package:mobile_test/pages/questions/questionbody.dart';
import 'package:mobile_test/styles.dart';

class QuestionBarMenu extends StatefulWidget {
  const QuestionBarMenu({
    super.key,
    required this.problemCount,
    this.currentPageIndex = 0,
    required this.changeIndex,
    required this.status,
    required this.changeStatus,
    required this.problem
  });

  final int problemCount;
  final int currentPageIndex;
  final ValueChanged<int> changeIndex;
  final QuestionBodyStatus status;
  final ValueChanged<QuestionBodyStatus> changeStatus;
  final Problem problem;

  @override
  State<QuestionBarMenu> createState() => _QuestionBarMenuState();
}

class _QuestionBarMenuState extends State<QuestionBarMenu> {
  bool _previousEnabled = false;
  bool _nextEnabled = true;

  int index = 0;

  void switchButtons () {
    if (index == widget.problemCount - 1) {
      _nextEnabled = false;
    } else {
      _nextEnabled = true;
    }
    if (index == 0) {
      _previousEnabled = false;
    } else {
      _previousEnabled = true;
    }
  }

  void handlePreviousButton () {
    index--;

    setState(() {
      switchButtons();
      widget.changeIndex(index);
    });
  }

  void handleNextButton () {
    index++;

    setState(() {
      switchButtons();
      widget.changeIndex(index);
    });
  }

  @override
  Widget build(BuildContext context) {
  
    bool _submitEnabled = (widget.status.selectedIndex != -1 && !widget.status.isSubmitted);

    bool correctness() {
      if (widget.status.selectedIndex != -1) {
        return widget.status.answerOrder[widget.status.selectedIndex] == 0;
      } else {
        return false;
      }
    }
    void handleSubmitButton () {
      setState(() {
        if (correctness()) print("correct");
        else print("wrong");

        widget.status.answer = Answer.newAnswer(
          "user_id",
          widget.problem.id,
          correctness(),
          widget.problem.category,
          widget.problem.subcategory,
        );

        widget.status.isSubmitted = true;

        widget.changeStatus(widget.status);
      });
    }

    return BottomAppBar(
      color: scheme.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // previous
          ElevatedButton(
            style: Styles.yellowButtonStyle,
            onPressed: _previousEnabled ? handlePreviousButton : null,
            child: NavigationIcons.previous
          ),
          ElevatedButton(
            style: Styles.yellowButtonStyle,
            onPressed: _submitEnabled ? handleSubmitButton : null,
            child: Text("Submit")
          ),
          // next
          ElevatedButton(
            style: Styles.yellowButtonStyle,
            onPressed: _nextEnabled ? handleNextButton : null,
            child: NavigationIcons.next
          ),
        ],
      )
    );
  }
}