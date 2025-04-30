import 'package:edunourish/features/student/screens/home/attendance_screen.dart';
import 'package:edunourish/features/student/screens/home/exams_screen.dart';
import 'package:edunourish/features/student/screens/home/food_place_screen.dart';
import 'package:edunourish/features/student/screens/list/class_schedule_screen.dart';
import 'package:edunourish/features/student/screens/list/grades_screen.dart';
import 'package:edunourish/features/student/screens/list/my_teachers_screen.dart';
import 'package:edunourish/features/student/screens/list/profile_screen.dart';
import 'package:flutter/material.dart';
import '../screens/home/notifiactions_screen.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.notifications_none_outlined, size: 30),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotificationsScreen(),
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
          const Center(
            child: CircleAvatar(
              radius: 80,
              backgroundColor: Color(0xff98afb0),
              backgroundImage:
                  AssetImage('assets/Intro_Screen_login/EduIcon.png'),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Mario Samy',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xff008f99),
            ),
          ),
          const Text(
            'MarioSamy@gamil.com',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xff008f99),
            ),
          ),
          const SizedBox(height: 10),
          const Divider(
            color: Color(0xff008f99),
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.people_outline,
                      size: 30,
                      color: Color(0xff008f99),
                    ),
                    title: const Text(
                      'My Teachers',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff008f99),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TeachersListScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.fastfood_outlined,
                      size: 30,
                      color: Color(0xff008f99),
                    ),
                    title: const Text(
                      'Restaurent',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff008f99),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FoodPlaceScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.table_view_rounded,
                      size: 30,
                      color: Color(0xff008f99),
                    ),
                    title: const Text(
                      'My Class Schedule',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff008f99),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyClassSchedule(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.task_outlined,
                      size: 30,
                      color: Color(0xff008f99),
                    ),
                    title: const Text(
                      'grades',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff008f99),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GradesScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.book_outlined,
                      size: 30,
                      color: Color(0xff008f99),
                    ),
                    title: const Text(
                      'ُExams',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff008f99),
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ExamsScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.calendar_month_rounded,
                      size: 30,
                      color: Color(0xff008f99),
                    ),
                    title: const Text(
                      'Attendance',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff008f99),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Attendance(),
                        ),
                      );
                    },
                  ),
                  const Divider(
                    color: Color(0xff008f99),
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.person_outlined,
                      size: 30,
                      color: Color(0xff008f99),
                    ),
                    title: const Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff008f99),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfilePageStudent(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
