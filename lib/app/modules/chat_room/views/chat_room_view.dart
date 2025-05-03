import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaspelku/all_material.dart';
import 'package:jaspelku/app/modules/postingan_baru/views/postingan_baru_view.dart';
import '../controllers/chat_room_controller.dart';
import 'package:intl/intl.dart';

class ChatRoomView extends GetView<ChatRoomController> {
  const ChatRoomView({super.key});

  String getLabelForDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(date.year, date.month, date.day);

    if (messageDate == today) return 'Hari ini';
    if (messageDate == today.subtract(const Duration(days: 1))) {
      return 'Kemarin';
    }
    return DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatRoomController());
    var arg = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            AllMaterial.avatarWidget(name: arg["nama"]),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AllMaterial.namaDenganVerified(
                    name: AllMaterial.formatNamaPanjang(
                      arg["nama"],
                    ),
                    isVerified: arg["isVerified"]),
                Text(
                  'Sedang aktif',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.swap_horizontal_circle_outlined),
            tooltip: "Ajukan Tawaran",
            onPressed: () {
              Get.to(() => PostinganBaruView(), arguments: {
                "isTawaranBaru": true,
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Aksi lainnya
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                final messages = controller.messages;
                String? lastDateLabel;

                return ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    final isOwnMessage =
                        msg.senderId == controller.currentUserId;
                    final dateLabel = getLabelForDate(msg.timestamp);
                    final showLabel = lastDateLabel != dateLabel;
                    lastDateLabel = dateLabel;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (showLabel)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 12),
                                decoration: BoxDecoration(
                                  color: isOwnMessage
                                      ? Colors.grey.shade300
                                      : AllMaterial.colorBlackPrimary,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  dateLabel,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                        Align(
                          alignment: isOwnMessage
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isOwnMessage
                                  ? AllMaterial.colorPrimaryShade
                                  : AllMaterial.colorBlackPrimary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              msg.text,
                              style: TextStyle(
                                color: isOwnMessage
                                    ? AllMaterial.colorWhite
                                    : null,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      AllMaterial.messageScaffold(
                        title: "Fitur sedang digarap, coba lagi nanti!",
                      );
                    },
                  ),
                  Expanded(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        minHeight: 40,
                        maxHeight: 150,
                      ),
                      child: Scrollbar(
                        child: TextField(
                          controller: controller.textController,
                          maxLines: null,
                          minLines: 1,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: "Kirim pesan ke admin...",
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.grey.shade500,
                              fontWeight: AllMaterial.fontRegular,
                            ),
                          ),
                          // onSubmitted: (_) => controller.postChatMessages(),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      AllMaterial.messageScaffold(
                        title: "Fitur sedang digarap, coba lagi nanti!",
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
