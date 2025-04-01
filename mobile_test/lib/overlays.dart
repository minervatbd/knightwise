import 'package:flutter/material.dart';
import 'styles.dart';
import 'icons.dart';

const scheme = Styles.schemeMain;
const double topBarHeight = 70;


// blank black top bar for login/register
class TopBarBlank extends StatelessWidget implements PreferredSizeWidget {
  const TopBarBlank({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Styles.schemeMain.primary,
      );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(topBarHeight);
}

// bottom bar with only ucf logo for login/register
class BottomBarBlank extends StatelessWidget {
  const BottomBarBlank({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Styles.schemeMain.primary,
      child: Container(
        padding:EdgeInsets.all(8),
        child: Image.asset('assets/horizontalucflogo.png'),
      ),
    );
  }
}

// moving this here for now
final oldIconTheme = IconTheme(
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
            icon: NavigationIcons.dashboard,
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
            icon: NavigationIcons.topicSelection,
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
            icon: NavigationIcons.mockTest,
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
            icon: NavigationIcons.myProgress,
            tooltip: 'Button4',
            onPressed: () {
              print("Button4");
            }
          )
        )
      ),
    ],
  )
);

