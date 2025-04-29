import 'package:edunourish/features/student/providers/student_provider.dart';
import 'package:edunourish/features/student/screens/home/notifiactions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ClassScheduleStudent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prov = context.watch<StudentProvider>();
    if (prov.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final classSchedule = prov.classSchedule; 
    if (classSchedule.isEmpty) {
      return const Center(child: Text('No exams scheduled.'));
    }

    return Scaffold(
      backgroundColor: const Color(0xffcdc9cf),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
      body: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Class Schedule",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Hinted search text",
                  prefixIcon: const Icon(Icons.view_list_rounded),
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Subjects",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text("Class Schedule",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  border: TableBorder.all(),
                  columns: const [
                    DataColumn(
                        label: Text('Day',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Time',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Subject',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  rows: classSchedule
                      .map((entry) => DataRow(cells: [
                            DataCell(Text(entry.day)),
                            DataCell(Text(entry.time)),
                            DataCell(Text(entry.subject)),
                          ]))
                      .toList(),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text("Bus schedules",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text("Departure time: 7:30    Arrival time: 3:30"),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

















// import 'package:flutter/material.dart';

// class MyClassSchedule extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.amber[200],
//       appBar: AppBar(
//         title: const Text("classes"),
//         backgroundColor: Colors.amber,
//         actions: const [Icon(Icons.notifications)],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               decoration: InputDecoration(
//                 hintText: "Hinted search text",
//                 prefixIcon: const Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 fillColor: Colors.white,
//                 filled: true,
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Row(
//               children: [
//                 SubjectCard(subject: "Math", imagePath: "assets/student/My_Teachers/teacher3.png"),
//                 SizedBox(width: 10),
//                 SubjectCard(subject: "Science", imagePath: "assets/student/My_Teachers/teacher3.png"),
//               ],
//             ),
//             const SizedBox(height: 16),
//             const Text("Class Schedule", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 8),
//             Expanded(
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: ScheduleTable(),
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Text("Bus schedules", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             const Text("Departure time: 7:30    Arrival time: 3:30"),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//           BottomNavigationBarItem(icon: Icon(Icons.schedule), label: "Schedule"),
//           BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
//         ],
//       ),
//     );
//   }
// }

// class SubjectCard extends StatelessWidget {
//   final String subject;
//   final String imagePath;

//   const SubjectCard({required this.subject, required this.imagePath});

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(imagePath, width: 30, height: 30),
//             const SizedBox(width: 8),
//             Text(subject, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ScheduleTable extends StatelessWidget {
//   final List<List<String>> scheduleData = [
//     ["Time", "Mon", "Tue", "Wed", "Thu", "Sat"],
//     ["8:30", "Math", "English", "Arabic", "RE", "PE"],
//     ["9:50", "Math", "English", "Arabic", "ICT", ""],
//     ["10:10", "Science", "English", "", "Arabic", ""],
//     ["11:30", "RE", "ICT", "Science", "Math", "English"],
//     ["12:50", "Break", "Break", "Break", "Break", "Break"],
//     ["2:30", "Math", "English", "Science", "Arabic", "PE"],
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Table(
//       border: TableBorder.all(),
//       children: scheduleData.map((row) {
//         return TableRow(
//           children: row.map((cell) {
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Center(child: Text(cell, style: const TextStyle(fontSize: 16))),
//             );
//           }).toList(),
//         );
//       }).toList(),
//     );
//   }
// }

