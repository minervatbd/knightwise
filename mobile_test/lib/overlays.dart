import 'package:flutter/material.dart';
import 'styles.dart';

const scheme = Styles.schemeMain;

abstract class AppBars {
  // top bar containing a ucf logo and a button opening the dropdown menu
  static final topBar = AppBar(
    backgroundColor: Styles.schemeMain.primary,
    leading: Container(
        padding:EdgeInsets.all(8),
        child: Image.asset('assets/ucflogo.png'),
      ),
    // sample text, change later
    title: Text("Top banner"),
    actions: <Widget>[
      Container(
        padding: EdgeInsets.all(8),
        child: Ink(
          decoration: ShapeDecoration(
            color: scheme.secondary,
            shape: CircleBorder(),
          ),
          child: IconButton(
            color: scheme.primary,
            icon: const Icon(Icons.menu),
            tooltip: 'Show menu',
            onPressed: () {
              print("show menu");
            }
          )
        )
      )
    ]
  );
  // bottom bar containing four buttons
  static final bottomBar = BottomAppBar(
    color: Styles.schemeMain.primary,
    child: IconTheme(
      data: IconThemeData(color: Styles.schemeMain.primary),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            child: Ink(
              decoration: ShapeDecoration(
                color: scheme.secondary,
                shape: CircleBorder(),
              ),
              // dashboard button
              child: IconButton(
                color: scheme.primary,
                icon: const Icon(Icons.grid_view),
                tooltip: 'Button1',
                onPressed: () {
                  print("Button1");
                }
              )
            )
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: Ink(
              decoration: ShapeDecoration(
                color: scheme.secondary,
                shape: CircleBorder(),
              ),
              // topic selection button
              child: IconButton(
                color: scheme.primary,
                icon: const Icon(Icons.chat_bubble_outline),
                tooltip: 'Button2',
                onPressed: () {
                  print("Button2");
                }
              )
            )
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: Ink(
              decoration: ShapeDecoration(
                color: scheme.secondary,
                shape: CircleBorder(),
              ),
              // mock test button
              child: IconButton(
                color: scheme.primary,
                icon: const Icon(Icons.description_outlined),
                tooltip: 'Button3',
                onPressed: () {
                  print("Button3");
                }
              )
            )
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: Ink(
              decoration: ShapeDecoration(
                color: scheme.secondary,
                shape: CircleBorder(),
              ),
              // my progress button
              child: IconButton(
                color: scheme.primary,
                icon: const Icon(Icons.bar_chart),
                tooltip: 'Button4',
                onPressed: () {
                  print("Button4");
                }
              )
            )
          ),
        ],
      )
    )
  );
}