import 'package:flutter/foundation.dart';

class Teacher {
  final String username;
  final String avatarUrl;
  final String subject;

  Teacher({
    required this.username,
    required this.avatarUrl,
    required this.subject,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    // 1) Pull out any nested "Teacher" map
    final nested = json['Teacher'] as Map<String, dynamic>? ?? {};

    // 2) Merge nested + outer into one flat map
    final flat = <String, dynamic>{}
      ..addAll(nested)
      ..addAll(json);

    // 3) Extract fields
    final username = flat['username'] as String? ?? '';
    
    final avatarRaw = flat['avatarUrl'] ?? flat['avatar'] ?? flat['email'];
    String avatarUrl = '';
    if (avatarRaw is String) {
      avatarUrl = avatarRaw;
    } else if (avatarRaw is List &&
        avatarRaw.isNotEmpty &&
        avatarRaw[0] is String) {
      avatarUrl = avatarRaw[0];
    }
    final subject = flat['subject'] as String? ?? '';

    return Teacher(
      username: username,
      avatarUrl: avatarUrl,
      subject: subject,
    );
  }
}