import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// --- Models ---
/// Represents attendance status for a given day
enum AttendanceStatus { present, absent, holiday, today }

/// Single attendance record
class AttendanceRecord {
  final DateTime date;
  final AttendanceStatus status;

  AttendanceRecord({required this.date, required this.status});

  /// Parse from JSON from your database/API
  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    final date = DateTime.parse(json['date'] as String);
    final s = json['status'] as String;
    AttendanceStatus status;
    switch (s) {
      case 'present':
        status = AttendanceStatus.present;
        break;
      case 'absent':
        status = AttendanceStatus.absent;
        break;
      case 'holiday':
        status = AttendanceStatus.holiday;
        break;
      default:
        status = AttendanceStatus.present;
    }
    return AttendanceRecord(date: date, status: status);
  }
}

/// Provider that holds attendance data
class AttendanceProvider extends ChangeNotifier {
  List<AttendanceRecord> _records = [];
  int currentMonth = DateTime.now().month;
  int currentYear = DateTime.now().year;

  List<AttendanceRecord> get records => _records;

  /// Load from API
  Future<void> loadRecords() async {
    // TODO: fetch JSON list and parse
    // _records = fetchedJson.map((j) => AttendanceRecord.fromJson(j)).toList();
    _records = [];
    notifyListeners();
  }

  void prevMonth() {
    if (currentMonth == 1) {
      currentMonth = 12;
      currentYear--;
    } else {
      currentMonth--;
    }
    notifyListeners();
  }

  void nextMonth() {
    if (currentMonth == 12) {
      currentMonth = 1;
      currentYear++;
    } else {
      currentMonth++;
    }
    notifyListeners();
  }

  /// Filter records in current month
  List<AttendanceRecord> get monthRecords {
    return _records
        .where(
            (r) => r.date.month == currentMonth && r.date.year == currentYear)
        .toList();
  }

  int get totalSchoolDays => monthRecords.length;
  int get totalPresent =>
      monthRecords.where((r) => r.status == AttendanceStatus.present).length;
  int get totalAbsent =>
      monthRecords.where((r) => r.status == AttendanceStatus.absent).length;
}

/// --- UI ---
class CalendarScreen extends StatelessWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AttendanceProvider()..loadRecords(),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title:
                  const Text('Calendar', style: TextStyle(color: Colors.black)),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, size: 30),
                onPressed: () {
                  Navigator.pop(context);
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
            body: const _AttendanceTab()),
      ),
    );
  }
}

class _AttendanceTab extends StatelessWidget {
  const _AttendanceTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<AttendanceProvider>();
    final monthName =
        DateTime(prov.currentYear, prov.currentMonth).toLocal().month;
    return Column(
      children: [
        const SizedBox(height: 16),
        // Month navigator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 50, vertical: 2.5),
              decoration: BoxDecoration(
                color: const Color(0xff008f99),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back,
                        color: Color.fromARGB(255, 255, 255, 255)),
                    onPressed: prov.prevMonth,
                  ),
                  const SizedBox(width: 20),
                  Text(
                    '${_monthString(prov.currentMonth)} ${prov.currentYear}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward,
                        color: Color.fromARGB(255, 255, 255, 255)),
                    onPressed: prov.nextMonth,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Calendar grid
        Expanded(child: _CalendarGrid()),
        const SizedBox(height: 8),
        // Legend
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _legendTile(Colors.transparent, 'Today'),
              _legendTile(Colors.red, 'Absent'),
              _legendTile(Colors.grey, 'Holidays'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Stats cards
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              _statCard('Total School Days', prov.totalSchoolDays, Colors.teal),
              const SizedBox(height: 8),
              _statCard('Total Present', prov.totalPresent, Colors.green),
              const SizedBox(height: 8),
              _statCard('Total Absent', prov.totalAbsent, Colors.red),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  static String _monthString(int m) {
    const names = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return names[m - 1];
  }

  Widget _legendTile(Color color, String label) {
    return Row(
      children: [
        Container(
            width: 16,
            height: 16,
            color: color,
            margin: const EdgeInsets.only(right: 4)),
        Text(label),
      ],
    );
  }

  Widget _statCard(String title, int count, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$title: $count',
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}

class _CalendarGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prov = context.watch<AttendanceProvider>();
    final year = prov.currentYear;
    final month = prov.currentMonth;
    final first = DateTime(year, month, 1);
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final startWeekday = first.weekday % 7; // Sunday=0

    List<Widget> tiles = [];
    // Weekday headers
    const days = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
    for (final d in days) {
      tiles.add(Center(
          child: Text(d, style: const TextStyle(fontWeight: FontWeight.bold))));
    }
    // Empty slots
    for (int i = 0; i < startWeekday; i++) tiles.add(const SizedBox());
    // Day cells
    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(year, month, day);
      final record = prov.records.firstWhere(
        (r) =>
            r.date.year == year && r.date.month == month && r.date.day == day,
        orElse: () =>
            AttendanceRecord(date: date, status: AttendanceStatus.present),
      );
      Color bg;
      switch (record.status) {
        case AttendanceStatus.today:
          bg = Colors.red;
          break;
        case AttendanceStatus.absent:
          bg = Colors.red;
          break;
        case AttendanceStatus.holiday:
          bg = Colors.grey;
          break;
        default:
          bg = Colors.transparent;
      }
      tiles.add(
        Stack(
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(day.toString()),
            ),
            if (DateTime.now().day == day && DateTime.now().month == month)
              Positioned(
                bottom: 4,
                right: 4,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                ),
              ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color:  Color(0xff008f99)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: GridView.count(
        crossAxisCount: 7,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: tiles,
      ),
    );
  }
}
























/// Hamdy Code !!

// import 'package:flutter/material.dart';

// class Attendance extends StatelessWidget {
//   const Attendance({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//      backgroundColor: const Color(0xfff2f2f2),
//       appBar: AppBar(
//         title: const Text(
//           'Attendance',
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color.fromARGB(255, 255, 255, 255),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, size: 30),
//           onPressed: () {
//             Navigator.pop(
//               context,
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
//       body:  const AttendenceScreenBody(),
//     );
//   }
// }

// class AttendenceScreenBody extends StatefulWidget {
//   const AttendenceScreenBody({super.key});

//   @override
//   State<AttendenceScreenBody> createState() => _AttendenceScreenBodyState();
// }

// class _AttendenceScreenBodyState extends State<AttendenceScreenBody> {
//   DateTime selectedDate = DateTime.now();
//   DateTime currentMonth = DateTime.now();
//   List<String> daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//   int selectedDay = DateTime.now().day;
//   bool isCame = true;

//   @override
//   Widget build(BuildContext context) {
//     double commonWidth = MediaQuery.of(context).size.width - 20;

//     return
//         SingleChildScrollView(
//           physics: const ClampingScrollPhysics(),
//           child: Column(
//             children: [
//               switchDaysSection(),
//               const SizedBox(height: 8),
//               Container(
//                 width: commonWidth,
//                 margin: const EdgeInsets.symmetric(horizontal: 16),
//                 decoration: BoxDecoration(
//                   color: const Color(0xfffcfbfb),
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Color(0xFF008F99),
//                       spreadRadius: 3,
//                       blurRadius: 1,

//                     ),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(12),
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(bottom: 12.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: daysOfWeek.map((day) {
//                             return Container(
//                               width: 28,
//                               alignment: Alignment.center,
//                               child: Text(
//                                 day,
//                                 style: TextStyle(
//                                   fontSize: 13,
//                                   fontWeight: FontWeight.bold,
//                                   color: (day == 'Sat' || day == 'Sun')
//                                       ? const Color.fromARGB(255, 0, 0, 0)
//                                       : const Color.fromARGB(255, 0, 0, 0),
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                       buildCalendarDays(),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 30),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 16.0),
//                 child: moodContainer(commonWidth),
//               ),
//             ],
//           ),
//         );
//   }

//   Padding switchDaysSection() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
//         decoration: BoxDecoration(
//           color: const Color(0xFF008F99),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             InkWell(
//               onTap: () {
//                 setState(() {
//                   currentMonth =
//                       DateTime(currentMonth.year, currentMonth.month - 1);
//                   selectedDay = -1;
//                 });
//               },
//               child: Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: const Color(0xfff2f2f2),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: const Icon(
//                   Icons.arrow_back_ios_rounded,
//                   color: Color(0xFF008F99),
//                   size: 18,
//                 ),
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   colors: [Color(0xfff2f2f2),Color(0xfff2f2f2),],
//                   begin: Alignment.centerLeft,
//                   end: Alignment.centerRight,
//                 ),
//                 borderRadius: BorderRadius.circular(18),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const Icon(Icons.calendar_today_rounded,
//                       color:Color(0xFF008F99), size: 18),
//                   const SizedBox(width: 8),
//                   Text(
//                     '${_getMonthName(currentMonth.month)} ${currentMonth.year}',
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color:Color(0xFF008F99),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 setState(() {
//                   currentMonth =
//                       DateTime(currentMonth.year, currentMonth.month + 1);
//                   selectedDay = -1;
//                 });
//               },
//               child: Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: const Color(0xfff2f2f2),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: const Icon(
//                   Icons.arrow_forward_ios_rounded,
//                   color: Color(0xFF008F99),
//                   size: 18,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Container moodContainer(double commonWidth) {
//     return Container(
//       width: commonWidth,
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//       decoration: BoxDecoration(
//         color: const Color(0xfff2f2f2),
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: const [
//           BoxShadow(
//             color: Color(0xFF008F99),
//             spreadRadius: 3,
//             blurRadius: 1,

//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//             decoration: BoxDecoration(
//               color: const Color.fromARGB(255, 255, 255, 255),
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: Text(
//               selectedDay > 0
//                   ? '$selectedDay ${_getMonthName(currentMonth.month)} ${currentMonth.year}'
//                   : 'Select a date',
//               style: const TextStyle(
//                 color:const Color(0xFF008F99),
//                 fontWeight: FontWeight.w600,
//                 fontSize: 16,
//               ),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Container(
//             padding: const EdgeInsets.all(16),
//             // decoration: BoxDecoration(
//             //   color: isCame ?  const Color(0xfff2f2f2): const Color.fromARGB(255, 255, 0, 0),
//             //   shape: BoxShape.circle,
//             //   boxShadow: [
//             //     BoxShadow(
//             //       color: (isCame ?  const Color(0xFF008F99) : Colors.red),
//             //       spreadRadius: 5,
//             //       blurRadius: 15,
//             //       offset: const Offset(0, 5),
//             //     ),
//             //   ],
//             // ),
//             child: Text(
//               isCame ? '😀' : '😔',
//               style: const TextStyle(fontSize: 80),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//             decoration: BoxDecoration(
//            color:Color.fromARGB(255, 255, 255, 255),
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: Text(
//               isCame ? 'Present' : 'Absent',
//               style: const TextStyle(
//                  color:Color(0xFF008F99),
//                 fontWeight: FontWeight.w600,
//                 fontSize: 16,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildCalendarDays() {
//     DateTime firstDay = DateTime(currentMonth.year, currentMonth.month, 1);
//     int firstDayOfWeek = firstDay.weekday;
//     int daysInMonth =
//         DateTime(currentMonth.year, currentMonth.month + 1, 0).day;

//     List<Widget> dayWidgets = [];

//     for (int i = 1; i < firstDayOfWeek; i++) {
//       dayWidgets.add(buildDayContainer(''));
//     }

//     for (int day = 1; day <= daysInMonth; day++) {
//       bool isToday = DateTime.now().day == day &&
//           DateTime.now().month == currentMonth.month &&
//           DateTime.now().year == currentMonth.year;
//       bool isSelected = day == selectedDay &&
//           currentMonth.month == selectedDate.month &&
//           currentMonth.year == selectedDate.year;

//       dayWidgets.add(
//         buildDayContainer(
//           day.toString(),
//           isSelected: isSelected,
//           isToday: isToday,
//           onTap: () {
//             setState(() {
//               selectedDay = day;
//               selectedDate =
//                   DateTime(currentMonth.year, currentMonth.month, day);
//             });
//           },
//         ),
//       );
//     }

//     List<Widget> rows = [];
//     for (int i = 0; i < dayWidgets.length; i += 7) {
//       int endIndex = i + 7;
//       endIndex = endIndex > dayWidgets.length ? dayWidgets.length : endIndex;
//       List<Widget> rowChildren = dayWidgets.sublist(i, endIndex);
//       while (rowChildren.length < 7) {
//         rowChildren.add(buildDayContainer(''));
//       }
//       rows.add(
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: rowChildren,
//         ),
//       );
//     }

//     return Column(
//       children: rows
//           .map(
//             (row) => Padding(
//               padding: const EdgeInsets.only(bottom: 12.0),
//               child: row,
//             ),
//           )
//           .toList(),
//     );
//   }

//   Widget buildDayContainer(String text,
//       {bool isSelected = false, bool isToday = false, VoidCallback? onTap}) {
//     return GestureDetector(
//       onTap: text.isEmpty ? null : onTap,
//       child: Container(
//         width: 28,
//         height: 28,
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           color: isSelected
//               ? const Color(0xFF008F99).withOpacity(0.6)
//               : isToday
//                   ? const Color(0xFFF0EDFF)
//                   : const Color.fromARGB(0, 255, 255, 255),
//           shape: BoxShape.circle,
//           border: isToday && !isSelected
//               ? Border.all(color: const Color(0xFF7B5EF8), width: 1.5)
//               : null,
//           boxShadow: isSelected
//               ? [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.5),
//                     spreadRadius: 1,
//                     blurRadius: 4,
//                     offset: const Offset(0, 2),
//                   )
//                 ]
//               : null,
//         ),
//         child: Text(
//           text,
//           style: TextStyle(
//             color: isSelected
//                 ? const Color.fromARGB(255, 255, 255, 255)
//                 : isToday
//                     ? const Color.fromARGB(255, 15, 15, 15)
//                     : (text.isEmpty ? Colors.transparent : Colors.black87),
//             fontWeight:
//                 isSelected || isToday ? FontWeight.bold : FontWeight.normal,
//             fontSize: 12,
//           ),
//         ),
//       ),
//     );
//   }

//   String _getMonthName(int month) {
//     const monthNames = [
//       'January',
//       'February',
//       'March',
//       'April',
//       'May',
//       'June',
//       'July',
//       'August',
//       'September',
//       'October',
//       'November',
//       'December'
//     ];
//     return monthNames[month - 1];
//   }
// }