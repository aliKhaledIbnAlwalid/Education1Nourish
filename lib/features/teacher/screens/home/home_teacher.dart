import 'dart:async';
import 'package:edunourish/features/student/screens/home/exam_screen.dart';
import 'package:edunourish/features/teacher/screens/home/classes_screen.dart';
import 'package:edunourish/features/teacher/screens/home/notifiactions_screen.dart';
import 'package:edunourish/features/teacher/screens/home/students_screen.dart';
import 'package:edunourish/features/teacher/screens/list/Class_Schedule_screen.dart';
import 'package:edunourish/features/teacher/screens/list/exam_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class NewsPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final String details;

  const NewsPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(color: Colors.red),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff008f99),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              details,
              style: const TextStyle(
                color: Color(0xff008f99),
                fontSize: 16,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeTeacher extends StatefulWidget {
  const HomeTeacher({super.key});
  @override
  State<HomeTeacher> createState() => _HomeTeacherState();
}

class _HomeTeacherState extends State<HomeTeacher> {
  late final PageController _pageController =
      PageController(initialPage: _currentPage);
  late Timer _timer;
  bool hasNotifications =
      true; // Replace with your actual logic or shared state
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 9) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            hasNotifications
                ? Icons
                    .notifications_active_outlined // when there are notifications
                : Icons.notifications_none_outlined, // when there are none
            size: 30,
          ),
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NeoNotificationsTeacherScreen(),
              ),
            );
            // Optionally, refresh state after returning
            setState(() {
              // update `hasNotifications` based on actual source
            });
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
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xfff2f2f2),
                  Color(0xfff2f2f2),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 120, right: 20, left: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: const Color(0xff008f99),
                    ),
                    height: 250,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewsPage(
                                  title: 'News Item $index',
                                  subtitle: 'Subtitle for news item $index',
                                  imagePath:
                                      'assets/face.png', // update path if needed
                                  details:
                                      'This is the detailed content of news item number $index. It contains full text, explanation, and more info about this news article.',
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              width: 350,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                  )
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'News Item $index',
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SmoothPageIndicator(
                controller: _pageController,
                count: 10,
                effect: const ExpandingDotsEffect(
                  dotWidth: 8,
                  dotHeight: 8,
                  activeDotColor: Color(0xff008f99),
                  dotColor: Color(0xff969696),
                ),
                onDotClicked: (index) {
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      child: _buildFeatureCard(
                          "assets/student/Home_Student/exam.png", "Exams"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ExamTeacher (),
                          ),
                        );
                      },
                    ),
                    InkWell(
                      child: _buildFeatureCard(
                          "assets/student/Home_Student/training.png",
                          "Classes"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClassGridScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      child: _buildFeatureCard(
                          "assets/student/Home_Student/user.png", "Students"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StudentsScreen(),
                          ),
                        );
                      },
                    ),
                    InkWell(
                      child: _buildFeatureCard(
                          "assets/student/Home_Student/calendar_teacher.png",
                          "Schedule"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClassScheduleTeacher(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buildFeatureCard(String imagePath, String title) {
  return Container(
    width: 170,
    height: 170,
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xff008f99), width: 2),
      borderRadius: BorderRadius.circular(16),
      color: Colors.white,
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 6,
          offset: Offset(0, 4),
        )
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(imagePath, height: 100),
        Text(title,
            style: const TextStyle(
                color: Color(0xff008f99),
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ],
    ),
  );
}








































// the news without square container





// import 'dart:async';
// import 'package:edunourish/Teacher_Interface/BtmNavBar/Class_Schedule_teacher.dart';
// import 'package:edunourish/Teacher_Interface/Home/classes_teacher.dart';
// import 'package:edunourish/Teacher_Interface/Home/notifiactions_screen_teacher.dart';
// import 'package:edunourish/Teacher_Interface/Home/students_teacher.dart';
// import 'package:flutter/material.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:edunourish/Student_Interface/BtmNavBar/Exams_students.dart';

// class NewsPage extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final String imagePath;
//   final String details;

//   const NewsPage({
//     super.key,
//     required this.title,
//     required this.subtitle,
//     required this.imagePath,
//     required this.details,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//         backgroundColor: const Color(0xff98afb0),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(16),
//               child: Image.asset(
//                 imagePath,
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//                 height: 200,
//               ),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               subtitle,
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 12),
//             Text(
//               details,
//               style: const TextStyle(
//                 fontSize: 16,
//                 height: 1.6,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class HomeTeacher extends StatefulWidget {
//   const HomeTeacher({super.key});
//   @override
//   State<HomeTeacher> createState() => _HomeTeacherState();
// }

// class _HomeTeacherState extends State<HomeTeacher> {
//   late final PageController _pageController =
//       PageController(initialPage: _currentPage);
//   late Timer _timer;
//   int _currentPage = 0;

//   @override
//   void initState() {
//     super.initState();
//     _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
//       if (_currentPage < 9) {
//         _currentPage++;
//       } else {
//         _currentPage = 0;
//       }

//       _pageController.animateToPage(
//         _currentPage,
//         duration: const Duration(milliseconds: 500),
//         curve: Curves.easeInOut,
//       );
//     });
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       extendBody: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.notifications_none_outlined, size: 30),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => NeoNotificationsTeacherScreen(),
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
//       body: Stack(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Color(0xffcdc9cf),
//                   Color(0xffe8e6e9),
//                 ],
//               ),
//             ),
//           ),
//           Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 120, right: 20, left: 20),
//                 child: SizedBox(
//                   height: 250,
//                   child: PageView.builder(
//                     controller: _pageController,
//                     itemCount: 10,
//                     scrollDirection: Axis.horizontal,
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding: const EdgeInsets.all(10),
//                         child: Material(
//                           elevation: 8,
//                           color: Colors.white,
//                           shadowColor: Colors.black26,
//                           borderRadius: BorderRadius.circular(20),
//                           child: InkWell(
//                             borderRadius: BorderRadius.circular(20),
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => NewsPage(
//                                     title: 'News Item $index',
//                                     subtitle: 'Subtitle for news item $index',
//                                     imagePath: 'assets/face.png',
//                                     details:
//                                         'This is the detailed content of news item number $index. It contains full text, explanation, and more info about this news article.',
//                                   ),
//                                 ),
//                               );
//                             },
//                             child: Container(
//                               padding: const EdgeInsets.all(20),
//                               width: 350,
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   const Icon(Icons.article_outlined,
//                                       size: 50, color: Color(0xff98afb0)),
//                                   const SizedBox(height: 10),
//                                   Text(
//                                     'News Item $index',
//                                     style: const TextStyle(
//                                       fontSize: 20,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               SmoothPageIndicator(
//                 controller: _pageController,
//                 count: 10,
//                 effect: const ExpandingDotsEffect(
//                   dotWidth: 8,
//                   dotHeight: 8,
//                   activeDotColor: Color(0xff98afb0),
//                   dotColor: Colors.black26,
//                 ),
//                 onDotClicked: (index) {
//                   _pageController.animateToPage(
//                     index,
//                     duration: const Duration(milliseconds: 500),
//                     curve: Curves.easeInOut,
//                   );
//                 },
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   _buildFeatureCard(
//                     context,
//                     "assets/student/Home_Student/exam.png",
//                     "Exams",
//                     () => Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const ExamsStudents(),
//                       ),
//                     ),
//                   ),
//                   _buildFeatureCard(
//                     context,
//                     "assets/teacher/classes.png",
//                     "Classes",
//                     () => Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ClassGridScreen(),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   _buildFeatureCard(
//                     context,
//                     "assets/teacher/students.png",
//                     "Students",
//                     () => Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => StudentsScreen(),
//                       ),
//                     ),
//                   ),
//                   _buildFeatureCard(
//                     context,
//                     "assets/student/Home_Student/Calendar.png",
//                     "Schedule",
//                     () => Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ClassScheduleTeacher(),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// Widget _buildFeatureCard(
//   BuildContext context,
//   String imagePath,
//   String title,
//   VoidCallback onTap,
// ) {
//   return Material(
//     color: const Color(0xff98afb0),
//     borderRadius: BorderRadius.circular(30),
//     elevation: 6,
//     shadowColor: Colors.black26,
//     child: InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(30),
//       child: Container(
//         width: 170,
//         height: 170,
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(imagePath, height: 100),
//             const SizedBox(height: 10),
//             Text(
//               title,
//               style:
//                   const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
