import 'package:flutter/material.dart';

class ClassGridScreen extends StatelessWidget {
  final List<Map<String, String>> classes = [
    {'name': 'Class A1', 'students': '30'},
    {'name': 'Class A2', 'students': '25'},
    {'name': 'Class B1', 'students': '28'},
    {'name': 'Class B2', 'students': '22'},
    {'name': 'Class C1', 'students': '35'},
    {'name': 'Class C2', 'students': '20'},
    {'name': 'Class D1', 'students': '18'},
    {'name': 'Class D2', 'students': '27'},
    {'name': 'Class E1', 'students': '32'},
    {'name': 'Class E2', 'students': '29'},
    {'name': 'Class F1', 'students': '24'},
    {'name': 'Class F2', 'students': '26'},
    {'name': 'Class G1', 'students': '21'},
    {'name': 'Class G2', 'students': '23'},
    {'name': 'Class H1', 'students': '19'},
    {'name': 'Class H2', 'students': '30'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Classes',
          style: TextStyle(color: Colors.teal, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
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
        padding: const EdgeInsets.all(12.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 3 / 3.2,
          children: classes.map((classData) {
            return GestureDetector(
              onTap: () {
                // Navigate to class details screen
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.class_, size: 48, color: Colors.teal),
                    const SizedBox(height: 10),
                    Text(
                      classData['name']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.teal,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.person, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          '${classData['students']} Student',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
