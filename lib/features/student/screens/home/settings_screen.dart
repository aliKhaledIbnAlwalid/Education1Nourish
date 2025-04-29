import 'package:flutter/material.dart';

class SettingsStudent extends StatelessWidget {
  const SettingsStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff98afb0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Settings',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          const CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage("assets/face.png"),
          ),
          const SizedBox(height: 10),
          const Text("HI",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xff98afb0),
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Text(
              "User Name",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: const  Color(0xffe8e6e9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  buildSwitchTile(),
                  buildSettingsTile(
                      context, Icons.notifications, "Notifications"),
                  buildSettingsTile(context, Icons.privacy_tip, "Privacy"),
                  buildSettingsTile(context, Icons.security, "Security"),
                  buildSettingsTile(context, Icons.account_box, "Account"),
                  buildSettingsTile(context, Icons.help, "Help"),
                  buildSettingsTile(context, Icons.info, "About"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSwitchTile() {
    return SwitchListTile(
      title: const Text("Dark Mode"),
      secondary: const Icon(Icons.dark_mode),
      value: false,
      onChanged: (value) {},
    );
  }

  Widget buildSettingsTile(BuildContext context, IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
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
