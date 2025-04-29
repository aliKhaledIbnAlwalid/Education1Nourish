import 'package:edunourish/core/models/grades.dart';
import 'package:edunourish/features/student/providers/student_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GradesScreen extends StatelessWidget {
  const GradesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<StudentProvider>();
    if (prov.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final grades = prov.grades;
    if (grades.isEmpty) {
      return const Center(child: Text('No grades available.'));
    }

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(
          'Grades',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        itemCount: grades.length,
        itemBuilder: (context, index) {
          final g = grades[index];
          return _GradeCard(grade: g);
        },
      ),
    );
  }
}

class _GradeCard extends StatelessWidget {
  final Grades grade;
  const _GradeCard({Key? key, required this.grade}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exam ID and Student
            Text(
              'Exam ID: ${grade.examId}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Student ID: ${grade.studentIDg}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            const Divider(height: 20),

            // Obtained Marks
            Row(
              children: [
                const Icon(Icons.score, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Score: ${grade.obtainedMarks}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Letter Grade
            Row(
              children: [
                const Icon(Icons.grade, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Grade: ${grade.grade}',
                  style: TextStyle(
                    fontSize: 14,
                    color: _gradeColor(grade.grade),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Color code based on grade string
  Color _gradeColor(String grade) {
    switch (grade.toUpperCase()) {
      case 'A':
      case 'A+':
        return Colors.green;
      case 'B':
      case 'B+':
        return Colors.orange;
      default:
        return Colors.red;
    }
  }
}
