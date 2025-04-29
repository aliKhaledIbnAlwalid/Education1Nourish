import 'package:edunourish/features/Parent/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:edunourish/features/auth/screens/login_screen.dart';
import 'package:edunourish/features/teacher/widgets/btm_nav_bar.dart';

class ChoiceScreen extends StatelessWidget {
  static const routeName = '/choose-role';
  const ChoiceScreen({super.key});

  static const _backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF008f99), Color(0xFF008f99)],
  );

  static const _roles = <_RoleCardData>[
    _RoleCardData(
      title: 'Parent',
      icon: Icons.family_restroom,
      description: "Access your child's progress and communicate with teachers",
      color: Color(0xFF008f99),
      role: 'parent',
    ),
    _RoleCardData(
      title: 'Student',
      icon: Icons.person,
      description: 'Access your courses, assignments, and learning materials',
      color: Color(0xFF008f99),
      role: 'student',
    ),
    _RoleCardData(
      title: 'Teacher',
      icon: Icons.psychology,
      description: 'Manage your classes, assignments, and student progress',
      color: Color(0xFF008f99),
      role: 'teacher',
    ),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          decoration: const BoxDecoration(gradient: _backgroundGradient),
          child: const SafeArea(
            child: Column(
              children: [
                SizedBox(height: 40),
                _Logo(),
                SizedBox(height: 30),
                _Title(),
                SizedBox(height: 10),
                _Subtitle(),
                SizedBox(height: 60),
                Expanded(child: _RoleList()),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      );
}

class _Logo extends StatelessWidget {
  const _Logo();
  @override
  Widget build(BuildContext context) => Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(Icons.school, size: 60, color: Color(0xFF008f99)),
      );
}

class _Title extends StatelessWidget {
  const _Title();
  @override
  Widget build(BuildContext context) => const Text(
        'Choose Your Role',
        style: TextStyle(
            fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
      );
}

class _Subtitle extends StatelessWidget {
  const _Subtitle();
  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Text(
          'Select which option best describes your role',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      );
}

class _RoleList extends StatelessWidget {
  const _RoleList();
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: ChoiceScreen._roles.length,
      separatorBuilder: (_, __) => const SizedBox(height: 20),
      itemBuilder: (_, i) => _RoleCard(data: ChoiceScreen._roles[i]),
    );
  }
}

class _RoleCardData {
  final String title;
  final IconData icon;
  final String description;
  final Color color;
  final String role;

  const _RoleCardData({
    required this.title,
    required this.icon,
    required this.description,
    required this.color,
    required this.role,
  });
}

class _RoleCard extends StatelessWidget {
  final _RoleCardData data;
  const _RoleCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // if (data.role == 'teacher') {
        //   Navigator.pushNamed(context, BtmNavBarTeacher.routeName);
        // } else {
        //   Navigator.pushNamed(
        //     context,
        //     LoginScreen.routeName,
        //     arguments: data.role,
        //   );
        // }
        if (data.role == 'teacher') {
          Navigator.pushNamed(context, BtmNavBarTeacher.routeName);
        } else if (data.role == 'parent') {
          AppRouter.toParentHome(context);
        } else {
          Navigator.pushNamed(
            context,
            LoginScreen.routeName,
            arguments: data.role,
          );
        }
      },
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12,
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 3)),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: double.infinity,
              width: 100,
              decoration: BoxDecoration(
                color: data.color.withValues(alpha: 0.2),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
              ),
              child: Icon(data.icon, size: 55, color: data.color),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  data.title,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 15),
              child:
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}




// same top code ^ but High Performance Refactoring

// import 'package:edunourish/features/student/widgets/btm_nav_bar_student.dart';
// import 'package:edunourish/features/teacher/widgets/btm_nav_bar.dart';
// import 'package:flutter/material.dart';

// class ChoiceScreen extends StatelessWidget {
//   const ChoiceScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Colors.blue.shade300,
//               Colors.blue.shade700,
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: Column(
//             children: [
//               const SizedBox(height: 40),

//               // App logo/icon
//               Container(
//                 height: 100,
//                 width: 100,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Icon(
//                   Icons.school,
//                   size: 60,
//                   color: Colors.blue.shade700,
//                 ),
//               ),

//               const SizedBox(height: 30),

//               // Heading
//               const Text(
//                 'Choose Your Role',
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),

//               const SizedBox(height: 10),

//               // Subheading
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 40),
//                 child: Text(
//                   'Select which option best describes your role',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 60),

//               // Role selection cards
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Column(
//                     children: [
//                       _buildRoleCard(
//                         context,
//                         'Parent',
//                         Icons.family_restroom,
//                         'Access your child\'s progress and communicate with teachers',
//                         Colors.orange.shade400,
//                         () => _navigateToHome(context, 'parent'),
//                       ),
//                       const SizedBox(height: 20),
//                       _buildRoleCard(
//                         context,
//                         'Student',
//                         Icons.person,
//                         'Access your courses, assignments, and learning materials',
//                         Colors.green.shade400,
//                         () => _navigateToHome(context, 'student'),
//                       ),
//                       const SizedBox(height: 20),
//                       _buildRoleCard(
//                         context,
//                         'Teacher',
//                         Icons.psychology,
//                         'Manage your classes, assignments, and student progress',
//                         Colors.purple.shade400,
//                         () => _navigateToHome(context, 'teacher'),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Navigation function
//   void _navigateToHome(BuildContext context, String role) {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) {
//           switch (role) {
//             case 'parent':
//               return const BtmNavBarStudent();
//             case 'student':
//               return const BtmNavBarStudent();
//             case 'teacher':
//               return const BtmNavBarTeacher();
//             default:
//               return const BtmNavBarStudent();
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildRoleCard(BuildContext context, String title, IconData icon,
//       String description, Color color, VoidCallback onTap) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         height: 120,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(15),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               spreadRadius: 1,
//               blurRadius: 5,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             Container(
//               width: 80,
//               decoration: BoxDecoration(
//                 color: color.withOpacity(0.2),
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(15),
//                   bottomLeft: Radius.circular(15),
//                 ),
//               ),
//               child: Center(
//                 child: Icon(
//                   icon,
//                   size: 40,
//                   color: color,
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(15),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       title,
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.grey.shade800,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.only(right: 15),
//               child: Icon(
//                 Icons.arrow_forward_ios,
//                 size: 16,
//                 color: Colors.grey,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }






































































// import 'package:edunourish/login/login_screen.dart';
// import 'package:flutter/material.dart';
// import 'Student_Interface/btm_nav_bar_student.dart';

// class ChoiceScreen extends StatelessWidget {
//   const ChoiceScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blueAccent,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.2,
//             width: double.infinity,
//             child: GestureDetector(
//                 child: Container(
//                   color: Colors.green,
//                   child: const Center(
//                     child: Text(
//                       'Parent',
//                       style: TextStyle(color: Colors.white, fontSize: 30),
//                     ),
//                   ),
//                 ),
//                 onTap: () {
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>const BtmNavBarStudent(),
//                     ),
//                   );
//                 }),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.2,
//             width: double.infinity,
//             child: GestureDetector(
//                 child: Container(
//                   color: Colors.green,
//                   child: const Center(
//                     child: Text(
//                       'Student',
//                       style: TextStyle(color: Colors.white, fontSize: 30),
//                     ),
//                   ),
//                 ),
//                 onTap: () {
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const BtmNavBarStudent(),
//                     ),
//                   );
//                 }),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.2,
//             width: double.infinity,
//             child: GestureDetector(
//                 child: Container(
//                   color: Colors.green,
//                   child: const Center(
//                     child: Text(
//                       'Teacher',
//                       style: TextStyle(color: Colors.white, fontSize: 30),
//                     ),
//                   ),
//                 ),
//                 onTap: () {
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const LoginScreen(),
//                     ),
//                   );
//                 }),
//           ),
//         ],
//       ),
//     );
//   }
// }


