class News {
  final String id;
  final String title;
  final String content;
  final String type;
  final String photo;
  final DateTime date;

  News({
    required this.id,
    required this.title,
    required this.content,
    required this.type,
    required this.photo,
    required this.date,
  });

  factory News.fromJson(Map<String, dynamic> j) {
    return News(
      id: j['id']?.toString() ?? '',
      title: j['title']?.toString() ?? '',
      content: j['content']?.toString() ?? '',
      type: j['type']?.toString() ?? '',
      photo: j['photo']?.toString() ?? '',
      // assume backend sends ISO8601 string
      date: DateTime.tryParse(j['date']?.toString() ?? '') ?? DateTime.now(),
    );
  }
}

