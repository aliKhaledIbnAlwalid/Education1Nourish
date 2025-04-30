
import 'package:edunourish/features/Parent/core/utils/assets.dart';
import 'package:edunourish/core/utils/constants.dart';
import 'package:edunourish/features/Parent/features/Settings%20Screen/presentation/views/widgets/settings_app_bar.dart';
import 'package:flutter/material.dart';

class SettingsScreenBody extends StatelessWidget {
  const SettingsScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: secondColor,
      child: Column(
          children: [
            const SettingsAppBar(),
            const CircleAvatar(
              radius: 50,
              backgroundImage:
              AssetImage(parentImage),
            ),
            const SizedBox(height: 15),
            // const Text(
            //   'HI',
            //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            // ),
            // const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Mohamed Hamdy',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ListView(
                  children: [
                    const Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                   
                    ListTile(
                      leading: const Icon(Icons.notifications),
                      title: const Text('Notifications'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Handle Notifications navigation
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.privacy_tip),
                      title: const Text('Privacy'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Handle Privacy navigation
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.security),
                      title: const Text('Security'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Handle Security navigation
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.account_box),
                      title: const Text('Account'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Handle Account navigation
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.help),
                      title: const Text('Help'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Handle Help navigation
                      },
                    ),
                    //  ListTile(
                    //   leading: const Icon(Icons.dark_mode),
                    //   title: const Text('Dark Mode'),
                    //   trailing: Switch(
                    //     value: false,
                    //     onChanged: (value) {
                    //       // Handle dark mode toggle
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }
}
