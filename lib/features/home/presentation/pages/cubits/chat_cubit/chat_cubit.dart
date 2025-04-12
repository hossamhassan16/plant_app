import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:plant_app/models/message_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  void sendMessage({required String message, required String email}) async {
    try {
      // Send user message
      await messages.add({
        "message": message,
        "createdAt": DateTime.now().toUtc(),
        "id": email,
      });

      // Auto-reply from bot
      await messages.add({
        "message": _generateAutoReply(message),
        "createdAt": DateTime.now().toUtc(),
        "id": "bot",
      });
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  void getMessages() {
    try {
      messages.orderBy("createdAt", descending: true).snapshots().listen(
        (event) {
          for (var doc in event.docs) {
            print("🔥 Document data: ${doc.data()}");
          }

          List<MessageModel> messagesList = event.docs
              .map((doc) =>
                  MessageModel.fromJson(doc.data() as Map<String, dynamic>))
              .toList();

          emit(ChatSuccess(messagesList));
        },
        onError: (error) {
          print("❌ Firestore stream error: $error");
        },
      );
    } catch (e) {
      print("❌ Caught error in getMessages: $e");
    }
  }

  String _generateAutoReply(String userMessage) {
    return "Thanks for your message! 🌿 We'll get back to you soon.";
  }
}
