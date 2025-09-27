import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaspelku/app/utils/all_material.dart';
import 'package:jaspelku/app/utils/toast_dialog.dart';
import '../controllers/event_promo_controller.dart';

class EventPromoView extends GetView<EventPromoController> {
  const EventPromoView({super.key});

  void showDetailBottomSheet(
    BuildContext context, {
    required String title,
    required String type,
  }) {
    String description = '';
    String terms = '';

    switch (type) {
      case 'Promo':
        description = 'Ini adalah deskripsi promo untuk "$title".';
        terms =
            'Syarat & Ketentuan:\n- Berlaku hingga akhir bulan\n- Tidak dapat digabung dengan promo lain.';
        break;
      case 'Event':
        description = 'Ini adalah deskripsi event untuk "$title".';
        break;
      default:
        description = 'Informasi tambahan untuk "$title".';
        break;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor:
          AllMaterial.isDarkMode.isTrue ? Colors.grey[900] : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/logo/intro-1.jpg"),
                    ),
                  ),
                )),
                const SizedBox(height: 20),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(description),
                if (type == 'Promo') ...[
                  const SizedBox(height: 12),
                  Text(terms),
                ],
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: AllMaterial.cusButton(
                    label: type == 'Promo'
                        ? 'Gunakan Promo'
                        : type == 'Event'
                            ? 'Ikuti Event'
                            : 'Oke',
                    onTap: () {
                      Get.back();
                      ToastService.show(
                        '$type "$title" diproses.',
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildSection(
    BuildContext context,
    String title,
    List<String> items,
    IconData icon,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...items.map(
          (item) => Card(
            color:
                AllMaterial.isDarkMode.isTrue ? null : AllMaterial.colorWhite,
            elevation: 0,
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: ListTile(
              onTap: () => showDetailBottomSheet(
                context,
                title: item,
                type: title.contains('Promo')
                    ? 'Promo'
                    : title.contains('Event')
                        ? 'Event'
                        : 'Lainnya',
              ),
              leading: Icon(icon, color: AllMaterial.colorPrimary),
              title: Text(item),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EventPromoController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event & Promo'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSection(
                    context,
                    'Promo Aktif',
                    controller.activePromos,
                    Icons.local_offer,
                  ),
                  buildSection(
                    context,
                    'Event Pengguna',
                    controller.userEvents,
                    Icons.event,
                  ),
                  buildSection(
                    context,
                    'Lainnya',
                    controller.otherItems,
                    Icons.info,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
