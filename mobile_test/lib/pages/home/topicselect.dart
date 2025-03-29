import 'package:flutter/material.dart';
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

// topics with icon
const List<Map<String, dynamic>> topics = [
  {"title": "Algorithm Analysis", "icon": Icons.all_inclusive},
  {"title": "AVL Trees", "icon": Icons.device_hub},
  {"title": "Backtracking", "icon": Icons.chevron_left},
  {"title": "Base Conversion", "icon": Icons.code},
  {"title": "Binary Trees", "icon": Icons.device_hub},
  {"title": "Bitwise Operators", "icon": Icons.code},
  {"title": "Dynamic Memory", "icon": Icons.memory},
  {"title": "Hash Tables", "icon": Icons.grid_on},
  {"title": "Heaps", "icon": Icons.device_hub},
  {"title": "Linked Lists", "icon": Icons.linear_scale},
  {"title": "Queues", "icon": Icons.chevron_right},
  {"title": "Recurrence Relations", "icon": Icons.repeat},
  {"title": "Recursion", "icon": Icons.loop},
  {"title": "Sorting", "icon": Icons.swap_vert},
  {"title": "Stacks", "icon": Icons.layers},
  {"title": "Summations", "icon": Icons.functions},
  {"title": "Tries", "icon": Icons.device_hub},
];

class TopicSelectPage extends StatefulWidget {
  const TopicSelectPage({super.key});

  @override
  State<TopicSelectPage> createState() => _TopicSelectPageState();
}

class _TopicSelectPageState extends State<TopicSelectPage> {

  String? _selectedTopic;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: <Widget>[
          Text(
            "Select Topic",
            style: Styles.timeTextStyle,
            textAlign: TextAlign.center,
          ),

          // topic list view
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: topics.length,
            itemBuilder: (context, index) {
              final topic = topics[index];
              final title = topic["title"];
              final icon = topic["icon"];
              final isSelected = _selectedTopic == title;

              // selected topic turns yellow
              return ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedTopic = title;
                    });
                  },
                  style: isSelected
                      ? Styles.yellowButtonStyle
                      : Styles.yellowButtonStyle.copyWith(
                    backgroundColor: WidgetStateProperty.all(Colors.white),
                  ),

                // button content
                // show ellipsis if text is too long
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(icon, size: 28),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          title,
                          style: Styles.generalTextStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
              );
            },
          ),

          const SizedBox(height: 20),

          // start button
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