import 'package:flutter/material.dart';
import '../styles.dart';

class TopicSelectPage extends StatefulWidget {
  const TopicSelectPage({super.key});

  @override
  State<TopicSelectPage> createState() => _TopicSelectPageState();
}

class _TopicSelectPageState extends State<TopicSelectPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("select topic dawg",
        style: Styles.buttonTextStyle,)
    );
  }
}