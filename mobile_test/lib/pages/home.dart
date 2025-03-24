import 'package:flutter/material.dart';
import 'package:mobile_test/drawers.dart';
import 'package:mobile_test/icons.dart';
import 'package:mobile_test/overlays.dart';
import 'package:mobile_test/pages/dashboard.dart';
import 'package:mobile_test/pages/mocktest.dart';
import 'package:mobile_test/pages/progress.dart';
import 'package:mobile_test/pages/topicselect.dart';
import '../styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior = NavigationDestinationLabelBehavior.alwaysHide;

  void refresh(int newIndex) {
    setState(() {
      currentPageIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBarMenu(),
      drawer: TopBarDrawer(currentPageIndex: currentPageIndex, changeIndex: refresh),
      body: <Widget>[
        DashboardPage(),
        TopicSelectPage(),
        MockTestPage(),
        ProgressPage(),
      ][currentPageIndex],
      bottomNavigationBar: BottomBarMenu(currentPageIndex: currentPageIndex, changeIndex: refresh)
    );
  }
}