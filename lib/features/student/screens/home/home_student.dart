import 'dart:async';

import 'package:edunourish/features/Parent/features/Exam/presentation/views/exam_screen.dart';
import 'package:edunourish/features/student/screens/home/attendance_screen.dart';
import 'package:edunourish/features/student/screens/home/exam_screen.dart';
import 'package:edunourish/features/student/screens/home/notifiactions_screen.dart';
import 'package:edunourish/features/teacher/screens/home/home_teacher.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'subject_screen.dart';

class HomeStudent extends StatefulWidget {
  const HomeStudent({super.key});
  @override
  State<HomeStudent> createState() => _HomeStudentState();
}

class _HomeStudentState extends State<HomeStudent> {
  late final PageController _pageController =
      PageController(initialPage: _currentPage);
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 9) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff2f2f2),
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.notifications_none_outlined, size: 30),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotificationsScreen(),
              ),
            );
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 120, right: 20, left: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color(0xff008f99),
                ),
                height: 250,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewsPage(
                              title: 'News Item $index',
                              subtitle: 'Subtitle for news item $index',
                              imagePath:
                                  'assets/face.png', // update path if needed
                              details:
                                  'This is the detailed content of news item number $index. It contains full text, explanation, and more info about this news article.',
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          width: 350,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                spreadRadius: 2,
                              )
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'News Item $index',
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SmoothPageIndicator(
            controller: _pageController,
            count: 10,
            effect: const ExpandingDotsEffect(
              dotWidth: 8,
              dotHeight: 8,
              activeDotColor: Color(0xff008f99),
              dotColor: Color(0xff969696),
            ),
            onDotClicked: (index) {
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: _buildFeatureCard(
                      "assets/student/Home_Student/exam.png", "Exams"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ExamScreen(),
                      ),
                    );
                  },
                ),
                GestureDetector(
                  child: _buildFeatureCard(
                      "assets/student/Home_Student/Calendar.png", "Attendance"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Attendance(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: _buildFeatureCard(
                      "assets/student/Home_Student/Toast.png", "Food Place"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Restaurant(),
                      ),
                    );
                  },
                ),
                GestureDetector(
                  child: _buildFeatureCard(
                      "assets/student/Home_Student/TaskList.png",
                      "My Subjects"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SubjectScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildFeatureCard(String imagePath, String title) {
  return Container(
    width: 170,
    height: 170,
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xff008f99), width: 2),
      borderRadius: BorderRadius.circular(16),
      color: Colors.white,
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 6,
          offset: Offset(0, 4),
        )
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(imagePath, height: 100),
        Text(title,
            style: const TextStyle(
                color: Color(0xff008f99),
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ],
    ),
  );
}
