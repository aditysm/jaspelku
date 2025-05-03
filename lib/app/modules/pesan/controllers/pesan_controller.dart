import 'package:get/get.dart';

class PesanController extends GetxController {
  final originalChatItem = <ChatItem>[];
  var isSearchingMessage = false.obs;
  var chatItem = <ChatItem>[].obs;
  var filteredChat = <ChatItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDummyData();
    filteredChat.assignAll(originalChatItem);
  }

  void resetSearch() {
    filteredChat.assignAll(originalChatItem);
  }

  void searchMessage(String query) {
    if (query.isEmpty) {
      filteredChat.assignAll(originalChatItem);
    } else {
      filteredChat.assignAll(originalChatItem.where((chat) {
        final msg = chat.message.toLowerCase();
        final name = chat.senderName.toLowerCase();
        return msg.contains(query.toLowerCase()) ||
            name.contains(query.toLowerCase());
      }));
    }
  }

  void loadDummyData() {
    originalChatItem.clear();
    originalChatItem.addAll([
      ChatItem(
        isVerified: true,
        senderName: "Andi",
        message: "Halo, bisa bantu servis AC minggu ini?",
        timestamp: DateTime.now().subtract(Duration(minutes: 10)),
      ),
      ChatItem(
        isVerified: true,
        senderName: "Budi",
        message: "Terima kasih atas pelayanannya!",
        timestamp: DateTime.now().subtract(Duration(hours: 1)),
      ),
      ChatItem(
        isVerified: false,
        senderName: "Citra",
        message: "Apakah bisa request jadwal sore?",
        timestamp: DateTime.now().subtract(Duration(days: 1)),
      ),
      ChatItem(
        isVerified: true,
        senderName: "Dina",
        message: "Teknisi sudah datang, hasilnya memuaskan.",
        timestamp: DateTime.now().subtract(Duration(minutes: 30)),
      ),
      ChatItem(
        isVerified: false,
        senderName: "Eko",
        message: "Tolong cek lagi AC kamar utama ya.",
        timestamp: DateTime.now().subtract(Duration(days: 2)),
      ),
    ]);

    chatItem.assignAll(originalChatItem);
  }
}

class ChatItem {
  final String senderName;
  final String message;
  final DateTime timestamp;
  final bool isVerified;

  ChatItem({
    required this.isVerified,
    required this.senderName,
    required this.message,
    required this.timestamp,
  });
}
