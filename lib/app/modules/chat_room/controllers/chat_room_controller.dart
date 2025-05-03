import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChatRoomController extends GetxController {
  final textController = TextEditingController();
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final RxString currentMessage = ''.obs;

  // Simulasi user yang sedang login
  final String currentUserId = 'user_1';

  void sendMessage() {
    if (currentMessage.value.trim().isEmpty) return;

    messages.add(
      ChatMessage(
        text: currentMessage.value.trim(),
        timestamp: DateTime.now(),
        senderId: currentUserId,
      ),
    );

    currentMessage.value = '';
  }

  // Simulasi pesan masuk dari user lain
  void receiveMessage(String text) {
    messages.add(
      ChatMessage(
        text: text,
        timestamp: DateTime.now(),
        senderId: 'user_2',
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final DateTime timestamp;
  final String senderId;

  ChatMessage({
    required this.text,
    required this.timestamp,
    required this.senderId,
  });
}
