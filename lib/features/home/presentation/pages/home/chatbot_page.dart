import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_app/features/home/presentation/pages/cubits/chat_cubit/chat_cubit.dart';
import 'package:plant_app/features/home/presentation/widgets/chat_bubble.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});
  static String id = "ChatbotPage";

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController controller = TextEditingController();
  final ScrollController _controller = ScrollController();
  String? email;

  bool _isInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      try {
        email = ModalRoute.of(context)!.settings.arguments as String?;
        context.read<ChatCubit>().getMessages();
        _isInit = true;
      } catch (e, stackTrace) {
        print("❌ Error in didChangeDependencies: $e");
        print("📌 StackTrace: $stackTrace");
      }
    }
  }

  void sendMessage() {
    if (controller.text.trim().isNotEmpty && email != null) {
      context
          .read<ChatCubit>()
          .sendMessage(message: controller.text.trim(), email: email!);
      controller.clear();

      _controller.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Chat", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                if (state is ChatSuccess) {
                  return ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      return state.messages[index].id == email
                          ? ChatBubble(message: state.messages[index])
                          : ChatBubbleForFriend(message: state.messages[index]);
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: "Send Message",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Colors.green),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: sendMessage,
                  child: const Icon(Icons.send, color: Colors.green),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
