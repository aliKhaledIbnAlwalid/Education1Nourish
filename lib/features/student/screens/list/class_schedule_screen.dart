import 'package:edunourish/features/student/providers/student_provider.dart';
import 'package:edunourish/features/student/screens/home/notifiactions_student_screen.dart';
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
      backgroundColor: const Color(0xfff2f2f2),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        leading: IconButton(
          icon: const Icon(Icons.notifications_none_outlined, size: 30),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotificationsStudentScreen(),
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


















// import 'package:edunourish/features/student/screens/home/notifiactions_student_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// class MyClassSchedule extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xfff2f2f2),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           icon: const Icon(Icons.notifications_none_outlined, size: 30),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => NotificationsStudentScreen(),
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
//       body: Padding(
//         padding: const EdgeInsets.only(
//           left: 10,
//           right: 10,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Center(
//               child: Text(
//                 "Class Schedule",
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: "Hinted search text",
//                   prefixIcon: const Icon(Icons.view_list_rounded),
//                   suffixIcon: const Icon(Icons.search),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   fillColor: Colors.grey[200],
//                   filled: true,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
           
//             const Text("Class Schedule",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 8),
//             Expanded(
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: ScheduleTable(),
//               ),
//             ),
//             const Text("Bus schedules",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             const Text("Departure time: 7:30    Arrival time: 3:30"),
//             const SizedBox(height: 12),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SubjectCard extends StatelessWidget {
//   final String subject;
//   final String imagePath;

//   SubjectCard({required this.subject, required this.imagePath});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100,
//       width: 150,
//       decoration: BoxDecoration(
//         color: const  Color(0xffe8e6e9),
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset(imagePath, width: 50, height: 50),
//           const SizedBox(width: 8),
//           Text(subject,
//               style:
//                   const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//         ],
//       ),
//     );
//   }
// }

// class ScheduleTable extends StatelessWidget {
//   final List<List<String>> scheduleData = [
//     ["Time", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
//     ["8:30", "Math", "English", "Arabic", "RE", "ICT", "PE"],
//     ["9:50", "Math", "English", "Science", "ICT", "Math", "RE"],
//     ["10:10", "Science", "English", "Arabic", "Math", "PE", "ICT"],
//     ["11:30", "RE", "ICT", "Science", "Math", "English", "Arabic"],
//     ["12:50", "Break", "Break", "Break", "Break", "Break", "Break"],
//     ["2:30", "Math", "English", "Science", "Arabic", "PE", "ICT"],
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: DataTable(
//         border: TableBorder.all(),
//         columns: scheduleData[0]
//             .map((column) => DataColumn(
//                 label: Text(column,
//                     style: const TextStyle(fontWeight: FontWeight.bold))))
//             .toList(),
//         rows: scheduleData
//             .sublist(1)
//             .map((row) => DataRow(
//                   cells: row
//                       .map((cell) => DataCell(Center(child: Text(cell))))
//                       .toList(),
//                 ))
//             .toList(),
//       ),
//     );
//   }
// }

