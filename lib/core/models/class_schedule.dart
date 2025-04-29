class ClassSchedule {
final String day;
final String subject;
final String time;  

  ClassSchedule({
    required this.day,
    required this.subject,
    required this.time,
  });

  factory ClassSchedule.fromJson(Map<String, dynamic> j) => ClassSchedule(
        day: j['day'] ?? '',
        subject: j['subject'] ?? '',
        time: j['time'] ?? '',
      );
}
