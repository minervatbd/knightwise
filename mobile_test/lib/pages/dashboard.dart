import 'package:flutter/material.dart';
import '../styles.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Time until foundation exam: 2 minutes UH OH GET STUDYING",
        style: Styles.buttonTextStyle,
      )
    );
  }
}