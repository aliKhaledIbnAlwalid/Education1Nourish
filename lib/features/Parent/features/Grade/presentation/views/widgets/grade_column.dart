import 'package:flutter/material.dart';

class GradeColumn extends StatelessWidget {
  final String label;
  final double grade;
  final bool showIcon;
  final IconData? icon;

  const GradeColumn({
    super.key,
    required this.label,
    required this.grade,
    this.showIcon = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // Determine color based on grade
    Color gradeColor;
    if (grade >= 80) {
      gradeColor = Colors.green;
    } else if (grade >= 70) {
      gradeColor = Colors.orange;
    } else {
      gradeColor = Colors.red;
    }

    return Column(
      children: [
        if (showIcon && icon != null) Icon(icon, size: 20, color: Colors.grey.shade700),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '$grade%',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: gradeColor,
          ),
        ),
      ],
    );
  }
}