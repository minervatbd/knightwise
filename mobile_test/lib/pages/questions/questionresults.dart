import 'package:flutter/material.dart';
import 'package:mobile_test/overlays.dart';
import 'package:mobile_test/styles.dart';

// styles for text, probably needs change
var headerTextStyle = Styles.buttonTextStyle;
var bodyTextStyle = Styles.generalTextStyle;
var finishButtonTextStyle = Styles.buttonTextStyle;

var finishButtonStyle = Styles.yellowButtonStyle;

class QuestionResultsPage extends StatefulWidget {
  const QuestionResultsPage({
    super.key,
    required this.numberCorrect,
    required this.numberTotal,
  });

  final int numberCorrect;
  final int numberTotal;

  @override
  State<QuestionResultsPage> createState() => _QuestionResultsPageState();
}

class _QuestionResultsPageState extends State<QuestionResultsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBarBlank(),
      body: Center(
        child: ListView(
          children: <Widget>[
            // header container
            Container(
              child: Text("Results", style: headerTextStyle)
            ),
            // results text container
            Container(
              child: Text("Great work! ${widget.numberCorrect} out of ${widget.numberTotal} correct.", style: bodyTextStyle)
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              style: finishButtonStyle,
              child: Text("Finish", style: finishButtonTextStyle),
            ),
          ]
        ),
      ),
    );
  }
}