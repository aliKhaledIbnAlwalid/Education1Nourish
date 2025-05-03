class SubjectInfo {
  // final String subjectId; // may be not use
  final String name;
  final String code;
  final String category; // arabic , math , science , english , etc
  final String gradeLevel; // Primary , Secondary , HighSchool
  final String semester;
  final String description;

  SubjectInfo(
      {
      // required this.subjectId,
      required this.name,
      required this.code,
      required this.category,
      required this.gradeLevel,
      required this.semester,
      required this.description});

  factory SubjectInfo.fromJson(Map<String, dynamic> json) {
    // 1) Pull out any nested "Teacher" map
    final nested = json['Subjects'] as Map<String, dynamic>? ?? {};

    // 2) Merge nested + outer into one flat map
    final flat = <String, dynamic>{}
      ..addAll(nested)
      ..addAll(json);

    // 3) Extract fields
    final name = flat['username'] as String? ?? '';
    final code = flat['code'] as String? ?? '';
    final category = flat['category'] as String? ?? '';
    final gradeLevel = flat['gradeLevel'] as String? ?? '';
    final semester = flat['semester'] as String? ?? '';
    final description = flat['description'] as String? ?? '';

    return SubjectInfo(
      // subjectId: subjectId,
      name: name,
      code: code,
      category: category,
      gradeLevel: gradeLevel,
      semester: semester,
      description: description,
    );
  }
}
