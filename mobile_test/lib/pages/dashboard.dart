import 'package:flutter/material.dart';
import 'package:mobile_test/drawers.dart';
import 'package:mobile_test/overlays.dart';
import '../styles.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key, required this.title});

  final String title;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBarMenu(),
      bottomNavigationBar: BottomBarMenu(),
      drawer: TopBarDrawer(),
      body: Center(
        child: Text("Time until foundation exam: 2 minutes UH OH GET STUDYING")
      ),
    );
  }
}