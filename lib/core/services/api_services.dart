import 'dart:convert';
import 'package:edunourish/core/models/class_schedule.dart';
import 'package:edunourish/core/models/exam.dart';
import 'package:edunourish/core/models/food_palce.dart';
import 'package:edunourish/core/models/news.dart';
import 'package:edunourish/core/models/subject_info.dart';
import 'package:edunourish/core/models/teacher_model.dart';
import 'package:edunourish/core/models/grades.dart';
import 'package:http/http.dart' as http;
import 'package:edunourish/core/models/profile.dart';

class ApiService {
  static const String _baseUrl = 'http://54.242.19.19:3000';

  Future<Profile> fetchProfile(String token) async {
    final uri = Uri.parse('$_baseUrl/api/students/:id');
    final resp = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $token'},
    );
    _ensureJson(resp, uri);
    return Profile.fromJson(json.decode(resp.body));
  }

  Future<List<ClassSchedule>> fetchClassSchedule(String classId) async {
    final uri = Uri.parse('$_baseUrl/api/timetables/class/$classId');
    final resp = await http.get(uri);
    _ensureJson(resp, uri);
    final list = json.decode(resp.body) as List<dynamic>;
    return list
        .map((j) => ClassSchedule.fromJson(j as Map<String, dynamic>))
        .toList();
  }

  Future<List<Exam>> fetchExams(String studentId) async {
    final uri =
        Uri.parse('$_baseUrl/api/studentexams/student/$studentId/exams');
    final resp = await http.get(uri);
    _ensureJson(resp, uri);
    final list = json.decode(resp.body) as List<dynamic>;
    return list.map((j) => Exam.fromJson(j as Map<String, dynamic>)).toList();
  }

  Future<List<Grades>> fetchGrades(String token) async {
    // Correct endpoint for grades
    final uri = Uri.parse('$_baseUrl/api/students/:id');
    final resp = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $token'},
    );
    _ensureJson(resp, uri);
    final Map<String, dynamic> decoded =
        json.decode(resp.body) as Map<String, dynamic>;
    final List<dynamic> list = decoded['Grads'] as List<dynamic>;
    return list.map((j) => Grades.fromJson(j as Map<String, dynamic>)).toList();
  }

  Future<List<FoodPlace>> fetchFoodPlace() async {
    final uri = Uri.parse('$_baseUrl/api/ResturantMenu/view');
    final resp = await http.get(uri);
    _ensureJson(resp, uri);
    final list = json.decode(resp.body) as List<dynamic>;
    return list
        .map((j) => FoodPlace.fromJson(j as Map<String, dynamic>))
        .toList();
  }

  Future<List<SubjectInfo>> fetchSubjects(String token) async {
    final uri = Uri.parse('$_baseUrl/api/subjects');
    final resp = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $token'},
    );
    if (resp.statusCode != 200) {
      throw Exception('Failed to load subjects (${resp.statusCode})');
    }
    final body = json.decode(resp.body);
    // If your backend returns { "subjects": [ ... ] }:
    final List<dynamic> list =
        body is List ? body : (body['subjects'] as List<dynamic>);
    return list
        .map((j) => SubjectInfo.fromJson(j as Map<String, dynamic>))
        .toList();
  }

  Future<List<Teacher>> fetchTeacher(String classId) async {
    final uri = Uri.parse('$_baseUrl/api/class-teachers/by-class/$classId');
    final resp = await http.get(uri);
    _ensureJson(resp, uri);
    final list = json.decode(resp.body) as List<dynamic>;
    return list
        .map((j) => Teacher.fromJson(j as Map<String, dynamic>))
        .toList();
  }
  
  Future<List<News>> fetchNews() async {
    final uri = Uri.parse('$_baseUrl/api/news');
    final resp = await http.get(uri);
    _ensureJson(resp, uri);
    final Map<String, dynamic> decoded =
        json.decode(resp.body) as Map<String, dynamic>;
    final List<dynamic> list = decoded['news'] as List<dynamic>;
    return list.map((j) => News.fromJson(j as Map<String, dynamic>)).toList();
  }
  void _ensureJson(http.Response resp, Uri uri) {
    if (resp.statusCode != 200) {
      throw Exception('HTTP ${resp.statusCode} at $uri: ${resp.body}');
    }
    final ct = resp.headers['content-type'] ?? '';
    if (!ct.contains('application/json')) {
      throw FormatException('Expected JSON but got $ct from $uri', resp.body);
    }
  }
}
