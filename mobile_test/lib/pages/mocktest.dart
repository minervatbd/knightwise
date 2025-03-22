import 'package:flutter/material.dart';
import '../styles.dart';

class MockTestPage extends StatefulWidget {
  const MockTestPage({super.key, required this.title});

  final String title;

  @override
  State<MockTestPage> createState() => _MockTestPageState();
}

class _MockTestPageState extends State<MockTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: null,
      bottomNavigationBar: null,
    );
  }
}