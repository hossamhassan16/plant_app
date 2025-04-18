import 'package:flutter/material.dart';
import 'package:plant_app/features/home/presentation/widgets/notification_card.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});
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
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.settings),
        //     onPressed: () {
        //       Navigator.pushNamed(context, '/notification_settings');
        //     },
        //   ),
        // ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          NotificationCard(
            icon: Icons.water_drop,
            title: "تنبيه الري",
            message: "نبات القمح يحتاج للري اليوم",
            time: "منذ ١٠ دقائق",
            isRead: false,
          ),
          NotificationCard(
            icon: Icons.thermostat,
            title: "تحذير الحرارة",
            message: "درجة الحرارة مرتفعة في الصوبة",
            time: "منذ ٣٠ دقيقة",
            isRead: true,
          ),
        ],
      ),
    );
  }
}
