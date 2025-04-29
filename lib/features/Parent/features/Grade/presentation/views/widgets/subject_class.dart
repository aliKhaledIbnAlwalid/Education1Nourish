import 'package:flutter/material.dart';

class Subject {
  final String name;
  final double assignmentGrade;
  final double quizGrade;
  final double finalGrade;
  final Color color;

  Subject({
    required this.name,
    required this.assignmentGrade,
    required this.quizGrade,
    required this.finalGrade,
    this.color = Colors.blue,
  });
}