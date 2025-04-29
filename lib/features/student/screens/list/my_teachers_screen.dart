import 'package:edunourish/core/models/teacher_model.dart';
import 'package:edunourish/features/student/providers/student_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeachersListScreen extends StatefulWidget {
  const TeachersListScreen({Key? key}) : super(key: key);
  @override
  _TeachersListScreenState createState() => _TeachersListScreenState();
}

class _TeachersListScreenState extends State<TeachersListScreen> {
  String _search = '';

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<StudentProvider>();
    final teachers = prov.teachers;
    if (teachers.isEmpty) {
      return const Center(child: Text('No exams scheduled.'));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Teachers'),
        leading: BackButton(onPressed: () => Navigator.pop(context)),
      ),
      body: prov.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (v) => setState(() => _search = v.toLowerCase()),
                  ),
                ),
                Expanded(child: _buildList(prov.teachers)),
              ],
            ),
    );
  }

  Widget _buildList(List<Teacher> allTeachers) {
    if (allTeachers.isEmpty) {
      return const Center(child: Text('No teachers found.'));
    }

    final filtered = allTeachers
        .where((t) =>
            t.username.toLowerCase().contains(_search) ||
            t.subject.toLowerCase().contains(_search))
        .toList();

    if (filtered.isEmpty) {
      return const Center(child: Text('No match found.'));
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: filtered.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (ctx, i) {
        final t = filtered[i];
        return InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.blue.shade100),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: (t.avatarUrl.isNotEmpty)
                      ? NetworkImage(t.avatarUrl)
                      : null,
                  child: t.avatarUrl.isEmpty ? const Icon(Icons.person) : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.username,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        t.subject,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
