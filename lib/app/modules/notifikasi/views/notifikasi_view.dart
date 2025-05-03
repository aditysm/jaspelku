import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jaspelku/all_material.dart';

import '../controllers/notifikasi_controller.dart';

class NotifikasiView extends GetView<NotifikasiController> {
  const NotifikasiView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final controller = Get.put(NotifikasiController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi Saya'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Obx(() {
        final grouped = _groupByTanggal(controller.listNotifikasi);

        if (controller.listNotifikasi.isEmpty) {
          return Center(child: Text("Belum ada notifikasi."));
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          itemCount: grouped.length,
          itemBuilder: (context, index) {
            final entry = grouped.entries.elementAt(index);
            final tanggalLabel =
                DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(entry.key);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    tanggalLabel,
                    style: textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ...entry.value.map((n) => _notifTile(n)),
              ],
            );
          },
        );
      }),
    );
  }

  Widget _notifTile(NotifikasiModel notif) {
    IconData icon;
    Color iconColor;

    switch (notif.tipe) {
      case 'chat':
        icon = Icons.chat_bubble_outline;
        iconColor = Colors.green;
        break;
      case 'promo':
        icon = Icons.local_offer_outlined;
        iconColor = Colors.blueAccent;
        break;
      default:
        icon = Icons.notifications_none;
        iconColor = AllMaterial.colorPrimary;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Material(
        color: AllMaterial.isDarkMode.isTrue
            ? notif.terbaca
                ? Colors.transparent
                : AllMaterial.colorBlackPrimary.withOpacity(0.5)
            : notif.terbaca
                ? Colors.transparent
                : AllMaterial.colorComplementaryBlueShade,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: notif.onTap,
          onLongPress: () {
            Get.bottomSheet(
              Material(
                color: AllMaterial.isDarkMode.isTrue
                    ? AllMaterial.colorBlackPrimary
                    : Colors.white,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      (notif.terbaca)
                          ? SizedBox.shrink()
                          : ListTile(
                              leading: const Icon(Icons.done_all),
                              title: const Text('Tandai sudah dibaca'),
                              onTap: () {
                                Get.back();
                              },
                            ),
                      ListTile(
                        leading: const Icon(Icons.delete_outline),
                        title: const Text('Hapus Notifikasi'),
                        onTap: () {
                          controller.listNotifikasi.remove(notif);
                          Get.back();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: iconColor, size: 26),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notif.judul,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notif.isi,
                        style: const TextStyle(fontSize: 13),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        DateFormat.Hm().format(notif.tanggal),
                        style: TextStyle(
                          fontSize: 11,
                          color: AllMaterial.isDarkMode.isFalse
                              ? Colors.grey[600]
                              : Colors.grey[400],
                        ),
                      ),
                      if (notif.showAction && notif.actionLabel != null) ...[
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: notif.onActionTap,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: iconColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              notif.actionLabel!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Mengelompokkan notifikasi berdasarkan tanggal (tanpa waktu)
  Map<DateTime, List<NotifikasiModel>> _groupByTanggal(
      List<NotifikasiModel> list) {
    Map<DateTime, List<NotifikasiModel>> map = {};
    for (var n in list) {
      final date = DateTime(n.tanggal.year, n.tanggal.month, n.tanggal.day);
      if (!map.containsKey(date)) {
        map[date] = [];
      }
      map[date]!.add(n);
    }
    return Map.fromEntries(
        map.entries.toList()..sort((a, b) => b.key.compareTo(a.key)));
  }
}
