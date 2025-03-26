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
    var correct = widget.problem.answerCorrect;
    var wrong = widget.problem.answersWrong;

    bool _submitEnabled = (widget.status.selectedIndex != -1 && !widget.status.isSubmitted);

    List<String> answerList = <String>[correct, wrong[0], wrong[1], wrong[2]];

    List<bool> selectedList= [false, false, false, false];
    if (widget.status.selectedIndex != -1)
    {
      selectedList[widget.status.selectedIndex] = true;
    }

    void handleSubmitButton () {
      setState(() {
        if (widget.status.answerOrder[widget.status.selectedIndex] == 0) print("correct");
        else print("wrong");

        widget.status.answer = Answer(
          "id",
          "user_id",
          widget.problem.id,
          DateTime.now(),
          (widget.status.selectedIndex == 0),
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
            fillColor: scheme.secondary,
            onPressed: (int index) {
              setState(() {
              // todo: dont update anything if the answer has been submitted already
                _submitEnabled = true;
                widget.status.selectedIndex = index;
                widget.changeStatus(widget.status);
                for (int i = 0; i < selectedList.length; i++) {
                  selectedList[i] = i == index;
                }
              });
            },
            isSelected: selectedList,
            children: <Widget>[
              Row(children: [
                  selectedList[0] ? selectedIcon : unselectedIcon,
                  Text(answerList[widget.status.answerOrder[0]]),
                ],
              ),
              Row(children: [
                  selectedList[1] ? selectedIcon : unselectedIcon,
                  Text(answerList[widget.status.answerOrder[1]]),
                ],
              ),
              Row(children: [
                  selectedList[2] ? selectedIcon : unselectedIcon,
                  Text(answerList[widget.status.answerOrder[2]]),
                ],
              ),
              Row(children: [
                  selectedList[3] ? selectedIcon : unselectedIcon,
                  Text(answerList[widget.status.answerOrder[3]]),
                ],
              ),
            ],
          ),
          ElevatedButton(
            style: Styles.yellowButtonStyle,
            onPressed: _submitEnabled? handleSubmitButton : null,
            child: Text("Submit")
          ),
        ]
      ),
    );
  }
}

