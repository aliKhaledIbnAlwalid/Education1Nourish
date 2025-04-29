// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class ProfilePageStudent extends StatefulWidget {
//   const ProfilePageStudent({super.key});
//   @override
//   _ProfilePageStudentState createState() => _ProfilePageStudentState();
// }

// class _ProfilePageStudentState extends State<ProfilePageStudent> {
//   Future<Profile> fetchProfile() async {
//     final response = await http.get(Uri.parse(
//         'http://54.242.19.19:3000/api/parents'));

//     if (response.statusCode == 200) {
//       return Profile.fromJson(json.decode(response.body));
//     } else {
//       throw Exception('Failed to load profile');
//     }
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
//       body: Stack(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Color(0xffb7c7c8),
//                   Color(0xff98afb0),
//                 ],
//               ),
//             ),
//           ),
//           FutureBuilder<Profile>(
//             future: fetchProfile(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 return Center(child: Text("Error: ${snapshot.error}"));
//               } else {
//                 Profile profile = snapshot.data!;
//                 return Column(
//                   children: [
//                     const SizedBox(height: 100),
//                     Container(
//                       width: 200,
//                       height: 200,
//                       decoration: const BoxDecoration(
//                         shape: BoxShape.circle,
//                         image: DecorationImage(
//                           image: AssetImage(
//                               'assets/Intro_Screen_login/EduIcon.png'),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     Text(
//                       profile.userName,
//                       style: const TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     Expanded(
//                       child: SingleChildScrollView(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 5),
//                           child: Column(
//                             children: [
//                               InfoRow(
//                                   label: 'userName', value: profile.userName),
//                               InfoRow(
//                                   label: 'Age', value: profile.age.toString()),
//                               InfoRow(
//                                   label: 'id', value: profile.id.toString()),
//                               InfoRow(label: 'address', value: profile.address),
//                               InfoRow(
//                                   label: 'phoneNumber',
//                                   value: profile.phoneNumber),
//                               InfoRow(label: 'gender', value: profile.gender),
//                               InfoRow(label: 'email', value: profile.email),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class InfoRow extends StatelessWidget {
//   final String label;
//   final String value;
//   const InfoRow({super.key, required this.label, required this.value});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 70,
//       margin: const EdgeInsets.only(bottom: 10),
//       decoration: BoxDecoration(
//         color: const  Color(0xffe8e6e9),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: ListTile(
//         title: Text(
//           '$label: $value',
//           style: const TextStyle(
//             fontSize: 18,
//             color: Colors.black,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//     );
//   }
// }

// /// Model

// class Profile {
//   final String userName;
//   final int age;
//   final int id;
//   final String address;
//   final String phoneNumber;
//   final String gender;
//   final String email;
//   Profile({
//     required this.userName,
//     required this.age,
//     required this.id,
//     required this.address,
//     required this.phoneNumber,
//     required this.gender,
//     required this.email,
//   });

//   factory Profile.fromJson(Map<String, dynamic> json) {
//     return Profile(
//       userName: json['userName'],
//       age: int.tryParse(json['age'].toString()) ?? 0, // Convert age to int
//       id: int.tryParse(json['id'].toString()) ?? 0, // Convert id to int
//       address: json['address'] ?? '',
//       phoneNumber: json['phoneNumber'] ?? '',
//       gender: json['gender'] ?? '',
//       email: json['email'] ?? '',
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:edunourish/features/student/providers/student_provider.dart';

class ProfilePageStudent extends StatelessWidget {
  const ProfilePageStudent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<StudentProvider>();
    if (prov.isLoading || prov.profile == null) {
      return const Center(child: CircularProgressIndicator());
    }
    final p = prov.profile!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xff1a1a1a),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
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
      body: Column(
        children: [
          const SizedBox(height: 100),
          Container(
            width: 120,
            height: 120,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/Intro_Screen_login/EduIcon.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            p.userName,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            p.email,
            style: const TextStyle(color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileInfoRow('Username', p.userName),
                    const Divider(),
                    ProfileInfoRow('Age', p.age.toString()),
                    const Divider(),
                    ProfileInfoRow('ID', p.id.toString()),
                    const Divider(),
                    ProfileInfoRow('Address', p.address),
                    const Divider(),
                    ProfileInfoRow('Phone', p.phoneNumber),
                    const Divider(),
                    ProfileInfoRow('Gender', p.gender),
                    const Divider(),
                    ProfileInfoRow('Email', p.email),
                    const Divider(),
                    ProfileInfoRow('Pocket Money', p.pocketmoney.toString()),
                    const Divider(),
                    ProfileInfoRow('Academic Year', p.academicYear),
                    const Divider(),
                    ProfileInfoRow('class Id', p.classId),
                    const Divider(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileInfoRow extends StatelessWidget {
  final String title;
  final String value;
  const ProfileInfoRow(this.title, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xff1a1a1a),
              )),
          Text(value,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xff1a1a1a),
              )),
        ],
      ),
    );
  }
}
