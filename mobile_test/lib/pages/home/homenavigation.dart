import 'package:flutter/material.dart';
import 'package:mobile_test/icons.dart';
import 'package:mobile_test/styles.dart';

const scheme = Styles.schemeMain;
const double topBarHeight = 70;

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

class Destination {
  const Destination(
      this.label,
      this.icon,
      this.selectedIcon
    );
  
  final String label;
  final Widget icon;
  final Widget selectedIcon;
}

const List<Destination> destinations = <Destination>[
  Destination('Dashboard', NavigationIcons.dashboard, NavigationIcons.dashboardSelected),
  Destination('Topic Practice', NavigationIcons.topicSelection, NavigationIcons.topicSelectionSelected),
  Destination('Mock Test', NavigationIcons.mockTest, NavigationIcons.mockTestSelected),
  Destination('My Progress', NavigationIcons.myProgress, NavigationIcons.myProgressSelected),
];

class TopBarDrawer extends StatefulWidget {
  const TopBarDrawer({
    super.key,
    this.currentPageIndex = 0,
    required this.changeIndex,
  });

  final int currentPageIndex;
  final ValueChanged<int> changeIndex;

  @override
  State<TopBarDrawer> createState() => _TopBarDrawerState();
}

class _TopBarDrawerState extends State<TopBarDrawer> {
  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      backgroundColor: Colors.white,
      onDestinationSelected: (int index) {
        setState(() {
          widget.changeIndex(index);
        });
      },
      selectedIndex: widget.currentPageIndex,
      children: <Widget>[
        // dashboard
        DrawerHeader(
          decoration: BoxDecoration(color: scheme.secondary),
          child: Text('firstname lastname', style: TextStyle(color: scheme.primary, fontSize: 24)),
        ),
        ...destinations.map((Destination destination) {
          return NavigationDrawerDestination(
            label: Text(destination.label, style: TextStyle(color: scheme.primary)),
            icon: destination.selectedIcon,
            backgroundColor: scheme.surface,
            selectedIcon: destination.selectedIcon,
          );
        }),
        // log out
        ListTile(
          leading: NavigationIcons.logout,
          iconColor: scheme.primary,
          textColor: scheme.primary,
          title: const Text('Logout'),
          onTap: () {
            print("logout");
          }
        )
      ]
    );
  }
}
