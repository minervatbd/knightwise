import 'package:flutter/material.dart';
import 'styles.dart';
import 'icons.dart';

const scheme = Styles.schemeMain;

class TopBarDrawer extends StatelessWidget {
  const TopBarDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.white,
        child: ListView(
    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
    children: <Widget>[
      // dashboard
      DrawerHeader(
        decoration: BoxDecoration(color: scheme.secondary),
        child: Text('firstname lastname', style: TextStyle(color: scheme.primary, fontSize: 24)),
      ),
      ListTile(
        leading: NavigationIcons.dashboard,
        iconColor: scheme.primary,
        textColor: scheme.primary,
        tileColor: scheme.surface,
        title: const Text('Dashboard'),
        onTap: () {
          print("dashboard");
        }
      ),
      // topic practice
      ListTile(
        leading: NavigationIcons.topicSelection,
        iconColor: scheme.primary,
        textColor: scheme.primary,
        tileColor: scheme.surface,
        title: const Text('Topic Practice'),
        onTap: () {
          print("topic practice");
        }
      ),
      // mock test
      ListTile(
        leading: NavigationIcons.mockTest,
        iconColor: scheme.primary,
        textColor: scheme.primary,
        tileColor: scheme.surface,
        title: const Text('Mock Test'),
        onTap: () {
          print("mock test");
        }
      ),
      // my progress
      ListTile(
        leading: NavigationIcons.myProgress,
        iconColor: scheme.primary,
        textColor: scheme.primary,
        tileColor: scheme.surface,
        title: const Text('My Progress'),
        onTap: () {
          print("my progress");
        }
      ),
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
        ) 
      );
  }
}