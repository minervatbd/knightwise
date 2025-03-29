import 'package:flutter/material.dart';
import 'package:mobile_test/icons.dart';
import 'package:mobile_test/models.dart';
import 'package:mobile_test/pages/questions/questionbody.dart';
import 'package:mobile_test/pages/questions/questionresults.dart';
import 'package:mobile_test/styles.dart';

const topBarHeight = 50.0;

class QuestionBarMenu extends StatefulWidget {
  const QuestionBarMenu({
    super.key,
    required this.problemCount,
    this.currentPageIndex = 0,
    required this.changeIndex,
    required this.status,
    required this.changeStatus,
    required this.problem,
    this.answerCount = 0,
    required this.changeAnswerCount,
    this.correctCount = 0,
    required this.changeCorrectCount,
  });

  final int problemCount;
  final int currentPageIndex;
  final ValueChanged<int> changeIndex;
  final QuestionBodyStatus status;
  final ValueChanged<QuestionBodyStatus> changeStatus;
  final Problem problem;
  final int answerCount;
  final ValueChanged<int> changeAnswerCount;
  final int correctCount;
  final ValueChanged<int> changeCorrectCount;

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
    bool isFinished = (widget.problemCount == widget.answerCount);

    bool correctness() {
      if (widget.status.selectedIndex != -1) {
        return widget.status.answerOrder[widget.status.selectedIndex] == 0;
      } else {
        return false;
      }
    }

    void handleSubmitButton () {
      setState(() {
        widget.changeAnswerCount(widget.answerCount + 1);

        if (correctness()) {
          widget.changeCorrectCount(widget.correctCount + 1);
        }

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

    void handleFinishButton() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => QuestionResultsPage(numberCorrect: widget.correctCount, numberTotal: widget.problemCount))
      );
    }

    Widget submitButton = ElevatedButton(
      style: Styles.yellowButtonStyle,
      onPressed: _submitEnabled ? handleSubmitButton : null,
      child: Text("Submit")
    );

    Widget finishButton = ElevatedButton(
      style: Styles.yellowButtonStyle,
      onPressed: handleFinishButton,
      child: Text("Finish")
    );

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
          isFinished ? finishButton : submitButton,
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

class QuestionBarTop extends StatefulWidget implements PreferredSizeWidget {
  const QuestionBarTop({
    super.key,
    required this.problemCount,
    this.currentPageIndex = 0,
    required this.changeIndex,
  });

  final int problemCount;
  final int currentPageIndex;
  final ValueChanged<int> changeIndex;

  @override
  State<QuestionBarTop> createState() => _QuestionBarTopState();
  
  @override
  Size get preferredSize => Size.fromHeight(topBarHeight);
}

class _QuestionBarTopState extends State<QuestionBarTop> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: scheme.primary,
      title: Text("Question ${widget.currentPageIndex + 1}/${widget.problemCount}"),
    );
  }
}