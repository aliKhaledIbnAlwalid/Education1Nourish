import 'package:flutter/material.dart';

class SettingsStudent extends StatelessWidget {
  const SettingsStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
         const SizedBox(
            height: 20,
          ),
          const CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage("assets/face.png"),
          ),
          const SizedBox(height: 10),
          const Text("HI",
              style: TextStyle(
                color: Color(0xff008f99),
                fontSize: 18,
              )),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xff008f99),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "Mario Samy",
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 18),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color:Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  buildSettingsTile(
                      context, Icons.notifications, "Notifications"),
                  buildSettingsTile(context, Icons.privacy_tip, "Privacy"),
                  buildSettingsTile(context, Icons.security, "Security"),
                  buildSettingsTile(context, Icons.account_box, "Account"),
                  buildSettingsTile(context, Icons.info, "About"),
                  buildSettingsTile(context, Icons.help, "Help"),
                ],
              ),
            ),
          ),
        ],
      );
  }

  Widget buildSettingsTile(BuildContext context, IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xff008f99)),
      title: Text(
        title,
        style: const TextStyle(
          color:  Color(0xff008f99),
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Color(0xff008f99),
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PlaceholderPage(title: title)),
      ),
    );
  }
}

class PlaceholderPage extends StatelessWidget {
  final String title;

  const PlaceholderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text("$title Page")),
    );
  }
}
