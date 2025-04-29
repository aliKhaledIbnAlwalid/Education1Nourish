import 'package:flutter/material.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  final List<Map<String, String>> students = [
    {'name': 'Ali Khaled ibn Al-walid', 'class': 'Class A1'},
    {'name': 'Abdo M7ssib', 'class': 'Class C2'},
    {'name': 'Mado Ashraf', 'class': 'Class B2'},
    {'name': 'Mido 3gmy', 'class': 'Class A2'},
    {'name': 'Mo2a Osos', 'class': 'Class A1'},
    {'name': 'Mario 7adara', 'class': 'Class B1'},
    {'name': 'Ali Khaled ibn Al-walid', 'class': 'Class C2'},
    {'name': 'Abdo M7ssib', 'class': 'Class C2'},
    {'name': 'Mado Ashraf', 'class': 'Class B1'},
    {'name': 'Mido 3gmy', 'class': 'Class C1'},
    {'name': 'Mo2a Osos', 'class': 'Class B2'},
    {'name': 'Mario 7adara', 'class': 'Class A1'},
    {'name': 'kero 3gmy', 'class': 'Class A1'},
  ];

  String selectedClass = 'All Students';
  String searchQuery = '';

  List<String> allClasses = [
    'All Students',
    'Class A1',
    'Class A2',
    'Class B1',
    'Class B2',
    'Class C1',
    'Class C2',
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredStudents = students.where((student) {
      final nameMatch =
          student['name']!.toLowerCase().contains(searchQuery.toLowerCase());
      final classMatch =
          selectedClass == 'All Students' || student['class'] == selectedClass;
      return nameMatch && classMatch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Students',
          style: TextStyle(
              color: Colors.teal, fontSize: 25, fontWeight: FontWeight.bold),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Search any student...",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.tune),
                  onPressed: () {
                    _showClassFilterDialog(context);
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredStudents.length,
              itemBuilder: (context, index) {
                final student = filteredStudents[index];
                return ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage('assets/face.png'),
                  ),
                  title: Text(
                    student['name']!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(student['class']!),
                  trailing:
                      const Icon(Icons.arrow_forward_ios_rounded, size: 18),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => StudentExamScreen(
                          studentName: student['name']!,
                          studentClass: student['class']!,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showClassFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Class'),
          content: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: allClasses.map((cls) {
              final isSelected = selectedClass == cls;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedClass = cls;
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.teal : Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.teal),
                  ),
                  child: Text(
                    cls,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class StudentExamScreen extends StatelessWidget {
  final String studentName;
  final String studentClass;

  StudentExamScreen({
    required this.studentName,
    required this.studentClass,
  });

  final List<Map<String, dynamic>> exams = [
    {
      'date': 'Mon 15',
      'subject': 'Math',
      'name': 'Midterm',
      'grade': '19/20',
      'missed': false
    },
    {
      'date': 'Mon 22',
      'subject': 'Science',
      'name': 'Final Exam',
      'missed': true
    },
    {
      'date': 'Mon 29',
      'subject': 'English',
      'name': 'Speaking Test',
      'grade': '17/20',
      'missed': false
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      appBar: AppBar(
        title: const Text(
          'Exams',
          style: TextStyle(
              color: Colors.teal, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xffcdc9cf),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 30),
          onPressed: () => Navigator.pop(context),
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
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/face.png'),
          ),
          const SizedBox(height: 10),
          Text(
            studentName,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(studentClass),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: exams.length,
              itemBuilder: (context, index) {
                final exam = exams[index];
                final isMissed = exam['missed'] ?? false;

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isMissed ? Colors.red.shade50 : Colors.white,
                    border: Border.all(
                      color: isMissed ? Colors.red : Colors.grey.shade300,
                      width: 1.3,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            exam['subject'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isMissed ? Colors.red : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            exam['date'],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        height: 40,
                        width: 1.5,
                        color: Colors.grey.shade400,
                      ),
                      Expanded(
                        child: Text(
                          exam['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      isMissed
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.red),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const Text(
                                "Missed",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.teal, width: 2),
                              ),
                              child: Text(
                                exam['grade'],
                                style: const TextStyle(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
