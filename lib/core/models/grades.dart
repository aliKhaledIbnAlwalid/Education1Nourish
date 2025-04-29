class Grades {
  final String examId;
  final String obtainedMarks;
  final String grade;
  final String studentIDg;

  Grades({
    required this.examId,
    required this.obtainedMarks,
    required this.grade,
    required this.studentIDg,
  });

  factory Grades.fromJson(Map<String, dynamic> json) {
    // 1) Pull out any nested "Teacher" map
    final nested = json['Grads'] as Map<String, dynamic>? ?? {};

    // 2) Merge nested + outer into one flat map
    final flat = <String, dynamic>{}
      ..addAll(nested)
      ..addAll(json);

    // 3) Extract fields
    final examId = flat['examId'] as String? ?? '';
    final obtainedMarks = flat['obtainedMarks'] as String? ?? '';
    final grade = flat['grade'] as String? ?? '';
    final studentIDg = flat['StudentIDg'] as String? ?? '';

    return Grades(
      examId: examId,
      obtainedMarks: obtainedMarks,
      grade: grade,
      studentIDg: studentIDg,
    );
  }
}
