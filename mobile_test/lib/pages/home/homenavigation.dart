import 'package:flutter/material.dart';
import 'package:mobile_test/icons.dart';
import 'package:mobile_test/models.dart';
import 'package:mobile_test/styles.dart';
import 'package:mobile_test/pages/login.dart';

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
    title: Text("Home"),
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

// logout function
void logoutUser(BuildContext context) {
  // clear user data
  CurrentUser().clear();

  // move to login page
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false,
  );
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

  CurrentUser currUser = CurrentUser();
  
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
          child: Text('${currUser.firstName} ${currUser.lastName}', style: TextStyle(color: scheme.primary, fontSize: 24)),
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
          onTap: () => logoutUser(context),
        )
      ]
    );
  }
}
