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
  bool _previousEnabled = false;
  bool _nextEnabled = true;
  bool _submitEnabled = false;

  int index = 0;

  void switchButtons () {
    if (index == widget.problemCount - 1) {
      _nextEnabled = false;
      _submitEnabled = true;
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
          // submit quiz
          ElevatedButton(
            style: Styles.yellowButtonStyle,
            onPressed: _submitEnabled?() {
              Navigator.pop(context);
            }: null,
            child: Text("End")
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