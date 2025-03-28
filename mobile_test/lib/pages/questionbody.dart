import 'package:flutter/material.dart';
import 'package:mobile_test/icons.dart';
import 'package:mobile_test/models.dart';
import '../styles.dart';

const scheme = Styles.schemeMain;
const unselectedIcon = NavigationIcons.answer;
const selectedIcon = NavigationIcons.answerSelected;

// this class will compose a list that stores info abt each question's status
class QuestionBodyStatus {
  QuestionBodyStatus(
    this.answerOrder,
    this.isSubmitted,
    this.selectedIndex,
    this.answer,
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
  late Answer answer;
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
    // bools for changing the current state of the page
    bool _submitEnabled = (widget.status.selectedIndex != -1 && !widget.status.isSubmitted);

    bool correctness() {
      if (widget.status.selectedIndex != -1) {
        return widget.status.answerOrder[widget.status.selectedIndex] == 0;
      } else {
        return false;
      }
    }

    var answerColor = scheme.secondary;
    var answerIcon = selectedIcon;
    if (correctness() && widget.status.isSubmitted) {
      answerColor = Styles.correctColor;
      answerIcon = NavigationIcons.correct;
    } else if (!correctness() && widget.status.isSubmitted) {
      answerColor = scheme.error;
      answerIcon = NavigationIcons.wrong;
    }

    var correctAnswer = widget.problem.answerCorrect;
    var wrongAnswers = widget.problem.answersWrong;

    List<String> answerList = <String>[correctAnswer, wrongAnswers[0], wrongAnswers[1], wrongAnswers[2]];

    List<bool> selectedList= [false, false, false, false];
    if (widget.status.selectedIndex != -1) {
      selectedList[widget.status.selectedIndex] = true;
    }

    var answerButtonList = List<Widget>.empty(growable: true);

    for (int i = 0; i < answerList.length; i++) {
      answerButtonList.add(
        Row(
          children: [
            selectedList[i] ? answerIcon : unselectedIcon,
            Text(answerList[widget.status.answerOrder[i]]),
          ],
        )
      );
    }
    

    void handleSubmitButton () {
      setState(() {
        if (correctness()) print("correct");
        else print("wrong");

        widget.status.answer = Answer(
          "id",
          "user_id",
          widget.problem.id,
          DateTime.now(),
          correctness(),
          widget.problem.category,
          widget.problem.subcategory,
        );

        widget.status.isSubmitted = true;

        widget.changeStatus(widget.status);
      });
    }

    return Center(
      child: ListView(
        children: <Widget>[
          Text(widget.problem.question, style: Styles.buttonTextStyle),
          ToggleButtons(
            direction: Axis.vertical,
            color: scheme.onSecondary,
            fillColor: answerColor,
            onPressed: (int index) {
              setState(() {
                if (!widget.status.isSubmitted) {
                  widget.status.selectedIndex = index;
                  widget.changeStatus(widget.status);
                  for (int i = 0; i < selectedList.length; i++) {
                    selectedList[i] = i == index;
                  }
                }
              });
            },
            isSelected: selectedList,
            children: <Widget>[
              Row(children: [
                  selectedList[0] ? answerIcon : unselectedIcon,
                  Text(answerList[widget.status.answerOrder[0]]),
                ],
              ),
              Row(children: [
                  selectedList[1] ? answerIcon : unselectedIcon,
                  Text(answerList[widget.status.answerOrder[1]]),
                ],
              ),
              Row(children: [
                  selectedList[2] ? answerIcon : unselectedIcon,
                  Text(answerList[widget.status.answerOrder[2]]),
                ],
              ),
              Row(children: [
                  selectedList[3] ? answerIcon : unselectedIcon,
                  Text(answerList[widget.status.answerOrder[3]]),
                ],
              ),
            ],
          ),
          // ElevatedButton(
          //   style: Styles.yellowButtonStyle,
          //   onPressed: _submitEnabled? handleSubmitButton : null,
          //   child: Text("Submit")
          // ),
        ]
      ),
    );
  }
}

