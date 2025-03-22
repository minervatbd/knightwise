import 'package:flutter/material.dart';
import '../styles.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key, required this.title});

  final String title;

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: null,
      bottomNavigationBar: null,
    );
  }
}