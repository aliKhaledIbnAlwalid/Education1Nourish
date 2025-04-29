import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfilePageTeacher extends StatefulWidget {
  const ProfilePageTeacher({super.key});

  @override
  _ProfilePageTeacherState createState() => _ProfilePageTeacherState();
}

class _ProfilePageTeacherState extends State<ProfilePageTeacher> {
  Future<Profile> fetchProfile() async {
    final response =
        await http.get(Uri.parse('http://54.242.19.19:3000/api/parents'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      if (data.isNotEmpty && data[0] is Map<String, dynamic>) {
        return Profile.fromJson(data[0]);
      } else {
        throw Exception('Invalid data format');
      }
    } else {
      throw Exception('Failed to load profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
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
          FutureBuilder<Profile>(
            future: fetchProfile(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else {
                Profile profile = snapshot.data!;
                return Column(
                  children: [
                      const SizedBox(height: 100),
                      Container(
                        width: 120,
                        height: 120,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/Intro_Screen_login/EduIcon.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    Text(
                      profile.username,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      profile.password,
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
                              ProfileInfoRow("Username", profile.username),
                              const Divider(),
                              ProfileInfoRow("Age", profile.age.toString()),
                              const Divider(),
                              ProfileInfoRow("ID", profile.id.toString()),
                              const Divider(),
                              ProfileInfoRow("Gender", profile.gender),
                              const Divider(),
                              ProfileInfoRow("Phone", profile.phoneNumber),
                              const Divider(),
                              ProfileInfoRow("Email", profile.email),
                              const Divider(),
                              ProfileInfoRow("Address", profile.address),
                              const Divider(),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
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

class Profile {
  final String username;
  final int age;
  final int id;
  final String address;
  final String phoneNumber;
  final String gender;
  final String email;
  final String password;

  Profile({
    required this.username,
    required this.age,
    required this.id,
    required this.address,
    required this.phoneNumber,
    required this.gender,
    required this.email,
    required this.password,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      username: json['username'] ?? '',
      age: int.tryParse(json['age'].toString()) ?? 0,
      id: int.tryParse(json['id'].toString()) ?? 0,
      address: json['address'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      gender: json['gender'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '', // fallback value
    );
  }
}
