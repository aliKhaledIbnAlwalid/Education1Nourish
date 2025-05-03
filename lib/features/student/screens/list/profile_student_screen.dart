import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:edunourish/features/student/providers/student_provider.dart';

class ProfileScreenStudent extends StatelessWidget {
  const ProfileScreenStudent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<StudentProvider>();
    if (prov.isLoading || prov.profile == null) {
      return const Center(child: CircularProgressIndicator());
    }
    final p = prov.profile!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xfff2f2f2),
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xff1a1a1a),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
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
                color: Color(0xff008f99),
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
