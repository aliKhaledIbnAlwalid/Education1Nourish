import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:edunourish/features/student/providers/student_provider.dart';
import 'package:edunourish/features/student/screens/home/settings_screen.dart';
import 'package:edunourish/features/student/screens/list/class_schedule_screen.dart';
import 'package:edunourish/features/student/widgets/drawer_widget.dart';
import 'package:edunourish/features/student/screens/home/home_student.dart';
import 'package:edunourish/features/student/screens/home/activities_screen.dart';

class BtmNavBarStudent extends StatefulWidget {
  static const routeName = '/student-home';
  const BtmNavBarStudent({super.key});

  @override
  State<BtmNavBarStudent> createState() => _BtmNavBarStudentState();
}

class _BtmNavBarStudentState extends State<BtmNavBarStudent> {
  int _selectedIndex = 2;

  final List<Widget> _pages = [
    const DrawerPage(),
    MyClassSchedule(),
    const HomeStudent(),
    Activities(),
  ];

  @override
  void initState() {
    super.initState();
    // Defer your initial data load until after the first frame:
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StudentProvider>().loadInitialData();
    });
  }

  void _onTap(int index) {
    if (index == 4) {
      _showSettings();
    } else {
      setState(() => _selectedIndex = index);
    }
  }

  void _showSettings() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: const SettingsStudent(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        currentIndex: _selectedIndex,
        onTap: _onTap,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xff008f99),
        selectedLabelStyle:
            const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontSize: 14),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.view_list_rounded), label: 'List'),
          BottomNavigationBarItem(
              icon: Icon(Icons.table_view_rounded), label: 'Schedule'),
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.sports_gymnastics_rounded), label: 'Activities'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_rounded), label: 'Settings'),
        ],
      ),
    );
  }
}
