import 'package:flutter/material.dart';
import 'package:mobile_test/calls.dart';
import 'package:mobile_test/models.dart';
import '../../styles.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  CurrentUser curUser = CurrentUser();

  List<Map<String, dynamic>> topics = [];

  // for message
  Map<String, dynamic> masteryMap = {};
  int streak = 0;
  bool messageReturned = false;
  int todayCount = 0;

  updateProgress() async {
    Progress uProg = await getProgress(curUser.token);

    //print(uProg.AlgorithmAnalysis.percentage);
    //print(uProg.AlgorithmAnalysis.name);

    /*List<Map<String, dynamic>>*/
    topics = [
      {
        'topic': uProg.AlgorithmAnalysis.name,
        'progress': uProg.AlgorithmAnalysis.percentage,
      },
      {'topic': 'AVL Trees', 'progress': uProg.AVLTrees.percentage},
      {'topic': 'Backtracking', 'progress': uProg.Backtracking.percentage},
      {'topic': 'Base Conversion', 'progress': uProg.BaseConversion.percentage},
      {'topic': 'Binary Tress', 'progress': uProg.BinaryTrees.percentage},
      {
        'topic': 'Bitwise Operators',
        'progress': uProg.BitwiseOperators.percentage,
      },
      {'topic': 'Dynamic Memory', 'progress': uProg.DynamicMemory.percentage},
      {'topic': 'Hash Tables', 'progress': uProg.HashTables.percentage},
      {'topic': 'Heaps', 'progress': uProg.Heaps.percentage},
      {'topic': 'Linked Lists', 'progress': uProg.LinkedLists.percentage},
      {'topic': 'Queues', 'progress': uProg.Queues.percentage},
      {
        'topic': 'Recurrence Relations',
        'progress': uProg.RecurrenceRelations.percentage,
      },
      {'topic': 'Recursion', 'progress': uProg.Recursion.percentage},
      {'topic': 'Sorting', 'progress': uProg.Sorting.percentage},
      {'topic': 'Stacks', 'progress': uProg.Stacks.percentage},
      {'topic': 'Summations', 'progress': uProg.Summations.percentage},
      {'topic': 'Tries', 'progress': uProg.Tries.percentage},
    ];
    setState(() {});
  }

  @override
  void initState() {
    updateProgress();
    updateMessageData();
    updateTodayCount();
    super.initState();
  }

  // get message
  updateMessageData() async {
    try {
      var data = await getMessageData(curUser.token);
      setState(() {
        streak = data['streak'];
        masteryMap = Map<String, dynamic>.from(data['mastery']);
        messageReturned = true;
      });
    } catch (e) {
      print("Error loading message data: $e");
    }
  }

  // get lowest percentage topic
  String _lowestMasteryTopic() {
    var sorted =
        masteryMap.entries.toList()..sort((a, b) => a.value.compareTo(b.value));
    return sorted.first.key;
  }

  // get today problem 
  updateTodayCount() async {
    try {
      todayCount = await getHistory(curUser.token);
      setState(() {});
    } catch (e) {
      print("Error counting today's answers: $e");
    }
  }

  Widget progressBar(String topic, double progress, double width) {
    return Column(
      children: [
        SizedBox(
          width: width,
          child: Text(
            topic,
            style: Styles.smallBoldTextStyle,
            textAlign: TextAlign.start,
          ),
        ),

        SizedBox(height: 3),
        Stack(
          children: [
            // Background Bar
            SizedBox(
              height: 40,
              width: width,
              child: Material(
                elevation: 4,
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Container(),
              ),
            ),
            // Foreground Bar with Percentage
            SizedBox(
              height: 40,
              width: progress * (width / 100),
              child: Material(
                elevation: 4,
                color: Styles.schemeMain.secondary,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Center(
                  child: Text(
                    '${progress.toStringAsFixed(0)}%',
                    style: Styles.smallBoldTextStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // can change so that update progress is *constantly* updating,
    // but decided better to have in init state

    /*
    updateProgress() async {
      Progress uProg = await getProgress(curUser.token);

      print(uProg.AlgorithmAnalysis.percentage);
      print(uProg.AlgorithmAnalysis.name);

      /*List<Map<String, dynamic>>*/ topics = [
        {
          'topic': uProg.AlgorithmAnalysis.name,
          'progress': uProg.AlgorithmAnalysis.percentage,
        },
        {'topic': 'AVL Trees', 'progress': uProg.AVLTrees.percentage},
        {'topic': 'Backtracking', 'progress': uProg.Backtracking.percentage},
        {'topic': 'Base Conversion', 'progress': uProg.BaseConversion.percentage},
        {'topic': 'Binary Tress', 'progress': uProg.BinaryTrees.percentage},
        {'topic': 'Bitwise Operators', 'progress': uProg.BitwiseOperators.percentage},
        {'topic': 'Dynamic Memory', 'progress': uProg.DynamicMemory.percentage},
        {'topic': 'Hash Tables', 'progress': uProg.HashTables.percentage},
        {'topic': 'Heaps', 'progress': uProg.Heaps.percentage},
        {'topic': 'Linked Lists', 'progress': uProg.LinkedLists.percentage},
        {'topic': 'Queues', 'progress': uProg.Queues.percentage},
        {'topic': 'Recurrence Relations', 'progress': uProg.RecurrenceRelations.percentage},
        {'topic': 'Recursion', 'progress': uProg.Recursion.percentage},
        {'topic': 'Sorting', 'progress': uProg.Sorting.percentage},
        {'topic': 'Stacks', 'progress': uProg.Stacks.percentage},
        {'topic': 'Summations', 'progress': uProg.Summations.percentage},
        {'topic': 'Tries', 'progress': uProg.Tries.percentage},
      ];
      setState(() {});
      /*
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:
            topics
                .map(
                  (topic) =>
                      progressBar(topic['topic'], topic['progress'], width),
                )
                .toList(),
      ),
    );

     */
    }

     */
    //updateProgress();

    double scrnWidth = MediaQuery.of(context).size.width;
    double containerWidth = (scrnWidth - 65);
    bool graphReturned = true;
    // bool problemHistoryReturned = false;

    return Center(
      child: ListView(
        children: <Widget>[
          Container(
            width: scrnWidth,
            height: 152,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 5),
                  blurRadius: 5,
                  spreadRadius: 5,
                  color: Colors.grey.withOpacity(0.5),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(vertical: 35.0),
            child: Text(
              'My Progress',
              style: Styles.headerTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),

          // message
          if (messageReturned)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: containerWidth,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Styles.schemeMain.secondary,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Great work! You solved $todayCount problems today! 🎉 A little extra practice on ${_lowestMasteryTopic()} will help solidify your skills. You're on a $streak-day streak! 🔥",
                        style: Styles.messageTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),

          SizedBox(height: 10),

          // graph
          if (graphReturned)
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:
                    topics
                        .map(
                          (topic) => progressBar(
                            topic['topic'],
                            topic['progress'],
                            containerWidth,
                          ),
                        )
                        .toList(),
              ),
            ),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}
