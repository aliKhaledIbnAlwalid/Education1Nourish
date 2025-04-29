class NeoNotification {
  final String title;
  final String time;
  NeoNotification({required this.title, required this.time});

  factory NeoNotification.fromJson(Map<String, dynamic> j) =>
      NeoNotification(title: j['title'], time: j['time']);
}
