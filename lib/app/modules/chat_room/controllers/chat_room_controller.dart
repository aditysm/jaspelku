import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaspelku/all_material.dart';

class ChatMessage {
  final String senderId;
  final String text;
  final DateTime timestamp;

  ChatMessage({
    required this.senderId,
    required this.text,
    required this.timestamp,
  });
}

class ChatRoomController extends GetxController {
  final textController = TextEditingController();
  final textNode = FocusNode();

  var messages = <ChatMessage>[].obs;
  var isLoading = false.obs;
  final currentUserId = "user123";

  var systemErrors = <DateTime, String>{}.obs;

  final chatRoomIds = ["room1", "room2", "room3", "room4", "room5"].obs;
  var currentChatRoomId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    currentChatRoomId.value = "room${Get.arguments["id"] ?? 1}";
    ever(currentChatRoomId, (_) {
      fetchMessages();
    });
    fetchMessages();
  }

  @override
  void onClose() {
    messages.clear();
    super.onClose();
  }

  void fetchMessages() async {
    print("yo");
    var dialog = Get.isDialogOpen ?? false;

    try {
      isLoading.value = true;
      if (dialog == false && isLoading.isTrue) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          AllMaterial.showLoadingDialog();
        });
      }

      await _simulateFetchForRoom(currentChatRoomId.value);
    } finally {
      isLoading.value = false;
      Get.back();
    }
    update();
  }

  Future<void> _simulateFetchForRoom(String roomId) async {
    await Future.delayed(const Duration(seconds: 2));
    print(roomId);
    final newMessages = [
      ChatMessage(
        senderId: "user123",
        text: "Halo dari $roomId!",
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      ChatMessage(
        senderId: "user456",
        text: "Hai, ada yang bisa dibantu di $roomId?",
        timestamp: DateTime.now().subtract(const Duration(minutes: 4)),
      ),
    ];

    messages.assignAll(newMessages);
    update();
  }

  void switchRoom() {
    currentChatRoomId.value = "room${Get.arguments["id"] ?? 0}";
    fetchMessages();
  }

  void sendMessage() {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    final phoneRegex = RegExp(r'(?:\+62|62|08)[0-9]{8,}');
    if (phoneRegex.hasMatch(text)) {
      showErrorMessageAsChat("Tidak boleh mengirim nomor telepon!");
      return;
    }

    final newMessage = ChatMessage(
      senderId: currentUserId,
      text: text,
      timestamp: DateTime.now(),
    );

    messages.add(newMessage);
    textController.clear();
  }

  void showErrorMessageAsChat(String error) {
    final now = DateTime.now();
    systemErrors[now] = error;
    textController.clear();
  }
}
