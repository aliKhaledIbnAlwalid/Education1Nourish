
import 'package:edunourish/features/Parent/core/widgets/base_scaffold.dart';
import 'package:edunourish/features/Parent/features/Classes/presentation/views/widgets/header_title.dart';
import 'package:flutter/material.dart';

class ClassesScreenBody extends StatelessWidget {
  const ClassesScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> subjects = [
      "Math",
      "Science",
      "English",
      "Arabic",
      "ICT",
      "PE"
    ];

    return BaseScaffold(
      appBartTitle: "Classes",
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              // Search Box
              const SearchBar(),
              const SizedBox(height: 30),
              
              const Text(
                "class schedule",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              classSchedule(),
              const SizedBox(height: 16),
              // Bus Schedules Section
              const Text(
                "Bus schedules",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              arrivalInformation(),
            ],
          ),
        ),
      ),
    );
  }

  Container arrivalInformation() {
    return Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha:  0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(children: [
                // First row - Departure and Arrival Times
                Row(
                  children: [
                    // Departure Time
                    const Expanded(
                      child: Column(
                        children: [
                          Icon(Icons.departure_board,
                              color: Color(0xFF1976D2), size: 28),
                          SizedBox(height: 8),
                          Text(
                            'Departure time',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF757575),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '08:30 AM',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1976D2),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Divider
                    Container(
                      height: 70,
                      width: 1,
                      color: const Color(0xFFE0E0E0),
                    ),

                    // Arrival Time
                    const Expanded(
                      child: Column(
                        children: [
                          Icon(Icons.access_time_filled,
                              color: Color(0xFF43A047), size: 28),
                          SizedBox(height: 8),
                          Text(
                            'Arrival time',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF757575),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '01:15 PM',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF43A047),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
            );
  }

  SingleChildScrollView classSchedule() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: DataTable(
          border: TableBorder.all(color: Colors.black),
          columnSpacing: 16.0,
          horizontalMargin: 15.0,
          headingRowHeight: 40.0,
          dataRowMaxHeight: 40.0,
          dataRowMinHeight: 40.0,
          columns: const [
            DataColumn(label: Text("Time", style: TextStyle(fontSize: 16))),
            DataColumn(label: Text("SUN", style: TextStyle(fontSize: 16))),
            DataColumn(label: Text("MON", style: TextStyle(fontSize: 16))),
            DataColumn(label: Text("TUE", style: TextStyle(fontSize: 16))),
            DataColumn(label: Text("WED", style: TextStyle(fontSize: 16))),
            DataColumn(label: Text("THU", style: TextStyle(fontSize: 16))),
          ],
          rows: [
            DataRow(
                cells: _buildCellsWithTime("08:00 - 08:45",
                    ["math", "english", "arabic", "RE", "PE"])),
            DataRow(
                cells: _buildCellsWithTime("08:50 - 09:35",
                    ["science", "math", "english", "arabic", "ICT"])),
            DataRow(
                cells: _buildCellsWithTime("09:40 - 10:25",
                    ["ICT", "science", "math", "english", "arabic"])),
            DataRow(
                cells: _buildCellsWithTime("10:30 - 11:15",
                    ["PE", "ICT", "science", "math", "english"])),
            DataRow(
                cells: _buildCellsWithTime("11:15 - 11:45",
                    ["break", "break", "break", "break", "break"])),
            DataRow(
                cells: _buildCellsWithTime("11:50 - 12:35",
                    ["science", "math", "english", "ICT", "PE"])),
            DataRow(
                cells: _buildCellsWithTime("12:40 - 13:25",
                    ["math", "english", "science", "arabic", "PE"])),
          ],
        ),
      ),
    );
  }

// Helper method that includes time cell
  List<DataCell> _buildCellsWithTime(String time, List<String> subjects) {
    List<DataCell> cells = [];
    cells.add(DataCell(Text(time, style: const TextStyle(fontSize: 14))));
    cells.addAll(_buildCellsSmall(subjects));
    return cells;
  }

  Widget _buildSubjectContainer(String subject) {
    // Define subject-specific colors and images
    final Map<String, Color> subjectColors = {
      'Arabic': Colors.purple,
      'English': Colors.green,
      'ICT': Colors.amber,
      'Science': Colors.brown,
      'Math': Colors.lime,
      'PE': Colors.pink,
      // Add more subjects as needed
    };

    // Default color if subject not in map
    final Color backgroundColor = subjectColors[subject] ?? Colors.white;

    // Get subject icon based on name
    IconData subjectIcon = _getSubjectIcon(subject);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        height: 120,
        width: 160,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues( alpha: 0.8),
                shape: BoxShape.circle,
              ),
              child: Icon(
                subjectIcon,
                size: 40,
               
              ),
            ),
            const SizedBox(height: 12),
            Text(
              subject,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                // color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

// Helper function to get appropriate icon for each subject
  IconData _getSubjectIcon(String subject) {
  switch (subject) {
    case 'Math':
      return Icons.calculate;
    case 'Science':
      return Icons.science;
    case 'English':
      return Icons.menu_book;
    case 'Arabic':
      return Icons.translate;
    case 'ICT':
      return Icons.computer;
    case 'PE':
      return Icons.sports_basketball;
    default:
      return Icons.school;
  }
}

// Usage example
  Widget buildSubjectsRow(List<String> subjects) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16, bottom: 12),
            child: Text(
              "Subject Categories",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          SizedBox(
            height: 140,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: subjects.map(_buildSubjectContainer).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DataCell> _buildCellsSmall(List<String> cells) {
    return cells.map((cell) {
      return DataCell(
        Text(
          cell,
          style: const TextStyle(fontSize: 15),
        ),
      );
    }).toList();
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Row(
        children: [
          Icon(Icons.menu, color: Colors.black),
          SizedBox(width: 16),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Hinted search text",
                border: InputBorder.none,
              ),
            ),
          ),
          Icon(Icons.search, color: Colors.black),
        ],
      ),
    );
  }
}
