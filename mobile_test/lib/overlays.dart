import 'package:flutter/material.dart';
import 'styles.dart';
import 'icons.dart';

const scheme = Styles.schemeMain;
const double topBarHeight = 70;

// top bar containing a ucf logo and a button opening the dropdown menu
class TopBarMenu extends StatelessWidget implements PreferredSizeWidget {
  const TopBarMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
            icon: NavigationIcons.menu,
            tooltip: 'Show menu',
            onPressed: () {
              var state = Scaffold.of(context);
              if (state.isDrawerOpen) {
                state.closeDrawer();
              } else {
                state.openDrawer();
              }
            }
          )
        )
      )
    ]
        );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(topBarHeight);
}

// bottom bar containing four buttons
class BottomBarMenu extends StatefulWidget {
  const BottomBarMenu({
    super.key,
    this.currentPageIndex = 0,
    required this.changeIndex
  });

  final int currentPageIndex;
  final ValueChanged<int> changeIndex;

  @override
  State<BottomBarMenu> createState() => _BottomBarMenuState();
}

class _BottomBarMenuState extends State<BottomBarMenu> {
  NavigationDestinationLabelBehavior labelBehavior = NavigationDestinationLabelBehavior.alwaysHide;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: Styles.schemeMain.primary,
      labelBehavior: labelBehavior,
      selectedIndex: widget.currentPageIndex,
      onDestinationSelected: (int index) {
        setState(() {
          widget.changeIndex(index);
        });
      },
      destinations: [
        NavigationDestination(
          icon: NavigationIcons.dashboard,
          selectedIcon: NavigationIcons.dashboardSelected,
          label: "Dashboard" 
        ),
        NavigationDestination(
          icon: NavigationIcons.topicSelection,
          selectedIcon: NavigationIcons.topicSelectionSelected,
          label: "Topic Selection" 
        ),
        NavigationDestination(
          icon: NavigationIcons.mockTest,
          selectedIcon: NavigationIcons.mockTestSelected,
          label: "Mock Test" 
        ),
        NavigationDestination(
          icon: NavigationIcons.myProgress,
          selectedIcon: NavigationIcons.myProgressSelected,
          label: "My Progress" 
        ),
      ],
    );
  }
}

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

class QuestionBarMenu extends StatefulWidget {
  const QuestionBarMenu({
    super.key,
    required this.problemCount,
    this.currentPageIndex = 0,
    required this.changeIndex,
  });

  final int problemCount;
  final int currentPageIndex;
  final ValueChanged<int> changeIndex;

  @override
  State<QuestionBarMenu> createState() => _QuestionBarMenuState();
}

class _QuestionBarMenuState extends State<QuestionBarMenu> {
  bool _previousEnabled = false;
  bool _nextEnabled = true;

  int index = 0;

  void switchButtons () {
    if (index == widget.problemCount - 1) {
      _nextEnabled = false;
    } else {
      _nextEnabled = true;
    }
    if (index == 0) {
      _previousEnabled = false;
    } else {
      _previousEnabled = true;
    }
  }

  void handlePreviousButton () {
    index--;

    setState(() {
      switchButtons();
      widget.changeIndex(index);
    });
  }

  void handleNextButton () {
    index++;

    setState(() {
      switchButtons();
      widget.changeIndex(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: scheme.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // previous
          ElevatedButton(
            style: Styles.yellowButtonStyle,
            onPressed: _previousEnabled ? handlePreviousButton : null,
            child: NavigationIcons.previous
          ),
          // next
          ElevatedButton(
            style: Styles.yellowButtonStyle,
            onPressed: _nextEnabled ? handleNextButton : null,
            child: NavigationIcons.next
          ),
        ],
      )
    );
  }
}