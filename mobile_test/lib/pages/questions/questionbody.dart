import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:mobile_test/icons.dart';
import 'package:mobile_test/models.dart';
import '../../styles.dart';

const scheme = Styles.schemeMain;
const unselectedIcon = NavigationIcons.answer;
const selectedIcon = NavigationIcons.answerSelected;
const bodyPadding = 15.0;

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

    // if answer correct, tru, otherwise false
    bool correctness() {
      if (widget.status.selectedIndex != -1) {
        return widget.status.answerOrder[widget.status.selectedIndex] == 0;
      } else {
        return false;
      }
    }

    // default color/icon of selected answer before submission
    var answerColor = scheme.secondary;
    var answerIcon = selectedIcon;

    // just shortcuts for answerlist def
    var correctAnswer = widget.problem.answerCorrect;
    var wrongAnswers = widget.problem.answersWrong;

    // this will be indexed using status.answerorder
    List<String> answerList = <String>[correctAnswer, wrongAnswers[0], wrongAnswers[1], wrongAnswers[2]];

    // bool list of what answer is selected
    List<bool> selectedList= [false, false, false, false];
    if (widget.status.selectedIndex != -1) {
      selectedList[widget.status.selectedIndex] = true;
    }

    // the explanation element will be null unless the question has been answered
    var explanation = null;

    // change certain elements upon a correct answer
    if (correctness() && widget.status.isSubmitted) {
      answerColor = Styles.correctColor;
      answerIcon = NavigationIcons.correct;
      explanation = Row(
        children: [
          Text("Great job!", style: Styles.feedbackTextStyle),
        ],
      );
    // change them for incorrect answers
    } else if (!correctness() && widget.status.isSubmitted) {
      answerColor = scheme.error;
      answerIcon = NavigationIcons.wrong;
      explanation = Row(
        children: [
          Text("Correct answer: ${answerList[0]}", style: Styles.feedbackTextStyle),
        ],
      );
    }
    
    // generates 4 answer buttons
    var answerButtonList = List<Widget>.empty(growable: true);

    for (int i = 0; i < answerList.length; i++) {
      answerButtonList.add(
        Row(
          children: [
            selectedList[i] ? answerIcon : unselectedIcon,
            Flexible(
              child: Text(answerList[widget.status.answerOrder[i]])
            ),
          ],
        )
      );
    }

    // this is vestigial since we moved the submit button to the bottom bar
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
          Container(
            padding: EdgeInsets.all(bodyPadding),
            child: Text(
              "${widget.problem.category} > ${widget.problem.subcategory}",
              style: Styles.smallBoldTextStyle
            ),
          ),
          Container(
            padding: EdgeInsets.all(bodyPadding),
            child: TeXView(
              child: TeXViewColumn(
              children: [TeXViewDocument(
                widget.problem.question
              )]
              )
            ),
          ),
          Container(
            child: explanation,
            padding: EdgeInsets.all(bodyPadding),
          ),
          ToggleButtons(
            direction: Axis.vertical,
            color: scheme.primary,
            fillColor: answerColor,
            textStyle: Styles.answerTextStyle,
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
            children: answerButtonList,
          ),
        ]
      ),
    );
  }
}

