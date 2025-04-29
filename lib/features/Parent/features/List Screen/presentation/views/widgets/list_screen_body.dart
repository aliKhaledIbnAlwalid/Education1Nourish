
import 'package:edunourish/features/Parent/core/utils/assets.dart';
import 'package:edunourish/features/Parent/core/widgets/base_scaffold.dart';
import 'package:edunourish/features/Parent/features/Attendence%20Screen/presentation/views/attendence_screen.dart';
import 'package:edunourish/features/Parent/features/Classes/presentation/views/classes_screen.dart';
import 'package:edunourish/features/Parent/features/Exam/presentation/views/exam_screen.dart';
import 'package:edunourish/features/Parent/features/Parent%20Profile/presentation/views/parent_profile.dart';
import 'package:edunourish/features/Parent/features/Restaurant%20Screen/presentation/views/restaurant_screen.dart';
import 'package:edunourish/features/Parent/features/Settings%20Screen/presentation/views/settings_screen.dart';
import 'package:edunourish/features/Parent/features/Teacher%20Screen/presentation/views/teacher_screen.dart';
import 'package:flutter/material.dart';

class ListScreenBody extends StatelessWidget {
  const ListScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  BaseScaffold(child: Column(
        children: [
          const Center(
            child: CircleAvatar(
              radius: 80,
              backgroundColor: Colors.blue,
              backgroundImage:
                  AssetImage(teacherImage),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Mohamed Hamdy',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Text(
            'MohamedHamdy@gamil.com',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          const Divider(
            color: Colors.black,
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
                      color: Colors.black,
                    ),
                    title: const Text(
                      'My Teachers',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TeacherScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.fastfood_outlined,
                      size: 30,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'Restaurent',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RestaurantScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.table_view_rounded,
                      size: 30,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'My Class Schedule',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ClassesScreen(),
                        ),
                      );
                    },
                  ),
                  
                  ListTile(
                    leading: const Icon(
                      Icons.book_outlined,
                      size: 30,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'ُExams',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ExamScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.calendar_month_rounded,
                      size: 30,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'Attendance',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AttendenceScreen(),
                        ),
                      );
                    },
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.settings_outlined,
                      size: 30,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.person_outlined,
                      size: 30,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ParentProfile(),
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

