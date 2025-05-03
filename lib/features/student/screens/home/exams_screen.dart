import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:edunourish/features/student/providers/student_provider.dart';
import 'package:edunourish/core/models/exam.dart';

class ExamsScreen extends StatefulWidget {
  const ExamsScreen({Key? key}) : super(key: key);

  @override
  State<ExamsScreen> createState() => _ExamsScreenState();
}

class _ExamsScreenState extends State<ExamsScreen> {
  String? selectedType;
  String? selectedSubject;

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<StudentProvider>();

    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      appBar: AppBar(
        title: const Text(
          'Exam Schedule',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 30, color: Colors.black),
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
      body: prov.isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildBody(prov.exams),
    );
  }

  Widget _buildBody(List<Exam> exams) {
    // distinct types & subjects
    final types = exams.map((e) => e.type).toSet().toList();
    final subjects = exams.map((e) => e.subjectName).toSet().toList();

    // apply filters
    final filtered = exams.where((e) {
      final okType = selectedType == null || e.type == selectedType;
      final okSubj =
          selectedSubject == null || e.subjectName == selectedSubject;
      return okType && okSubj;
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              // Exam Type filter
              Expanded(
                child: _decoratedDropdown(
                  label: 'Exam Type',
                  hint: 'All',
                  value: selectedType,
                  items: types,
                  onChanged: (v) => setState(() => selectedType = v),
                ),
              ),
              const SizedBox(width: 16),
              // Subject Name filter
              Expanded(
                child: _decoratedDropdown(
                  label: 'Subject',
                  hint: 'All',
                  value: selectedSubject,
                  items: subjects,
                  onChanged: (v) => setState(() => selectedSubject = v),
                ),
              ),
            ],
          ),
        ),

        // No exams message
        if (filtered.isEmpty)
          const Expanded(
            child: Center(
              child: Text(
                'No exams exist',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          )
        else
          // Exam list
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) => _buildExamCard(filtered[i]),
            ),
          ),
      ],
    );
  }

  Widget _decoratedDropdown({
    required String label,
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xfff2f2f2),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff008f99).withOpacity(0.5),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
        ),
        isExpanded: true,
        value: value,
        hint: Text(hint),
        items: [
          DropdownMenuItem(value: null, child: Text(hint)),
          ...items.map((it) => DropdownMenuItem(value: it, child: Text(it))),
        ],
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildExamCard(Exam e) {
    final color = _colorForExamType(e.type);
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: color.withOpacity(0.2),
              child: Icon(_subjectIcon(e.subjectName), size: 28, color: color),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e.subjectName,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.calendar_today,
                          size: 14, color: Colors.grey.shade600),
                      const SizedBox(width: 2),
                      Text(_fmtDate(e.date),
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade700)),
                      const SizedBox(width: 8),
                      Icon(Icons.access_time,
                          size: 14, color: Colors.grey.shade600),
                      const SizedBox(width: 6),
                      Text(_fmtTime(e.date),
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade700)),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                e.type,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _colorForExamType(String type) {
    switch (type.toLowerCase()) {
      case 'midterm':
        return const Color(0xff008f99);
      case 'final':
        return const Color(0xff008f99);
      case 'quiz':
        return const Color(0xff008f99);
      default:
        return const Color(0xff008f99);
    }
  }

  IconData _subjectIcon(String s) {
    switch (s.toLowerCase()) {
      case 'math exam':
        return Icons.calculate;
      case 'arabic':
        return Icons.language;
      case 'science':
        return Icons.science;
      case 'english':
        return Icons.book;
      default:
        return Icons.help_outline;
    }
  }

  String _fmtDate(DateTime dt) => DateFormat('MMM d, yyyy').format(dt);

  String _fmtTime(DateTime dt) => DateFormat('h:mm a').format(dt);
}
