import 'package:flutter/material.dart';
import 'package:mobile_test/pages/questions/questionbody.dart';
import 'package:sprintf/sprintf.dart';
import 'package:mobile_test/models.dart';
import 'package:mobile_test/pages/questions/questionsequence.dart';
import '../styles.dart';

const int testProblemCount = 6;

// generates a list of dummy problems for test purposes
List<Problem> generateDummyProblems(int count) {
  List<Problem> problemsOut = List<Problem>.empty(growable: true);

  int x = 0;
  while (x < count) {
    problemsOut.add(Problem(
      "id",
      "exam_id",
      "section",
      "category",
      "subcategory",
      sprintf("question%d", [x+1]),
      "Correct",
      ["wrong1", "wrong2", "wrong3"],
    ));
    x++;
  }

  return problemsOut;
}

// returns a list filled with default statuses
List<QuestionBodyStatus> generateStatusList(int count) {
  var statusOut = List<QuestionBodyStatus>.empty(growable: true);
  for (int c = 0; c < count; c++) {
    statusOut.add(QuestionBodyStatus.empty());
  }
  return statusOut;
}

class TopicSelectPage extends StatefulWidget {
  const TopicSelectPage({super.key});

  @override
  State<TopicSelectPage> createState() => _TopicSelectPageState();
}

class _TopicSelectPageState extends State<TopicSelectPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: <Widget>[
          Text(
            "select topic",
            style: Styles.buttonTextStyle,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuestionSequence(problemCount: testProblemCount, problemList: generateDummyProblems(testProblemCount), statusList: generateStatusList(testProblemCount))),
              );
            },
            style: Styles.yellowButtonStyle,
            child: Text(
              "Start",
              style: Styles.buttonTextStyle,
            )
          )
        ]
      )
    );
  }
}