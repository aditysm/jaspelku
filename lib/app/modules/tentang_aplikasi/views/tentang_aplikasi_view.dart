import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/tentang_aplikasi_controller.dart';

class TentangAplikasiView extends GetView<TentangAplikasiController> {
  const TentangAplikasiView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TentangAplikasiController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Aplikasi'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Center(
              child: Icon(
                Icons.info_outline,
                size: 80,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              controller.appName.value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              "Versi ${controller.version.value} (Build ${controller.buildNumber.value})",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const Divider(height: 32),
            const ListTile(
              leading: Icon(Icons.developer_mode),
              title: Text("Pengembang"),
              subtitle: Text("Tim Pengembang Global Vintage Numeration"),
            ),
            const ListTile(
              leading: Icon(Icons.email),
              title: Text("Kontak"),
              subtitle: Text("support@domainkamu.com"),
            ),
            const ListTile(
              leading: Icon(Icons.lock),
              title: Text("Kebijakan Privasi"),
              subtitle: Text("Data Anda aman dan terenkripsi"),
            ),
            const ListTile(
              leading: Icon(Icons.policy),
              title: Text("Lisensi"),
              subtitle: Text("Aplikasi ini dilindungi"),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "© 2025 Bale Kotak GVINUM",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        );
      }),
    );
  }
}
