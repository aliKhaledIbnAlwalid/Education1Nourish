import 'package:flutter/material.dart';

class Attendance extends StatelessWidget {
  const Attendance({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: const Color(0xfff2f2f2),
      appBar: AppBar(
        title: const Text(
          'Attendance',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
      body:  const AttendenceScreenBody(),
    );
  }
}

class AttendenceScreenBody extends StatefulWidget {
  const AttendenceScreenBody({super.key});

  @override
  State<AttendenceScreenBody> createState() => _AttendenceScreenBodyState();
}

class _AttendenceScreenBodyState extends State<AttendenceScreenBody> {
  DateTime selectedDate = DateTime.now();
  DateTime currentMonth = DateTime.now();
  List<String> daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  int selectedDay = DateTime.now().day;
  bool isCame = true;

  @override
  Widget build(BuildContext context) {
    double commonWidth = MediaQuery.of(context).size.width - 20;

    return 
        SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              switchDaysSection(),
              const SizedBox(height: 8),
              Container(
                width: commonWidth,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xfffcfbfb),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFF008F99),
                      spreadRadius: 3,
                      blurRadius: 1,
                     
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: daysOfWeek.map((day) {
                            return Container(
                              width: 28,
                              alignment: Alignment.center,
                              child: Text(
                                day,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: (day == 'Sat' || day == 'Sun')
                                      ? const Color.fromARGB(255, 0, 0, 0)
                                      : const Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      buildCalendarDays(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: moodContainer(commonWidth),
              ),
            ],
          ),
        );
  }

  Padding switchDaysSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: const Color(0xFF008F99),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  currentMonth =
                      DateTime(currentMonth.year, currentMonth.month - 1);
                  selectedDay = -1;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xfff2f2f2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Color(0xFF008F99),
                  size: 18,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xfff2f2f2),Color(0xfff2f2f2),],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.calendar_today_rounded,
                      color:Color(0xFF008F99), size: 18),
                  const SizedBox(width: 8),
                  Text(
                    '${_getMonthName(currentMonth.month)} ${currentMonth.year}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color:Color(0xFF008F99),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  currentMonth =
                      DateTime(currentMonth.year, currentMonth.month + 1);
                  selectedDay = -1;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xfff2f2f2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color(0xFF008F99),
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Container moodContainer(double commonWidth) {
    return Container(
      width: commonWidth,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xfff2f2f2),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFF008F99),
            spreadRadius: 3,
            blurRadius: 1,
           
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              selectedDay > 0
                  ? '$selectedDay ${_getMonthName(currentMonth.month)} ${currentMonth.year}'
                  : 'Select a date',
              style: const TextStyle(
                color:const Color(0xFF008F99),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            // decoration: BoxDecoration(
            //   color: isCame ?  const Color(0xfff2f2f2): const Color.fromARGB(255, 255, 0, 0),
            //   shape: BoxShape.circle,
            //   boxShadow: [
            //     BoxShadow(
            //       color: (isCame ?  const Color(0xFF008F99) : Colors.red),
            //       spreadRadius: 5,
            //       blurRadius: 15,
            //       offset: const Offset(0, 5),
            //     ),
            //   ],
            // ),
            child: Text(
              isCame ? '😀' : '😔',
              style: const TextStyle(fontSize: 80),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
           color:Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              isCame ? 'Present' : 'Absent',
              style: const TextStyle(
                 color:Color(0xFF008F99),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCalendarDays() {
    DateTime firstDay = DateTime(currentMonth.year, currentMonth.month, 1);
    int firstDayOfWeek = firstDay.weekday;
    int daysInMonth =
        DateTime(currentMonth.year, currentMonth.month + 1, 0).day;

    List<Widget> dayWidgets = [];

    for (int i = 1; i < firstDayOfWeek; i++) {
      dayWidgets.add(buildDayContainer(''));
    }

    for (int day = 1; day <= daysInMonth; day++) {
      bool isToday = DateTime.now().day == day &&
          DateTime.now().month == currentMonth.month &&
          DateTime.now().year == currentMonth.year;
      bool isSelected = day == selectedDay &&
          currentMonth.month == selectedDate.month &&
          currentMonth.year == selectedDate.year;

      dayWidgets.add(
        buildDayContainer(
          day.toString(),
          isSelected: isSelected,
          isToday: isToday,
          onTap: () {
            setState(() {
              selectedDay = day;
              selectedDate =
                  DateTime(currentMonth.year, currentMonth.month, day);
            });
          },
        ),
      );
    }

    List<Widget> rows = [];
    for (int i = 0; i < dayWidgets.length; i += 7) {
      int endIndex = i + 7;
      endIndex = endIndex > dayWidgets.length ? dayWidgets.length : endIndex;
      List<Widget> rowChildren = dayWidgets.sublist(i, endIndex);
      while (rowChildren.length < 7) {
        rowChildren.add(buildDayContainer(''));
      }
      rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: rowChildren,
        ),
      );
    }

    return Column(
      children: rows
          .map(
            (row) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: row,
            ),
          )
          .toList(),
    );
  }

  Widget buildDayContainer(String text,
      {bool isSelected = false, bool isToday = false, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: text.isEmpty ? null : onTap,
      child: Container(
        width: 28,
        height: 28,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF008F99).withOpacity(0.6)
              : isToday
                  ? const Color(0xFFF0EDFF)
                  : const Color.fromARGB(0, 255, 255, 255),
          shape: BoxShape.circle,
          border: isToday && !isSelected
              ? Border.all(color: const Color(0xFF7B5EF8), width: 1.5)
              : null,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ]
              : null,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected
                ? const Color.fromARGB(255, 255, 255, 255)
                : isToday
                    ? const Color.fromARGB(255, 15, 15, 15)
                    : (text.isEmpty ? Colors.transparent : Colors.black87),
            fontWeight:
                isSelected || isToday ? FontWeight.bold : FontWeight.normal,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const monthNames = [
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
    return monthNames[month - 1];
  }
}
