import 'package:flutter/material.dart';
import 'package:plant_app/features/home/presentation/widgets/notification_card.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  static final List<Map<String, dynamic>> notifications = [
    {
      'icon': Icons.water_drop,
      'title': "تنبيه الري",
      'message': "نبات القمح يحتاج للري اليوم",
      'time': "منذ ١٠ دقائق",
      'isRead': false,
    },
    {
      'icon': Icons.thermostat,
      'title': "تحذير الحرارة",
      'message': "درجة الحرارة مرتفعة في الصوبة",
      'time': "منذ ٣٠ دقيقة",
      'isRead': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text(
          'notification',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return NotificationCard(
            icon: notification['icon'],
            title: notification['title'],
            message: notification['message'],
            time: notification['time'],
            isRead: notification['isRead'],
          );
        },
      ),
    );
  }
}
