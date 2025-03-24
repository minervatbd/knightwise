import 'package:flutter/material.dart';

class Problem {
  const Problem(
      this.id,
      this.exam_id,
      this.section,
      this.category,
      this.subcategory,
      this.question,
      this.answerCorrect,
      this.answersWrong,
    );
  
  final String id;
  final String exam_id;
  final String section;
  final String category;
  final String subcategory;
  final String question;
  final String answerCorrect;
  final String answersWrong;
}