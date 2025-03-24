import 'package:flutter/material.dart';
import '../styles.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("good job on the progress :)",
        style: Styles.buttonTextStyle,)
    );
  }
}