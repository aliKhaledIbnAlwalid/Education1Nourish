import 'package:flutter/material.dart';
import 'package:edunourish/core/models/notification.dart';

class NotificationsScreen extends StatelessWidget {
  final List<NeoNotification> notifications;

  const NotificationsScreen({
    Key? key,
    this.notifications = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff98afb0),
      appBar: AppBar(
        title: const Text('Notifications', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (ctx, i) => _buildNotificationItem(ctx, notifications[i]),
      ),
    );
  }
}

Widget _buildNotificationItem(BuildContext context, NeoNotification n) {
  return ListTile(
    leading: Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
      child: const Center(child: Text('Edu', style: TextStyle(color: Colors.white))),
    ),
    title: Text(n.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(n.time),
        IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {}),
      ],
    ),
  );
}
