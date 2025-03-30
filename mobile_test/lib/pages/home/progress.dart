import 'package:flutter/material.dart';
import '../../styles.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {

  progressBar(String topic, double progress, double width){
    return Column(spacing: 3, children: [
      SizedBox(width: width, child: Text(topic, style: Styles.smallBoldTextStyle, textAlign: TextAlign.start,)),
      Stack(children: [
        SizedBox(height: 40, width: width, child: Material(
          elevation: 4,
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        )),
        SizedBox(height: 40, width: progress*(width/100), child: Material(
          elevation: 4,
          color: Styles.schemeMain.secondary,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        )),

      ]),
    ]);
  }


  @override
  Widget build(BuildContext context) {
    double scrnWidth = MediaQuery.of(context).size.width;
    double containerWidth = (scrnWidth- 65);
    bool messageReturned = false;
    bool graphReturned = true;
    bool problemHistoryReturned = false;


    return Center(
      child: ListView(
        children: <Widget>[
        //Container for heading timer section
          Container(
            width: scrnWidth,
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
            padding: EdgeInsets.symmetric(vertical: 35.0),
            child: Text('My Progress', style: Styles.headerTextStyle, textAlign: TextAlign.center,),
          ),
          SizedBox(height: 30,),
          if(messageReturned)
            Container(padding: EdgeInsets.all(20), child: Container(
              width: containerWidth,
              height: 200,
              decoration: BoxDecoration(
                color: Styles.schemeMain.secondary,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            )),
          if(graphReturned)
            Column(spacing: 30,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                progressBar('Algorithm Analysis', 40, containerWidth),
              ],
            ),
          if(problemHistoryReturned)
            Column(),
          //Bar
        ],
      ),
    );
  }
}
