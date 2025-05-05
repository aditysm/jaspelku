import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jaspelku/all_material.dart';
import 'package:jaspelku/app/modules/chat_room/views/chat_room_view.dart';
import '../controllers/pesan_controller.dart';

class PesanView extends GetView<PesanController> {
  final ScrollController? pesanScrollController;
  const PesanView({super.key, this.pesanScrollController});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PesanController());

    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          var chatList = controller.isSearchingMessage.isTrue
              ? controller.filteredChat
              : controller.originalChatItem;
          if (chatList.isEmpty) {
            return const Center(child: Text("Tidak ada pesan terbaru"));
          }
          return ListView.builder(
            controller: pesanScrollController,
            itemCount: chatList.length,
            itemBuilder: (context, index) {
              final chat = chatList[index];

              return ListTile(
                onTap: () {
                  Get.to(() => ChatRoomView(), arguments: {
                    "nama": chat.senderName,
                    "isVerified": chat.isVerified,
                    "id": index + 1,
                  });
                },
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      DateFormat.Hm('id_ID').format(chat.timestamp),
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 5),
                    CircleAvatar(
                      backgroundColor: AllMaterial.colorPrimary,
                      radius: 13,
                      child: Text(
                        "1",
                        style: TextStyle(
                          color: AllMaterial.colorWhite,
                          fontSize: 13,
                          fontWeight: AllMaterial.fontSemiBold,
                        ),
                      ),
                    )
                  ],
                ),
                leading: CircleAvatar(
                  backgroundColor: AllMaterial.colorPrimary,
                  child: Text(
                    chat.senderName[0],
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                horizontalTitleGap: 15,
                title: AllMaterial.namaDenganVerified(
                  name: AllMaterial.formatNamaPanjang(
                    chat.senderName,
                  ),
                  isVerified: chat.isVerified,
                ),
                subtitle: Text(
                  chat.message,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        tooltip: "Hubungi Admin",
        backgroundColor: AllMaterial.colorPrimary,
        child: Icon(
          color: AllMaterial.colorWhite,
          Icons.headset_mic_sharp,
        ),
        onPressed: () {
          AllMaterial.messageScaffold(title: "Menampilkan chat admin");
        },
      ),
    );
  }
}
