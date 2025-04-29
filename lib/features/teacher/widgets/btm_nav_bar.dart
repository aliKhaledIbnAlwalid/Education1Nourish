import 'package:edunourish/features/teacher/screens/home/Settings_screen.dart';
import 'package:edunourish/features/teacher/screens/home/home_teacher.dart';
import 'package:edunourish/features/teacher/screens/home/upload_material_screen.dart';
import 'package:edunourish/features/teacher/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';

class BtmNavBarTeacher extends StatefulWidget {
  static const routeName = '/teacher-home';
  const BtmNavBarTeacher({super.key});

  @override
  State<BtmNavBarTeacher> createState() => _BtmNavBarTeacherState();
}

class _BtmNavBarTeacherState extends State<BtmNavBarTeacher> {
  int _selectedIndex = 1;

  void _navigateBottomBar(int index) {
    if (index == 3) {
      _showSettingsModal();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _showSettingsModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: const SettingsTeacher(),
      ),
    );
  }

  final List<Widget> _pages = [
    const DrawerPageTeacher(),
    const HomeTeacher(),
    const TeacherMaterialScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _selectedIndex < 0
            ? _pages[_selectedIndex]
            : _pages[_selectedIndex - 0],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          elevation: 0,
          selectedLabelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold), // Increase selected label size
          unselectedLabelStyle: const TextStyle(
            fontSize: 14,
          ),
          onTap: _navigateBottomBar,

          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xff008f99),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.view_list_rounded,
                size: 25,
              ),
              label: 'List',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(
            //     Icons.table_view_rounded,
            //     size: 25,
            //   ),
            //   label: 'Schedule',
            // ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_rounded,
                size: 25,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.upload,
                size: 25,
              ),
              label: 'Material',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings_rounded,
                size: 25,
              ),
              label: 'Settings',
            ),
          ],
        ));
  }
}
