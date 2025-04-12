import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? email;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // استلام البريد الإلكتروني من arguments
    email = ModalRoute.of(context)!.settings.arguments as String?;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildCard(
            context,
            icon: Icons.eco,
            title: 'Greenhouse Info',
            subtitle: 'Monitor temperature, lighting & more',
            onTap: () {
              Navigator.pushNamed(
                context,
                'GreenhousePage',
              );
            },
          ),
          const SizedBox(height: 20),
          _buildCard(
            context,
            icon: Icons.article,
            title: 'Helpful Articles',
            subtitle: 'Read tips to grow better plants',
            onTap: () {
              Navigator.pushNamed(context, 'ArticlesPage');
            },
          ),
          const SizedBox(height: 20),
          _buildCard(context,
              icon: Icons.chat_bubble_outline,
              title: 'Chatbot Assistant',
              subtitle: 'Ask your smart assistant', onTap: () {
            // التأكد من أن البريد الإلكتروني موجود قبل الانتقال
            if (email != null) {
              Navigator.pushNamed(context, 'ChatbotPage', arguments: email);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('لم يتم العثور على البريد الإلكتروني.')),
              );
            }
          }),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context,
      {required IconData icon,
      required String title,
      required String subtitle,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 8,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.green[100],
                child: Icon(
                  icon,
                  size: 30,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
