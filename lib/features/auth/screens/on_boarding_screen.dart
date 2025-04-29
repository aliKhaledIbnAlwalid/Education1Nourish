import 'package:concentric_transition/page_view.dart';
import 'package:edunourish/features/auth/screens/choice_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  static const routeName = '/onboarding';
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;
  static const _teal = Color(0xff008f99);

  final _data = [
    ItemData(
      title: "SMART EDUCATION",
      subtitle: "Connect, learn, and grow with innovative education solutions.",
      image: const AssetImage("assets/Intro_Screen_login/image-1.png"),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      titleColor: const Color(0xff1f1f1f),
      subtitleColor: const Color(0xff1f1f1f),
      lottieUrl: 'https://assets2.lottiefiles.com/packages/lf20_bq485nmk.json',
    ),
    ItemData(
      title: "BEST TEACHERS",
      subtitle: "Experience quality education from top teachers.",
      image: const AssetImage("assets/Intro_Screen_login/image-2.png"),
      backgroundColor: Colors.white,
      titleColor: const Color(0xff1f1f1f),
      subtitleColor: const Color(0xff1f1f1f),
      lottieUrl: 'https://assets2.lottiefiles.com/packages/lf20_bq485nmk.json',
    ),
    ItemData(
      title: "SMART STUDENTS",
      subtitle: "A smarter way for students to reach new heights.",
      image: const AssetImage("assets/Intro_Screen_login/image-3.png"),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      titleColor: const Color(0xff1f1f1f),
      subtitleColor: const Color(0xff1f1f1f),
      lottieUrl: 'https://assets2.lottiefiles.com/packages/lf20_bq485nmk.json',
    ),
    ItemData(
      title: "MODERN EDUCATION",
      subtitle: "Where creativity and technology drive learning.",
      image: const AssetImage("assets/Intro_Screen_login/image-4.png"),
      backgroundColor: Colors.white,
      titleColor: const Color(0xff1f1f1f),
      subtitleColor: const Color(0xff1f1f1f),
      lottieUrl: 'https://assets2.lottiefiles.com/packages/lf20_bq485nmk.json',
    ),
  ];
  @override
  void dispose() {
    super.dispose();
    try {
      _pageController.dispose();
    } catch (e) {
      // already disposed, ignore
    }
  }

  void _goNext() {
    if (_currentPage < _data.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else {
      _finish();
    }
  }

  void _goPrevious() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  Future<void> _finish() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('showHome', true);
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ChoiceScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        ConcentricPageView(
          pageController: _pageController,
          onChange: (i) => setState(() => _currentPage = i),
          onFinish: _finish,
          colors: _data.map((e) => e.backgroundColor).toList(),
          itemCount: _data.length,
          itemBuilder: (i) => ItemWidget(
            data: _data[i],
            isLastPage: i == _data.length - 1,
            onGetStarted: _finish,
          ),
        ),

        // bottom row: Previous + Next
        Positioned(
          left: 16,
          right: 16,
          bottom: 32,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Previous: outline
              if (_currentPage > 0)
                InkWell(
                  onTap: _goPrevious,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: _teal, width: 1.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Previous',
                      style: TextStyle(
                        color: _teal,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              else
                const SizedBox(width: 100),

              // Next / Get Started: filled
              InkWell(
                onTap: _goNext,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _teal,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    _currentPage == _data.length - 1 ? 'Get Started' : 'Next',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class ItemData {
  final String title;
  final String subtitle;
  final ImageProvider image;
  final Color backgroundColor;
  final Color titleColor;
  final Color subtitleColor;
  final String lottieUrl;

  ItemData({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.backgroundColor,
    required this.titleColor,
    required this.subtitleColor,
    required this.lottieUrl,
  });
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    required this.data,
    required this.isLastPage,
    this.onGetStarted,
    super.key,
  });

  final ItemData data;
  final bool isLastPage;
  final VoidCallback? onGetStarted;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      // full-screen Lottie background if you still want it:
      if (data.lottieUrl.isNotEmpty)
        Positioned.fill(
          child: Lottie.network(
            data.lottieUrl,
            fit: BoxFit.fitWidth,
            repeat: true,
            animate: true,

            // tint if desired:
            delegates: LottieDelegates(
              values: [
                ValueDelegate.colorFilter(
                  const ['**'], // apply to all layers
                  value: const ColorFilter.mode(
                    Color(0xff008f99),
                    BlendMode.srcATop,
                  ),
                )
              ],
            ),
          ),
        ),

      Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 3),
            Flexible(flex: 20, child: Image(image: data.image)),
            const Spacer(flex: 1),
            Text(
              data.title,
              style: TextStyle(
                color: data.titleColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            const Spacer(flex: 1),
            Text(
              data.subtitle,
              style: TextStyle(
                color: data.subtitleColor,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
            const Spacer(flex: 10),
          ],
        ),
      ),
    ]);
  }
}







// import 'package:concentric_transition/page_view.dart';
// import 'package:edunourish/features/auth/screens/choice_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class OnBoardingScreen extends StatefulWidget {
//   static const routeName = '/onboarding';
//   const OnBoardingScreen({super.key});

//   @override
//   State<OnBoardingScreen> createState() => _OnBoardingScreenState();
// }

// class _OnBoardingScreenState extends State<OnBoardingScreen> {
//   final _pageController = PageController();
//   int _currentPage = 0;

//   final _data = [
//     ItemData(
//       title: "SMART EDUCATION",
//       subtitle: "Connect, learn, and grow with innovative education solutions.",
//       image: const AssetImage("assets/Intro_Screen_login/image-1.png"),
//       backgroundColor: const Color(0xff008f99),
//       titleColor: const Color.fromARGB(255, 255, 255, 255),
//       subtitleColor: const Color.fromARGB(255, 255, 255, 255),
//       background: Lottie.network(
//           'https://assets2.lottiefiles.com/packages/lf20_bq485nmk.json'),
//     ),
//     // ... (other pages) ...
//     ItemData(
//       title: "MODERN EDUCATION",
//       subtitle: "Where creativity and technology drive learning.",
//       image: const AssetImage("assets/Intro_Screen_login/image-4.png"),
//       backgroundColor: const Color.fromARGB(255, 255, 255, 255),
//       titleColor: const Color(0xff008f99),
//       subtitleColor: const Color(0xff008f99),
//       background: Lottie.network(
//         'https://assets2.lottiefiles.com/packages/lf20_bq485nmk.json',
//       ),
//     ),
//     ItemData(
//       title: "SMART STUDENTS",
//       subtitle: "A smarter way for students to reach new heights.",
//       image: const AssetImage("assets/Intro_Screen_login/image-3.png"),
//       backgroundColor: const Color(0xff008f99),
//       titleColor: const Color.fromARGB(255, 255, 255, 255),
//       subtitleColor: const Color.fromARGB(255, 255, 255, 255),
//       background: Lottie.network(
//           'https://assets2.lottiefiles.com/packages/lf20_bq485nmk.json'),
//     ),
//     ItemData(
//       title: "MODERN EDUCATION",
//       subtitle: "Where creativity and technology drive learning.",
//       image: const AssetImage("assets/Intro_Screen_login/image-4.png"),
//       backgroundColor: const Color.fromARGB(255, 255, 255, 255),
//       titleColor: const Color(0xff008f99),
//       subtitleColor: const Color(0xff008f99),
//       background: Lottie.network(
//           'https://assets2.lottiefiles.com/packages/lf20_bq485nmk.json'),
//     ),
//   ];

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   void _goNext() {
//     if (_currentPage < _data.length - 1) {
//       _pageController.nextPage(
//         duration: const Duration(milliseconds: 500),
//         curve: Curves.ease,
//       );
//     } else {
//       _finish();
//     }
//   }

//   void _goPrevious() {
//     if (_currentPage > 0) {
//       _pageController.previousPage(
//         duration: const Duration(milliseconds: 500),
//         curve: Curves.ease,
//       );
//     }
//   }

//   Future<void> _finish() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('showHome', true);
//     if (mounted) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const ChoiceScreen()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           ConcentricPageView(
//             pageController: _pageController,
//             onChange: (int index) => setState(() => _currentPage = index),
//             onFinish: _finish,
//             colors: _data.map((e) => e.backgroundColor).toList(),
//             itemCount: _data.length,
//             itemBuilder: (int index) {
//               return ItemWidget(
//                 data: _data[index],
//                 isLastPage: index == _data.length - 1,
//                 onGetStarted: _finish,
//               );
//             },
//           ),
//           // Bottom navigation
//           Positioned(
//             left: 16,
//             right: 16,
//             bottom: 32,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 // Previous
//                 if (_currentPage > 0)
//                   TextButton(
//                     onPressed: _goPrevious,
//                     child: const Text(
//                       "Previous",
//                       style: TextStyle(
//                         color: Color.fromARGB(255, 232, 142, 142),
//                         fontSize: 25,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   )
//                 else
//                   const SizedBox(width: 80), // placeholder to keep alignment
//                 // Next or Get Started
//                 InkWell(
//                     onTap: _goNext,
//                     child: Text(
//                       _currentPage == _data.length - 1
//                           ? "Get Started"
//                           : "Next",
//                       style: const TextStyle(
//                         backgroundColor: Color.fromARGB(255, 255, 255, 255),
                        
//                         color: Color.fromARGB(255, 0, 0, 0),
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     )),

//                 // TextButton(
//                 //   style: TextButton.styleFrom(
//                 //     backgroundColor: const Color(0xff008f99),
//                 //     padding: const EdgeInsets.only(
//                 //     left: 60,
//                 //     right: 60,
//                 //     ),
//                 //     shape: RoundedRectangleBorder(
//                 //       borderRadius: BorderRadius.circular(10),
//                 //     ),
//                 //   ),
//                 //   onPressed: _goNext,
//                 //   child: Text(
//                 //     _currentPage == _data.length - 1 ? "Get Started" : "Next",
//                 //     style: const TextStyle(
//                 //       color: Color.fromARGB(255, 255, 255, 255),
//                 //       fontSize: 18,
//                 //       fontWeight: FontWeight.bold,
//                 //     ),
//                 //   ),
//                 // ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class ItemData {
//   final String title;
//   final String subtitle;
//   final ImageProvider image;
//   final Color backgroundColor;
//   final Color titleColor;
//   final Color subtitleColor;
//   final Widget? background;

//   ItemData({
//     required this.title,
//     required this.subtitle,
//     required this.image,
//     required this.backgroundColor,
//     required this.titleColor,
//     required this.subtitleColor,
//     this.background,
//   });
// }

// class ItemWidget extends StatelessWidget {
//   const ItemWidget({
//     required this.data,
//     required this.isLastPage,
//     this.onGetStarted,
//     super.key,
//   });

//   final ItemData data;
//   final bool isLastPage;
//   final VoidCallback? onGetStarted;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         // Optional animated background
//         if (data.background != null) Positioned.fill(child: data.background!),
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Spacer(flex: 3),
//               Flexible(flex: 20, child: Image(image: data.image)),
//               const Spacer(flex: 1),
//               Text(
//                 data.title,
//                 style: TextStyle(
//                   color: data.titleColor,
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 1,
//                 ),
//                 maxLines: 1,
//               ),
//               const Spacer(flex: 1),
//               Text(
//                 data.subtitle,
//                 style: TextStyle(
//                   color: data.subtitleColor,
//                   fontSize: 20,
//                 ),
//                 textAlign: TextAlign.center,
//                 maxLines: 2,
//               ),
//               const Spacer(flex: 10),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }





// old Code




// import 'package:concentric_transition/page_view.dart';
// import 'package:edunourish/features/auth/screens/choice_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

// import 'package:shared_preferences/shared_preferences.dart';

// class OnBoardingScreen extends StatelessWidget {
//    static const routeName = '/onboarding';
//   OnBoardingScreen({super.key});
//   final data = [
//     ItemData(
//       title: "SMART EDUCATION",
//       subtitle: "Connect, learn, and grow with innovative education solutions.",
//       image: const AssetImage("assets/Intro_Screen_login/image-1.png"),
//       backgroundColor: const Color.fromARGB(255, 107, 157, 249),
//       titleColor: const Color.fromARGB(255, 131, 243, 189),
//       subtitleColor: Colors.white,
//       background: Lottie.network(
//           'https://assets2.lottiefiles.com/packages/lf20_bq485nmk.json'),
//     ),
//     ItemData(
//       title: "BEST TEACHERS",
//       subtitle: "Experience quality education from top teachers.",
//       image: const AssetImage("assets/Intro_Screen_login/image-2.png"),
//       backgroundColor: const Color(0xFF4757C0),
//       titleColor: Colors.red.shade400,
//       subtitleColor: Colors.black,
//       background: Lottie.network(
//           'https://assets2.lottiefiles.com/packages/lf20_bq485nmk.json'),
//     ),
//     ItemData(
//       title: "SMART STUDENTS",
//       subtitle: "A smarter way for students to reach new heights.",
//       image: const AssetImage("assets/Intro_Screen_login/image-3.png"),
//       backgroundColor: const Color.fromARGB(255, 107, 157, 249),
//       titleColor: Colors.greenAccent,
//       subtitleColor: Colors.white,
//       background: Lottie.network(
//           'https://assets2.lottiefiles.com/packages/lf20_bq485nmk.json'),
//     ),
//     ItemData(
//       title: "MODERN EDUCATION",
//       subtitle: "Where creativity and technology drive learning.",
//       image: const AssetImage("assets/Intro_Screen_login/image-4.png"),
//       backgroundColor: const Color(0xFF4757C0),
//       titleColor: Colors.red.shade400,
//       subtitleColor: Colors.black,
//       background: Lottie.network(
//           'https://assets2.lottiefiles.com/packages/lf20_bq485nmk.json'),
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ConcentricPageView(
//         onFinish: () {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => const ChoiceScreen()),
//           );
//         },
//         // radius: 40,
//         colors: data.map((e) => e.backgroundColor).toList(),
//         itemCount: data.length,
//         itemBuilder: (int index) {
//           return ItemWidget(
//             data: data[index],
//             isLastPage: index == data.length - 1,
//           );
//         },
//       ),
//     );
//   }
// }

// class ItemData {
//   final String title;
//   final String subtitle;
//   final ImageProvider image;
//   final Color backgroundColor;
//   final Color titleColor;
//   final Color subtitleColor;
//   final Widget? background;

//   ItemData({
//     required this.title,
//     required this.subtitle,
//     required this.image,
//     required this.backgroundColor,
//     required this.titleColor,
//     required this.subtitleColor,
//     this.background,
//   });
// }

// class ItemWidget extends StatelessWidget {
//   const ItemWidget({
//     required this.data,
//     required this.isLastPage,
//     super.key,
//   });

//   final ItemData data;
//   final bool isLastPage;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Spacer(flex: 3),
//               Flexible(
//                 flex: 20,
//                 child: Image(image: data.image),
//               ),
//               const Spacer(flex: 1),
//               Text(
//                 data.title,
//                 style: TextStyle(
//                   color: data.titleColor,
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 1,
//                 ),
//                 maxLines: 1,
//               ),
//               const Spacer(flex: 1),
//               Text(
//                 data.subtitle,
//                 style: TextStyle(
//                   color: data.subtitleColor,
//                   fontSize: 20,
//                 ),
//                 textAlign: TextAlign.center,
//                 maxLines: 2,
//               ),
//               const Spacer(flex: 10),
//               if (isLastPage)
//                 ElevatedButton(
//                   onPressed: () async{
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const ChoiceScreen(),
//                       ),
//                     );
//                     final prefs = await SharedPreferences.getInstance();
//                     prefs.setBool('showHome', true);
//                   },
//                   child: const Text('Get Started'),
//                 ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }