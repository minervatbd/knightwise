import 'package:flutter/material.dart';
import 'package:mobile_test/calls.dart';
import 'package:mobile_test/pages/questions/questionbody.dart';
import 'package:sprintf/sprintf.dart';
import 'package:mobile_test/models.dart';
import 'package:mobile_test/pages/questions/questionsequence.dart';
import '../../styles.dart';

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
      0,
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

class MockTestPage extends StatefulWidget {
  const MockTestPage({super.key});

  @override
  State<MockTestPage> createState() => _MockTestPageState();
}

class _MockTestPageState extends State<MockTestPage> {

  void handleStartButton() async {
    var problemList = await fetchMockTest();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuestionSequence(problemCount: problemList.length, problemList: problemList, statusList: generateStatusList(problemList.length))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: <Widget>[
          
          //Container for heading
          Container(
            width: 412,
            height: 152,
            decoration: BoxDecoration(
                color: Colors.grey.shade400,
                boxShadow: [BoxShadow(
                  offset: Offset(0, 5),
                  blurRadius: 5,
                  spreadRadius: 5,
                  color: Colors.grey.shade400,
                )],
            ),
            padding: EdgeInsets.symmetric(vertical: 50.0),

            child: Column( spacing: 15.0, children: <Widget>[
              // Header Text
              RichText(
              textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Mock Test',
                  style: Styles.timeTextStyle,
                ),
              ),
              ],),
          ),
          
          // Test information text box
          Container(
            padding: EdgeInsets.fromLTRB(10, 150, 10, 0),
            child: Text(
              'This test is divided into a total of four sections with each section consistenting of three questions.',
              textAlign: TextAlign.center,
              style: Styles.generalTextStyle,
            ),
          ),

          // Add space before the button
          SizedBox(height: 100),
        
          // Start Button
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: handleStartButton,
              style: Styles.yellowButtonStyle,
              child: Text(
                "Start",
                style: Styles.buttonTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
