import 'dart:convert';
import 'package:edunourish/core/models/exam.dart';
import 'package:edunourish/core/models/food_palce.dart';
import 'package:edunourish/core/models/news.dart';
import 'package:edunourish/core/services/api_services.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/models/profile.dart';
import '../../../core/models/teacher_model.dart';
import '../../../core/models/class_schedule.dart';
import '../../../core/models/grades.dart';
import '../../../core/models/notification.dart';
import '../../../core/models/subject_info.dart';

class StudentProvider extends ChangeNotifier {
  final ApiService _api = ApiService();

  List<SubjectInfo> subjects = [];
  List<News> newsList = []; 
  List<Exam> exams = [];
  List<Teacher> teachers = [];
  List<FoodPlace> foodPlace = [];
  List<ClassSchedule> classSchedule = [];
  List<Grades> grades = [];
  List<NeoNotification> notifications = [];
  Profile? profile;

  List<DateTime> attendanceDates = [];

  bool isLoading = false;
  int currentTabIndex = 2;

  StudentProvider() {
    loadInitialData(); // the provider bybd2a y3ml loadInitialData 3shan y3ml load l data el awl
    // 3shan el data ely fe el provider yb2a 3ndna 3shan n3ml l render l el data
  }

  Future<void> loadInitialData() async {
    isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';
    
    profile = await _api.fetchProfile(token);
    classSchedule = await _api.fetchClassSchedule(profile?.classId as String);
    exams = await _api.fetchExams(profile?.id as String);
    grades = await _api.fetchGrades(token);
    foodPlace = await _api.fetchFoodPlace();
    subjects = await _api.fetchSubjects(token);
    teachers = await _api.fetchTeacher(profile?.classId as String);
    newsList = await _api.fetchNews();
    

    isLoading = false;
    notifyListeners();
  }

  void setTabIndex(int idx) {
    currentTabIndex = idx;
    notifyListeners();
  }
}
