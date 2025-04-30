import 'package:edunourish/features/Parent/core/utils/app_router.dart';
import 'package:edunourish/features/Parent/core/utils/assets.dart';
import 'package:edunourish/core/utils/constants.dart';
import 'package:edunourish/features/Parent/core/utils/styles.dart';
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
    return BaseScaffold(
      child: Container(
        color: ourBackgroundColor,
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                child: ListView(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10, bottom: 15),
                      child: Text(
                        'Menu',
                        style: textBold28,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildSettingsCategory(title: 'Academic', icon: Icons.school_outlined),
                    
                    _buildSettingsTile(
                      icon: Icons.people_outline,
                      title: 'My Teachers',
                      onTap: () {
                        AppRouter.toTeacherScreen(context);
                      },
                    ),
                    
                    _buildSettingsTile(
                      icon: Icons.table_view_rounded,
                      title: 'My Class Schedule',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ClassesScreen(),
                          ),
                        );
                      },
                    ),
                    
                    _buildSettingsTile(
                      icon: Icons.book_outlined,
                      title: 'Exams',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ExamScreen(),
                          ),
                        );
                      },
                    ),
                    
                    _buildSettingsTile(
                      icon: Icons.calendar_month_rounded,
                      title: 'Attendance',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AttendenceScreen(),
                          ),
                        );
                      },
                    ),
                    
                    const SizedBox(height: 20),
                    _buildSettingsCategory(title: 'Services', icon: Icons.room_service_outlined),
                    
                    _buildSettingsTile(
                      icon: Icons.fastfood_outlined,
                      title: 'Restaurant',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RestaurantScreen(),
                          ),
                        );
                      },
                    ),
                    
                    const SizedBox(height: 20),
                    _buildSettingsCategory(title: 'Personal', icon: Icons.person_outline),
                    
                    _buildSettingsTile(
                      icon: Icons.person_outlined,
                      title: 'Profile',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ParentProfile(),
                          ),
                        );
                      },
                    ),
                    
                    _buildSettingsTile(
                      icon: Icons.settings_outlined,
                      title: 'Settings',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingsScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsCategory({required String title, required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, bottom: 8, top: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.withOpacity(0.1)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Icon(icon, color: ourMainColor),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16, color: ourMainColor),
        onTap: onTap,
      ),
    );
  }
}