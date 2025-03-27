import 'package:flutter/material.dart';

abstract class NavigationIcons {
  static const menu = Icon(Icons.menu);
  static const dashboard = Icon(Icons.grid_view_outlined);
  static const dashboardSelected = Icon(Icons.grid_view, color: Colors.black,);
  static const topicSelection = Icon(Icons.chat_bubble_outline_outlined);
  static const topicSelectionSelected = Icon(Icons.chat_bubble_outline, color: Colors.black,);
  static const mockTest = Icon(Icons.description_outlined);
  static const mockTestSelected = Icon(Icons.description, color: Colors.black,);
  static const myProgress = Icon(Icons.bar_chart_outlined);
  static const myProgressSelected = Icon(Icons.bar_chart, color: Colors.black,);
  static const logout = Icon(Icons.logout);
  static const previous = Icon(Icons.arrow_back);
  static const next = Icon(Icons.arrow_forward);
  static const answer = Icon(Icons.circle_outlined);
  static const answerSelected = Icon(Icons.circle);
} 
