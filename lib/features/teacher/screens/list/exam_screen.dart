import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class ExamTeacher extends StatelessWidget {
  const ExamTeacher({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Exam type',
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ExamOptionCard(
              label: 'Quiz',
              icon: Icons.quiz,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ExamUploadScreen(examType: 'Quiz'),
                  ),
                );
              },
            ),
            const SizedBox(height: 80),
            ExamOptionCard(
              label: 'Final Exam',
              icon: Icons.assignment,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const ExamUploadScreen(examType: 'Final Exam'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ExamOptionCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const ExamOptionCard({
    required this.label,
    required this.icon,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(50),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.teal, width: 2),
          borderRadius: BorderRadius.circular(16),
          color: Colors.teal.shade50,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 80, color: Colors.teal),
            const SizedBox(width: 16),
            Text(
              label,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

class ExamUploadScreen extends StatefulWidget {
  final String examType;

  const ExamUploadScreen({required this.examType, super.key});

  @override
  State<ExamUploadScreen> createState() => _ExamUploadScreenState();
}

class _ExamUploadScreenState extends State<ExamUploadScreen> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController examNameController = TextEditingController();

  String? modelAnswerPath;
  String? studentAnswerPath;

  Future<void> pickFile(bool isModelAnswer) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        if (isModelAnswer) {
          modelAnswerPath = result.files.first.path;
        } else {
          studentAnswerPath = result.files.first.path;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.examType} Upload"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: examNameController,
              decoration: const InputDecoration(
                labelText: "Exam Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: dateController,
              decoration: const InputDecoration(
                labelText: "Appointment Date",
                border: OutlineInputBorder(),
              ),
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now().subtract(const Duration(days: 365)),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  initialDate: DateTime.now(),
                );
                if (picked != null) {
                  dateController.text =
                      picked.toLocal().toString().split(' ')[0];
                }
              },
              readOnly: true,
            ),
            const SizedBox(height: 24),
            const Text("Upload Model Answer",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            UploadBox(
              onTap: () => pickFile(true),
              fileName: modelAnswerPath != null
                  ? modelAnswerPath!.split("/").last
                  : null,
            ),
            const SizedBox(height: 24),
            const Text("Upload Student Answer",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            UploadBox(
              onTap: () => pickFile(false),
              fileName: studentAnswerPath != null
                  ? studentAnswerPath!.split("/").last
                  : null,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {

              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(14),
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text("Submit", style: TextStyle(fontSize: 16)),
            )
          ],
        ),
      ),
    );
  }
}

class UploadBox extends StatelessWidget {
  final VoidCallback onTap;
  final String? fileName;

  const UploadBox({required this.onTap, this.fileName, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        dashPattern: const [8, 4],
        color: Colors.teal,
        child: Container(
          height: 200,
          width: double.infinity,
          alignment: Alignment.center,
          child: fileName != null
              ? Text(fileName!, style: const TextStyle(fontSize: 16))
              : const Icon(Icons.upload_file, color: Colors.teal, size: 40),
        ),
      ),
    );
  }
}
