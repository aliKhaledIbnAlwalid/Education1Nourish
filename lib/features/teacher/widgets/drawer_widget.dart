import 'package:edunourish/features/teacher/screens/home/Settings_screen.dart';
import 'package:edunourish/features/teacher/screens/home/classes_screen.dart';
import 'package:edunourish/features/teacher/screens/home/notifiactions_screen.dart';
import 'package:edunourish/features/teacher/screens/home/students_screen.dart';
import 'package:edunourish/features/teacher/screens/home/upload_material_screen.dart';
import 'package:edunourish/features/teacher/screens/list/Class_Schedule_screen.dart';
import 'package:edunourish/features/teacher/screens/list/exam_screen.dart';
import 'package:edunourish/features/teacher/screens/list/profile_screen.dart';
import 'package:flutter/material.dart';

class DrawerPageTeacher extends StatelessWidget {
  const DrawerPageTeacher({super.key});

  // Helper method to navigate to a different screen
  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  // Helper method to create ListTile
  Widget _buildListTile(
      BuildContext context, IconData icon, String title, Widget screen) {
    return ListTile(
      leading: Icon(icon, size: 30, color: Colors.black),
      title: Text(
        title,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      onTap: () => _navigateTo(context, screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      appBar: AppBar(
        backgroundColor: Colors.teal.shade100,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.notifications_none_outlined, size: 30),
          onPressed: () =>
              _navigateTo(context, NeoNotificationsTeacherScreen()),
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
          const Text('Mario Samy',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          const Text('MarioSamy@gamil.com',
              style: TextStyle(fontSize: 18, color: Colors.black)),
          const SizedBox(height: 10),
          const Divider(
              color: Colors.black, thickness: 1, indent: 20, endIndent: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildListTile(context, Icons.switch_account_outlined,
                      'Classes', ClassGridScreen()),
                  _buildListTile(context, Icons.groups_2_outlined, 'Students',
                      const StudentsScreen()),
                  _buildListTile(context, Icons.table_view_rounded,
                      'My Classes Schedule', ClassScheduleTeacher()),
                  _buildListTile(context, Icons.upload, 'Upload Materials',
                      const TeacherMaterialScreen()),
                  _buildListTile(context, Icons.book_outlined, 'ُExams',
                      const ExamTeacher()),
                  const Divider(
                      color: Colors.black,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20),
                  _buildListTile(context, Icons.settings_outlined, 'Settings',
                      const SettingsTeacher()),
                  _buildListTile(context, Icons.person_outlined, 'Profile',
                      const ProfilePageTeacher()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// this is the old code that wasnt defactored yet

// import 'package:edunourish/Student_Interface/BtmNavBar/Exams_students.dart';
// import 'package:edunourish/Student_Interface/BtmNavBar/profile_page_student.dart';
// import 'package:edunourish/Teacher_Interface/BtmNavBar/Class_Schedule_teacher.dart';
// import 'package:edunourish/Teacher_Interface/BtmNavBar/Settings_teacher.dart';
// import 'package:edunourish/Teacher_Interface/BtmNavBar/upload_material_screen.dart';
// import 'package:edunourish/Teacher_Interface/Home/classes_teacher.dart';
// import 'package:edunourish/Teacher_Interface/Home/students_teacher.dart';
// import 'package:flutter/material.dart';
// import '../Home/notifiactions_screen_teacher.dart';

// class DrawerPageTeacher extends StatelessWidget {
//   const DrawerPageTeacher({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xff98afb0),
//       appBar: AppBar(
//         backgroundColor: const Color(0xff98afb0),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.notifications_none_outlined, size: 30),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => NeoNotificationsTeacherScreen(),
//               ),
//             );
//           },
//         ),
//         actions: const [
//           Image(
//             image: AssetImage('assets/Intro_Screen_login/EduIcon.png'),
//             height: 50,
//             width: 50,
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           const Center(
//             child: CircleAvatar(
//               radius: 80,
//               backgroundColor: Color(0xff98afb0),
//               backgroundImage:
//                   AssetImage('assets/Intro_Screen_login/EduIcon.png'),
//             ),
//           ),
//           const SizedBox(height: 12),
//           const Text(
//             'Mario Samy',
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//           const Text(
//             'MarioSamy@gamil.com',
//             style: TextStyle(
//               fontSize: 18,
//               color: Colors.black,
//             ),
//           ),
//           const SizedBox(height: 10),
//           const Divider(
//             color: Colors.black,
//             thickness: 1,
//             indent: 20,
//             endIndent: 20,
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   ListTile(
//                     leading: const Icon(
//                       Icons.people_outline,
//                       size: 30,
//                       color: Colors.black,
//                     ),
//                     title: const Text(
//                       'Classes',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => ClassGridScreen(),
//                         ),
//                       );
//                     },
//                   ),
//                   ListTile(
//                     leading: const Icon(
//                       Icons.fastfood_outlined,
//                       size: 30,
//                       color: Colors.black,
//                     ),
//                     title: const Text(
//                       'Students',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const StudentsScreen(),
//                         ),
//                       );
//                     },
//                   ),
//                   ListTile(
//                     leading: const Icon(
//                       Icons.table_view_rounded,
//                       size: 30,
//                       color: Colors.black,
//                     ),
//                     title: const Text(
//                       'My Classes Schedule',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => ClassScheduleTeacher(),
//                         ),
//                       );
//                     },
//                   ),
//                   ListTile(
//                     leading: const Icon(
//                       Icons.upload,
//                       size: 30,
//                       color: Colors.black,
//                     ),
//                     title: const Text(
//                       'Upload Materials',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => TeacherMaterialScreen(),
//                         ),
//                       );
//                     },
//                   ),
//                   ListTile(
//                     leading: const Icon(
//                       Icons.book_outlined,
//                       size: 30,
//                       color: Colors.black,
//                     ),
//                     title: const Text(
//                       'ُExams',
//                       style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const ExamsStudents(),
//                         ),
//                       );
//                     },
//                   ),
//                   const Divider(
//                     color: Colors.black,
//                     thickness: 1,
//                     indent: 20,
//                     endIndent: 20,
//                   ),
//                   ListTile(
//                     leading: const Icon(
//                       Icons.settings_outlined,
//                       size: 30,
//                       color: Colors.black,
//                     ),
//                     title: const Text(
//                       'Settings',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const SettingsTeacher(),
//                         ),
//                       );
//                     },
//                   ),
//                   ListTile(
//                     leading: const Icon(
//                       Icons.person_outlined,
//                       size: 30,
//                       color: Colors.black,
//                     ),
//                     title: const Text(
//                       'Profile',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const ProfilePageStudent(),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
