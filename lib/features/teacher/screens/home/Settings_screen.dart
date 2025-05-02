import 'package:flutter/material.dart';

class SettingsTeacher extends StatelessWidget {
  const SettingsTeacher({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          width: 100,
          height: 5,
          decoration: BoxDecoration(
            color: const Color(0xff008f99),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 20),
        const Text("Setings",
            style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 25,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 227, 226, 226),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildTile(
                  context,
                  icon: Icons.account_box,
                  title: 'Account',
                  page: const AccountScreen(),
                ),
                _buildTile(
                  context,
                  icon: Icons.security,
                  title: 'Security',
                  page: const SecurityScreen(),
                ),
                _buildTile(
                  context,
                  icon: Icons.privacy_tip,
                  title: 'Privacy',
                  page: const PrivacyScreen(),
                ),
                _buildTile(
                  context,
                  icon: Icons.info,
                  title: 'About',
                  page: const AboutScreen(),
                ),
                _buildTile(
                  context,
                  icon: Icons.help,
                  title: 'Help',
                  page: const HelpScreen(),
                ),
                Card(
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  margin:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
                  child: ListTile(
                    leading: const Icon(Icons.exit_to_app,
                        color: Colors.white, size: 28),
                    title: const Text(
                      //  textAlign: TextAlign.center,
                      'Logout',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    onTap: () {
                      // logout logic
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTile(BuildContext context,
      {required IconData icon, required String title, required Widget page}) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xff008f99), size: 28),
        title: Text(
          title,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xff1a2226)),
        ),
        trailing: const Icon(Icons.arrow_forward_ios,
            color: Color(0xff969696), size: 16),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        ),
      ),
    );
  }
}

// Common scaffold for settings screens
typedef SettingsBodyBuilder = Widget Function();

class SettingsScaffold extends StatelessWidget {
  final String title;
  final SettingsBodyBuilder bodyBuilder;

  const SettingsScaffold(
      {Key? key, required this.title, required this.bodyBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: Text(
          title,
          style: const TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: bodyBuilder(),
    );
  }
}

/// 1. Privacy Policy Screen
class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsScaffold(
      title: 'Privacy Policy',
      bodyBuilder: () => SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Last updated: January 1, 2025',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            _policySection(
              title: '1. Introduction',
              content:
                  'At EduNourish, we value your privacy and commitment to protecting your personal data. This policy explains how we collect, use, and safeguard your information when you use our app.',
            ),
            const SizedBox(height: 12),
            _policySection(
              title: '2. Data Collection',
              content:
                  'We collect information you provide directly, such as account details, and data we gather automatically, like usage metrics and device identifiers.',
            ),
            const SizedBox(height: 12),
            _policySection(
              title: '3. Use of Data',
              content:
                  'Your data enables us to personalize content, improve functionality, and communicate important updates. We do not sell your data to third parties.',
            ),
            const SizedBox(height: 12),
            _policySection(
              title: '4. Data Sharing',
              content:
                  'We only share data with trusted partners who adhere to our privacy standards, for purposes like hosting, analytics, and customer support.',
            ),
            const SizedBox(height: 12),
            _policySection(
              title: '5. Security Measures',
              content:
                  'We implement industry-standard encryption and security practices to protect your data in transit and at rest, though no method is 100% foolproof.',
            ),
            const SizedBox(height: 12),
            _policySection(
              title: '6. Your Rights',
              content:
                  'You can access, correct, or delete your personal information via Settings → Account. You may also opt out of certain data uses.',
            ),
            const SizedBox(height: 12),
            _policySection(
              title: '7. Contact Us',
              content:
                  'For any privacy-related questions, please email privacy@edunourish.com or visit our support page.',
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _policySection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                color: Color(0xff008f99),
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(content, style: const TextStyle(fontSize: 14, height: 1.6)),
      ],
    );
  }
}

/// Professional Security Screen
class SecurityScreen extends StatefulWidget {
  const SecurityScreen({Key? key}) : super(key: key);

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool _twoFA = false;
  bool _biometric = true;

  @override
  Widget build(BuildContext context) {
    return SettingsScaffold(
      title: 'Security',
      bodyBuilder: () => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Secure your account',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Manage your security settings to protect your personal information and data.',
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
          const SizedBox(height: 24),
          _buildCard(
            icon: Icons.lock_outline,
            title: 'Change Password',
            subtitle: 'Update your account password regularly',
            trailing: Icon(Icons.arrow_forward_ios,
                size: 16, color: Colors.grey.shade600),
            onTap: () {
              // Navigate to change password
            },
          ),
          _buildCard(
            icon: Icons.verified_user_outlined,
            title: 'Two-Factor Authentication',
            subtitle: 'Add an extra layer of security',
            trailing: Switch(
              value: _twoFA,
              onChanged: (v) => setState(() => _twoFA = v),
              activeColor: Colors.green,
            ),
          ),
          _buildCard(
            icon: Icons.fingerprint,
            title: 'Biometric Unlock',
            subtitle: 'Use fingerprint or face ID to unlock',
            trailing: Switch(
              value: _biometric,
              onChanged: (v) => setState(() => _biometric = v),
              activeColor: Colors.green,
            ),
          ),
          _buildCard(
            icon: Icons.security,
            title: 'App Lock',
            subtitle: 'Require authentication to open the app',
            trailing: Switch(
              value: true,
              onChanged: (_) {},
              activeColor: Colors.green,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.exit_to_app),
              label: const Text('Logout from All Devices'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              onPressed: () {
                // logout logic
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.blue.shade700, size: 24),
        ),
        title: Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle,
            style: const TextStyle(fontSize: 14, color: Colors.black54)),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}

/// 3. Account Screen
class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Example data
    const userName = 'Mostafa Mohamed';
    const email = 'mostafa@example.com';
    const phone = '+20 10 1234 5678';

    return SettingsScaffold(
      title: 'Account',
      bodyBuilder: () => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Username'),
            subtitle: const Text(userName),
            trailing: const Icon(Icons.edit),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text('Email'),
            subtitle: const Text(email),
            trailing: const Icon(Icons.edit),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text('Phone Number'),
            subtitle: const Text(phone),
            trailing: const Icon(Icons.edit),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Change Password'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

/// 4. About Screen
class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsScaffold(
      title: 'About',
      bodyBuilder: () => SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Banner image
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                'https://mario5542395.github.io/MARIO/image/1.jpg',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stack) => Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.broken_image,
                      size: 48, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '🎓 Welcome to EduNourish – Your Learning, Your Way! 🌟',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            // Description
            const Text(
              'EduNourish combines modern teaching methods with smart technology to deliver a comprehensive educational experience from early years through high school. '
              'Our mission is to empower students to innovate, collaborate, and excel in a rapidly evolving world.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17, height: 1.5),
            ),
            const SizedBox(height: 5),
            // Additional images row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _aboutImage(
                      'https://mario5542395.github.io/MARIO/image/primary%20school%202%20.jpg'),
                  const SizedBox(width: 12),
                  _aboutImage(
                      'https://mario5542395.github.io/MARIO/image/junior%20high%20school%201.jpg'),
                  const SizedBox(width: 12),
                  _aboutImage(
                      'https://mario5542395.github.io/MARIO/image/primary%20school%201.jpg'),
                  const SizedBox(width: 12),
                  _aboutImage(
                      'https://mario5542395.github.io/MARIO/image/junior%20high%20school2.jpg'),
                ],
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "From Pre-School to High School – We've Got You Covered",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const Text(
              'Whether youre just starting in Pre-School, stepping up in Primary, exploring new ideas in Junior School, or preparing for your future in High School, EduNourish is here to guide you every step of the way.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _aboutImage(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        url,
        width: 150,
        height: 150,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stack) => Container(
          width: 150,
          height: 150,
          color: Colors.grey.shade200,
          child: const Icon(Icons.broken_image, color: Colors.grey),
        ),
      ),
    );
  }
}

/// 5. Help Screen

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const faqs = [
      {
        'q': 'How do I apply for a course?',
        'a': 'Visit the Apply page on our website or contact admissions.'
      },
      {
        'q': 'How can I reset my password?',
        'a': 'Go to Account → Change Password and follow the prompts.'
      },
      {
        'q': 'Who do I contact for support?',
        'a': 'Email support@edunourish.com or use the in-app chat.'
      },
      {
        'q': 'Where can I view my grades?',
        'a':
            'Tap the Grades icon on the bottom navigation bar to see your recent results.'
      },
      {
        'q': 'How do I update my profile information?',
        'a': 'Go to Settings → Account and tap on the field you want to edit.'
      },
      {
        'q': 'Which payment methods are accepted?',
        'a':
            'We accept credit cards, debit cards, and PayPal through our secure payment gateway.'
      },
      {
        'q': 'Can I change the app language?',
        'a':
            'Settings → General → Language, then choose your preferred language.'
      },
      {
        'q': 'How do I check attendance records?',
        'a': 'Go to Calendar → Attendance tab to view daily attendance status.'
      },
    ];

    return SettingsScaffold(
      title: 'Help & FAQ',
      bodyBuilder: () => ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: faqs.length,
        separatorBuilder: (_, __) => const SizedBox.shrink(),
        itemBuilder: (_, i) {
          final faq = faqs[i];
          return ExpansionTile(
            iconColor: Colors.teal,
            collapsedIconColor: const Color(0xff008f99),
            internalAddSemanticForOnTap: true,
            textColor: Colors.teal,
            tilePadding: EdgeInsets.zero,
            title: Text(
              faq['q']!,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            childrenPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: [Text(faq['a']!, style: const TextStyle(fontSize: 14))],
          );
        },
      ),
    );
  }
}
