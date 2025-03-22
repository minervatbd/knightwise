import 'package:flutter/material.dart';
import '../styles.dart';

class MockTestResultsPage extends StatefulWidget {
  const MockTestResultsPage({super.key, required this.title});

  final String title;

  @override
  State<MockTestResultsPage> createState() => _MockTestResultsPageState();
}

class _MockTestResultsPageState extends State<MockTestResultsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: null,
      bottomNavigationBar: null,
    );
  }
}