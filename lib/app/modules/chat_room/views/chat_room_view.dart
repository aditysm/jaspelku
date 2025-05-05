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
    print(AllMaterial.isServant.value);
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
          Obx(
            () => AllMaterial.isServant.isFalse
                ? IconButton(
                    icon: const Icon(Icons.swap_horizontal_circle_outlined),
                    tooltip: "Ajukan Tawaran",
                    onPressed: () {
                      Get.to(() => PostinganBaruView(), arguments: {
                        "isTawaranBaru": true,
                      });
                    },
                  )
                : SizedBox.shrink(),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              AllMaterial.messageScaffold(title: "Menampilkan aksi lainnya");
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                var messages = controller.messages;
                String? lastDateLabel;
                var errorMap = controller.systemErrors;
                var allTimestamps = [
                  ...messages.map((m) => m.timestamp),
                  ...errorMap.keys,
                ]..sort();

                if (controller.isLoading.isTrue && messages.isEmpty) {
                  return Center();
                } else if (messages.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.mark_unread_chat_alt_rounded,
                            size: 80, color: Colors.grey),
                        const SizedBox(height: 16),
                        Text(
                          "Belum ada pesan",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Ayo mulai percakapan sekarang!",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  );
                } else {
                  return ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    itemCount: allTimestamps.length,
                    itemBuilder: (context, index) {
                      // final dateLabel = getLabelForDate(msg.timestamp);
                      final time = allTimestamps[index];
                      final dateLabel = getLabelForDate(time);
                      final showLabel = lastDateLabel != dateLabel;
                      lastDateLabel = dateLabel;
                      final message =
                          messages.firstWhereOrNull((m) => m.timestamp == time);
                      final error = errorMap[time];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (showLabel)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: AllMaterial.isDarkMode.isFalse
                                        ? AllMaterial
                                            .colorComplementaryBlueShade
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
                          if (error != null)
                            Center(
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 12),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade100,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  error,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          else if (message != null)
                            Align(
                              alignment:
                                  message.senderId == controller.currentUserId
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                padding: const EdgeInsets.all(10),
                                constraints: BoxConstraints(
                                  maxWidth: Get.width * 0.75,
                                ),
                                decoration: BoxDecoration(
                                  color: message.senderId ==
                                          controller.currentUserId
                                      ? AllMaterial.isDarkMode.isTrue
                                          ? AllMaterial.colorPrimary
                                          : AllMaterial.colorPrimaryShade
                                      : AllMaterial.isDarkMode.isTrue
                                          ? AllMaterial.colorBlackPrimary
                                          : AllMaterial
                                              .colorComplementaryBlueShade,
                                  borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(12),
                                    topRight: const Radius.circular(12),
                                    bottomLeft: message.senderId ==
                                            controller.currentUserId
                                        ? const Radius.circular(12)
                                        : const Radius.circular(0),
                                    bottomRight: message.senderId ==
                                            controller.currentUserId
                                        ? const Radius.circular(0)
                                        : const Radius.circular(12),
                                  ),
                                ),
                                child: IntrinsicWidth(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        message.text,
                                        style: TextStyle(
                                          color: message.senderId ==
                                                  controller.currentUserId
                                              ? AllMaterial.colorWhite
                                              : null,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          AllMaterial.jamMenit(message.timestamp
                                              .toIso8601String()),
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: message.senderId ==
                                                    controller.currentUserId
                                                ? AllMaterial.colorGreySecondary
                                                : Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  );
                }
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
                          focusNode: controller.textNode,
                          controller: controller.textController,
                          onTapOutside: (_) {
                            controller.textNode.unfocus();
                          },
                          maxLines: null,
                          minLines: 1,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: "Kirim pesan...",
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.grey.shade500,
                              fontWeight: AllMaterial.fontRegular,
                            ),
                          ),
                          onSubmitted: (_) => controller.sendMessage(),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      controller.sendMessage();
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
