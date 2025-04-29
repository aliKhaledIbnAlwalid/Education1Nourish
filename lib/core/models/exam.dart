class Exam {
  final String id;
  final String subjectName;
  final DateTime date;
  final String type;
  Exam({
    required this.id,
    required this.subjectName,
    required this.date,
    required this.type,
  });
  factory Exam.fromJson(Map<String, dynamic> j) {
    // Safe string extraction with fallback
    final rawId = j['id']?.toString();
    final rawSubject = j['subjectName']?.toString();
    final rawDate = j['date']?.toString();
    final rawType = j['Type']?.toString();
    // Parse date or default to now
    DateTime parsedDate;
    try {
      parsedDate = rawDate != null ? DateTime.parse(rawDate) : DateTime.now();
    } catch (_) {
      parsedDate = DateTime.now();
    }
    return Exam(
      id: rawId ?? '',
      subjectName: rawSubject ?? '',
      date: parsedDate,
      type: (rawType != null && rawType.isNotEmpty) ? rawType : 'other',
    );
  }
}
