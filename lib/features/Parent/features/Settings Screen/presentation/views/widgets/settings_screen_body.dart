import 'package:edunourish/features/Parent/core/utils/assets.dart';
import 'package:edunourish/core/utils/constants.dart';
import 'package:edunourish/features/Parent/core/widgets/base_scaffold.dart';
import 'package:flutter/material.dart';

class SettingsScreenBody extends StatelessWidget {
  const SettingsScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Container(
        color: ourBackgroundColor,
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: ListView(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10, bottom: 15),
                      child: Text(
                        'Settings',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildSettingsCategory(
                      title: 'Account Settings',
                      icon: Icons.person_outline,
                    ),
                    _buildSettingsTile(
                      icon: Icons.account_circle,
                      title: 'Profile',
                      onTap: () {
                        // Handle Profile navigation
                      },
                    ),
                    _buildSettingsTile(
                      icon: Icons.notifications_outlined,
                      title: 'Notifications',
                      onTap: () {
                        // Handle Notifications navigation
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildSettingsCategory(
                      title: 'Privacy & Security',
                      icon: Icons.security_outlined,
                    ),
                    _buildSettingsTile(
                      icon: Icons.privacy_tip_outlined,
                      title: 'Privacy',
                      onTap: () {
                        // Handle Privacy navigation
                      },
                    ),
                    _buildSettingsTile(
                      icon: Icons.lock_outline,
                      title: 'Security',
                      onTap: () {
                        // Handle Security navigation
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildSettingsCategory(
                      title: 'Support',
                      icon: Icons.support_outlined,
                    ),
                    _buildSettingsTile(
                      icon: Icons.help_outline,
                      title: 'Help Center',
                      onTap: () {
                        // Handle Help navigation
                      },
                    ),
                    _buildSettingsTile(
                      icon: Icons.info_outline,
                      title: 'About',
                      onTap: () {
                        // Handle About navigation
                      },
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle logout
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[100],
                          foregroundColor: Colors.red[800],
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Log Out',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsCategory({required String title, required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, bottom: 8, top: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.withOpacity(0.1)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Icon(icon, color: ourMainColor),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16, color: ourMainColor),
        onTap: onTap,
      ),
    );
  }
}