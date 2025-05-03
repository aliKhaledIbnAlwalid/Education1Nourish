import 'package:edunourish/core/models/grades.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:edunourish/features/student/providers/student_provider.dart';

class GradesScreen extends StatelessWidget {
  const GradesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<StudentProvider>();
    if (prov.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final grades = prov.grades;
    if (grades.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('No grades available.')),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      appBar: AppBar(
        title: const Text(
          'Grades',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xff1a1a1a),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: const [
          Image(
            image: AssetImage('assets/Intro_Screen_login/EduIcon.png'),
            height: 50,
            width: 50,
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        itemCount: grades.length,
        itemBuilder: (context, i) => GradeCard(grade: grades[i]),
      ),
    );
  }
}

class GradeCard extends StatelessWidget {
  final Grades grade;
  const GradeCard({Key? key, required this.grade}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subjectColor = Colors.teal;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ─── Header with subject pill and letter grade ───────────────────
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: subjectColor.withOpacity(0.2),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // subject pill
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    "french",
                    style: TextStyle(
                        color: Colors.teal, fontWeight: FontWeight.bold),
                  ),
                ),
                // letter grade circle
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.green.shade50,
                  child: Text(
                    grade.grade,
                    style: const TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ─── Scores row ─────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStat(Icons.assignment, 'Assignment', 80),
                _buildStat(Icons.help_outline, 'Quiz', 50),
                _buildStat(Icons.school, 'Final', 70),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _subjectColor(String subject) {
    switch (subject) {
      case 'Arabic':
        return Colors.red;
      case 'Math':
        return Colors.blue;
      case 'PE':
        return Colors.green;
      case 'Science':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  Widget _buildStat(IconData icon, String label, double value) {
    final color = value >= 80 ? Colors.teal : Colors.teal;
    return Column(
      children: [
        Icon(icon, size: 24, color: color),
        const SizedBox(height: 4),
        Text(label,
            style: const TextStyle(fontSize: 12, color: Colors.black54)),
        const SizedBox(height: 4),
        Text('${value.toStringAsFixed(0)}%',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:edunourish/features/student/providers/student_provider.dart';
// import 'package:edunourish/core/models/grades.dart';

// class GradesScreen extends StatelessWidget {
//   const GradesScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final prov = context.watch<StudentProvider>();
//     if (prov.isLoading) {
//       return const Scaffold(
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }

//     // Group grades by subject extracted from examId
//     final Map<String, List<Grades>> bySubject = {};
//     for (var g in prov.grades) {
//       // Assume examId format: "Subject_ExamType"
//       final parts = g.examId.split('_');
//       if (parts.length < 2) continue;
//       final subject = parts[0];
//       bySubject.putIfAbsent(subject, () => []).add(g);
//     }

//     if (bySubject.isEmpty) {
//       return const Scaffold(
//         body: Center(child: Text('No grades available.')),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         leading: const BackButton(color: Colors.black),
//         title: const Text('Grades', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
//         backgroundColor: Colors.white,
//         elevation: 1,
//       ),
//       backgroundColor: Colors.grey.shade100,
//       body: ListView(
//         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//         children: bySubject.entries.map((entry) {
//           final subject = entry.key;
//           final exams = entry.value;
//           // Lookup marks
//           double? assignment = _findMark(exams, 'Assignment');
//           double? quiz       = _findMark(exams, 'Quiz');
//           double? finalExam  = _findMark(exams, 'Final');
//           // Compute average
//           final avg = [assignment, quiz, finalExam]
//               .where((e) => e != null)
//               .map((e) => e!)
//               .fold(0.0, (a, b) => a + b) /
//             ( [assignment, quiz, finalExam].where((e) => e != null).length);
//           final letter = _letterGrade(avg);

//           return Padding(
//             padding: const EdgeInsets.only(bottom: 16),
//             child: _GradeCard(
//               subject: subject,
//               assignment: assignment,
//               quiz: quiz,
//               finalMark: finalExam,
//               overall: avg,
//               letter: letter,
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }

//   double? _findMark(List<Grades> exams, String type) {
//     final g = exams.firstWhere(
//       (e) => e.examId.toLowerCase().endsWith(type.toLowerCase()),
//       orElse: () => Grades(examId: '', obtainedMarks: '', grade: '', studentIDg: ''),
//     );
//     if (g.obtainedMarks.isEmpty) return null;
//     final num = double.tryParse(
//       g.obtainedMarks.replaceAll(RegExp(r'[^0-9.]'), ''),
//     );
//     return num;
//   }

//   String _letterGrade(double avg) {
//     if (avg >= 90) return 'A+';
//     if (avg >= 80) return 'A';
//     if (avg >= 70) return 'B';
//     if (avg >= 60) return 'C';
//     return 'D';
//   }
// }

// class _GradeCard extends StatelessWidget {
//   final String subject;
//   final double? assignment, quiz, finalMark, overall;
//   final String letter;

//   const _GradeCard({
//     required this.subject,
//     this.assignment,
//     this.quiz,
//     this.finalMark,
//     this.overall,
//     required this.letter,
//   });

//   Color _subjectColor(String sub) {
//     switch (sub.toLowerCase()) {
//       case 'arabic': return Colors.red.shade200;
//       case 'mathematics': return Colors.blue.shade200;
//       case 'science': return Colors.green.shade200;
//       case 'english': return Colors.orange.shade200;
//       case 'pe': return Colors.teal.shade200;
//       case 'ict': return Colors.purple.shade200;
//       default: return Colors.grey.shade200;
//     }
//   }

//   Color _percentColor(double? val) {
//     if (val == null) return Colors.grey;
//     if (val >= 85) return Colors.green;
//     if (val >= 70) return Colors.orange;
//     return Colors.red;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final color = _subjectColor(subject);

//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       elevation: 2,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           // Header
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             decoration: BoxDecoration(
//               color: color,
//               borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   subject,
//                   style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
//                 ),
//                 CircleAvatar(
//                   radius: 16,
//                   backgroundColor: Colors.white,
//                   child: Text(
//                     letter,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: color.darken(),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Body
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 _examColumn(Icons.assignment, 'Assignment', assignment, _percentColor(assignment)),
//                 _examColumn(Icons.question_answer, 'Quiz', quiz, _percentColor(quiz)),
//                 _examColumn(Icons.school, 'Final', finalMark, _percentColor(finalMark)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _examColumn(IconData icon, String label, double? val, Color color) {
//     return Column(
//       children: [
//         Icon(icon, size: 28, color: Colors.grey.shade700),
//         const SizedBox(height: 4),
//         Text(label, style: const TextStyle(fontSize: 14, color: Colors.black54)),
//         const SizedBox(height: 4),
//         Text(
//           val != null ? '${val.toStringAsFixed(1)}%' : '--',
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
//         ),
//       ],
//     );
//   }
// }

// // Extension to darken a color
// extension on Color {
//   Color darken([double amt = .2]) {
//     final f = 1 - amt;
//     return Color.fromARGB(
//       alpha,
//       (red * f).round(),
//       (green * f).round(),
//       (blue * f).round(),
//     );
//   }
// }
