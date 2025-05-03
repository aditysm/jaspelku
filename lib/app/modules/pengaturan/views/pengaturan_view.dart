import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaspelku/all_material.dart';
import 'package:jaspelku/app/controller/general_controller.dart';
import '../controllers/pengaturan_controller.dart';

class PengaturanView extends GetView<PengaturanController> {
  const PengaturanView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PengaturanController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Obx(
            () => SwitchListTile(
              title: const Text("Mode Gelap"),
              value: AllMaterial.isDarkMode.value,
              onChanged: controller.toggleDarkMode,
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Tentang Aplikasi'),
            subtitle: const Text('Versi, pengembang, dan lainnya'),
            leading: const Icon(Icons.info_outline),
            onTap: () {
              // aksi untuk buka halaman tentang
            },
          ),
          ListTile(
            title: const Text('Kebijakan Privasi'),
            leading: const Icon(Icons.privacy_tip_outlined),
            onTap: () {
              // aksi untuk buka halaman kebijakan
            },
          ),
          ListTile(
            title: const Text('Hubungi Admin'),
            subtitle: const Text('Keluhan, sistem dan lainnya'),
            leading: const Icon(
              Icons.headset_mic_outlined,
            ),
            onTap: () {
              // aksi untuk buka halaman kebijakan
            },
          ),
          ListTile(
            title: Text(
              "Logout",
              style: TextStyle(
                color: Colors.red,
                fontWeight: AllMaterial.fontSemiBold,
              ),
            ),
            subtitle: Text(
              "Keluar dari Akun saat ini",
              style: TextStyle(color: Colors.red),
            ),
            leading: Icon(Icons.logout, color: Colors.red),
            onTap: () {
              AllMaterial.cusDialogValidasi(
                title: "Logout",
                subtitle: "Anda akan keluar dari Akun saat ini",
                onConfirm: () {
                  var genController = Get.put(GeneralController());
                  genController.logout();
                },
                onCancel: Get.back,
              );
            },
          ),
        ],
      ),
    );
  }
}
