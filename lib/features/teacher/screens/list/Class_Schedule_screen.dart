import 'package:flutter/material.dart';

class ClassScheduleTeacher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffcdc9cf),
      appBar: AppBar(
        backgroundColor: const Color(0xffcdc9cf),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 30),
          onPressed: () {
            Navigator.pop(
              context,
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
            const SizedBox(height: 32),
            const Text("Class Schedule",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ScheduleTable(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScheduleTable extends StatelessWidget {
  final List<List<String>> scheduleData = [
    ["Time", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
    ["8:30", "Math", "English", "Arabic", "RE", "ICT", "PE"],
    ["9:50", "Math", "English", "Science", "ICT", "Math", "RE"],
    ["10:10", "Science", "English", "Arabic", "Math", "PE", "ICT"],
    ["11:30", "RE", "ICT", "Science", "Math", "English", "Arabic"],
    ["12:50", "Break", "Break", "Break", "Break", "Break", "Break"],
    ["2:30", "Math", "English", "Science", "Arabic", "PE", "ICT"],
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        border: TableBorder.all(),
        columns: scheduleData[0]
            .map((column) => DataColumn(
                label: Text(column,
                    style: const TextStyle(fontWeight: FontWeight.bold))))
            .toList(),
        rows: scheduleData
            .sublist(1)
            .map((row) => DataRow(
                  cells: row
                      .map((cell) => DataCell(Center(child: Text(cell))))
                      .toList(),
                ))
            .toList(),
      ),
    );
  }
}
