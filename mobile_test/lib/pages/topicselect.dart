import 'package:flutter/material.dart';
import 'package:mobile_test/pages/questionbody.dart';
import 'package:sprintf/sprintf.dart';
import 'package:mobile_test/models.dart';
import 'package:mobile_test/pages/questionsequence.dart';
import '../styles.dart';

const int testProblemCount = 10;

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
      sprintf("question%d", [count]),
      "answersCorrect",
      "answersWrong",
    ));
  }

  return problemsOut;
}

// returns a list filled with default statuses
List<QuestionBodyStatus> generateStatusList(int count) {
  return List<QuestionBodyStatus>.filled(
    count,
    QuestionBodyStatus(false)
  );
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