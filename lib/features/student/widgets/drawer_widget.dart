import 'package:edunourish/features/auth/screens/login_screen.dart';
import 'package:edunourish/features/student/screens/home/attendance_screen.dart';
import 'package:edunourish/features/student/screens/home/exams_screen.dart';
import 'package:edunourish/features/student/screens/home/food_place_screen.dart';
import 'package:edunourish/features/student/screens/list/grades_screen.dart';
import 'package:edunourish/features/student/screens/list/my_teachers_screen.dart';
import 'package:edunourish/features/student/screens/list/profile_screen.dart';
import 'package:edunourish/features/student/screens/home/notifiactions_student_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({Key? key}) : super(key: key);

  static const Color accentColor = Color(0xff008f99);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.notifications_none_outlined,
              size: 30, color: accentColor),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => NotificationsStudentScreen()),
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Image(
              image: AssetImage('assets/Intro_Screen_login/EduIcon.png'),
              height: 50,
              width: 50,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Stack(
              children: [
                // Main teal background
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff008f99),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                // Translucent circle accent
                Positioned(
                  top: 175,
                  left: 100,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.4),
                    ),
                  ),
                ),
                Positioned(
                  top: -2,
                  left: 250,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.4),
                    ),
                  ),
                ),
                Positioned(
                  top: -20,
                  left: -20,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                ),
                Positioned(
                  top: 90,
                  left: 280,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.4),
                    ),
                  ),
                ),
                // Content row
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Avatar
                        const CircleAvatar(
                          radius: 36,
                          backgroundImage: NetworkImage(
                              'https://t4.ftcdn.net/jpg/02/79/66/93/240_F_279669366_Lk12QalYQKMczLEa4ySjhaLtx1M2u7e6.jpg'),
                          backgroundColor: Colors.white,
                        ),
                        const SizedBox(width: 16),
                        // Name & phone
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Maryam Ahmed',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Phone number: 01012345678',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Edit Profile button
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: [
                const Divider(
                    color: Color(0xff969696),
                    thickness: 1.25,
                    indent: 5,
                    endIndent: 5),
                _buildTile(
                  context,
                  icon: Icons.people_outline,
                  title: 'My Teachers',
                  page: const TeachersListScreen(),
                ),
                _buildTile(
                  context,
                  icon: Icons.fastfood_outlined,
                  title: 'Food Place',
                  page: const FoodPlaceScreen(),
                ),
                _buildTile(
                  context,
                  icon: Icons.task_outlined,
                  title: 'Grades',
                  page: const GradesScreen(),
                ),
                _buildTile(
                  context,
                  icon: Icons.book_outlined,
                  title: 'Exams',
                  page: const ExamsScreen(),
                ),
                _buildTile(
                  context,
                  icon: Icons.calendar_month_rounded,
                  title: 'Attendance',
                  page: const CalendarScreen(),
                ),
                _buildTile(
                  context,
                  icon: Icons.person_outlined,
                  title: 'Profile',
                  page: const ProfilePageStudent(),
                ),
                Card(
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  margin:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  child: ListTile(
                    leading: const Icon(Icons.exit_to_app,
                        color: Colors.white, size: 28),
                    title: const Text(
                      //  textAlign: TextAlign.center,
                      'Logout',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.clear();
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (_) => const LoginScreen(role: 'student')),
                        (route) => false,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(BuildContext context,
      {required IconData icon, required String title, required Widget page}) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: ListTile(
        leading: Icon(icon, color: accentColor, size: 28),
        title: Text(
          title,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xff1a2226)),
        ),
        trailing: const Icon(Icons.arrow_forward_ios,
            color: Color(0xff969696), size: 16),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        ),
      ),
    );
  }
}
