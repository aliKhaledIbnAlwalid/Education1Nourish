import 'package:edunourish/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/auth/screens/on_boarding_screen.dart';
import 'features/auth/screens/choice_screen.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/student/providers/student_provider.dart';
import 'features/teacher/providers/teacher_provider.dart';
import 'features/student/widgets/btm_nav_bar_student.dart';
import 'features/teacher/widgets/btm_nav_bar.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final seenOnboarding = prefs.getBool('seenOnboarding') ?? true;
  runApp(MyApp(seenOnboarding: seenOnboarding));
}

class MyApp extends StatelessWidget {
  final bool seenOnboarding;
  const MyApp({super.key, required this.seenOnboarding});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StudentProvider()),
        ChangeNotifierProvider(create: (_) => TeacherProvider()),
      ],
      child: MaterialApp(
        // from line 31 to 34 , who is added by mohamed
        theme: ThemeData(
        scaffoldBackgroundColor: ourBackgroundColor,
        ),
        debugShowCheckedModeBanner: false,
        title: 'EduNourish',
        initialRoute: seenOnboarding
            ? ChoiceScreen.routeName
            : OnBoardingScreen.routeName,
        routes: {
          OnBoardingScreen.routeName: (_) => const OnBoardingScreen(),
          ChoiceScreen.routeName: (_) => const ChoiceScreen(),
          BtmNavBarStudent.routeName: (_) => const BtmNavBarStudent(),
          BtmNavBarTeacher.routeName: (_) => const BtmNavBarTeacher(),

        },
        onGenerateRoute: (settings) {
          if (settings.name == LoginScreen.routeName) {
            final role = settings.arguments as String? ?? 'student';
            return MaterialPageRoute(
              builder: (_) => LoginScreen(role: role),
              settings: settings,
            );
          }
          // fallback — unknown route
          return MaterialPageRoute(
            builder: (_) => Scaffold(
              body:
                  Center(child: Text('No route defined for ${settings.name}')),
            ),
          );
        },
      ),
    );
  }
}










// this code belong to shared preferences to save the state of the app (onboarding screen)
// el lol hy5rb eldnyah b2zn allah et2loo 3lya
// mohamed's answer: gamed

// import 'package:edunourish/choice_screen.dart';

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'intro_Screens/on_boarding_screen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final prefs = await SharedPreferences.getInstance();
//   final showHome = prefs.getBool('showHome') ?? false;
//   runApp(MyApp(showHome: showHome));
// }
// class MyApp extends StatelessWidget {
//   final bool showHome;
//   const MyApp({Key? key, required this.showHome}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: showHome ? const ChoiceScreen() : OnBoardingScreen(),
//     );
//   }
// }import 'package:flutter/material.dart';