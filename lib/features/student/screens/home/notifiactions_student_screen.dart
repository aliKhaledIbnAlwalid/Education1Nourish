import 'package:flutter/material.dart';

class NotificationsStudentScreen extends StatefulWidget {
  NotificationsStudentScreen({super.key});

  @override
  State<NotificationsStudentScreen> createState() =>
      _NotificationsStudentScreenState();
}

class _NotificationsStudentScreenState
    extends State<NotificationsStudentScreen> {
  final List<NotificationStudent> notifications = [
    NotificationStudent(
      title: 'The results are in! Your earnings added up to \$0.04 in October.',
      time: '5h',
    ),
    NotificationStudent(
      title:
          'Get a more rewarding experience with the Mobile & Personal Protection Bundle.',
      time: '1d',
    ),
    NotificationStudent(
      title:
          'Welcome to Neo Money™! Don\'t forget to make a deposit to start earning 2.25% interest*.',
      time: '3d',
    ),
    NotificationStudent(
      title:
          'Don\'t miss out! For a limited time, get up to \$85* for each friend you refer to Neo.',
      time: '4d',
    ),
    NotificationStudent(
      title:
          'Welcome to Neo Money™! Don\'t forget to make a deposit to start earning 2.25% interest*.',
      time: '3d',
    ),
    NotificationStudent(
      title:
          'Welcome to Neo Money™! Don\'t forget to make a deposit to start earning 2.25% interest*.',
      time: '3d',
    )
  ];

  List<NotificationStudent> globalNotifications = [
    NotificationStudent(title: "New message!", time: "5h"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      appBar: AppBar(
        title: const Text(
          'Notifiactions  ',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: notifications.isNotEmpty
          ? ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return _buildNotificationItem(context, notification);
              },
            )
          : Scaffold(
              backgroundColor: const Color(0xff98afb0),
              body: Center(
                  child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: Image.asset(
                        'assets/student/Home_Student/NoNotifiactionsAlarm.png'),
                  ),
                  const Text(
                    'you are all caught up!',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Check back later for updates and reminders.',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ],
              )),
            ),
    );
  }
}

class NotificationStudent {
  final String title;
  final String time;

  NotificationStudent({
    required this.title,
    required this.time,
  });
}

Widget _buildNotificationItem(
    BuildContext context, NotificationStudent notification) {
  return ListTile(
    leading: Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xff008f99),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
        child: Text(
          'Edu',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
    title: Text(
      notification.title,
    ),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          notification.time,
        ),
        IconButton(
          icon: const Icon(Icons.more_horiz),
          onPressed: () {},
          color: Colors.grey[600],
        ),
      ],
    ),
  );
}
