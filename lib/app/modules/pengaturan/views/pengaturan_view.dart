import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaspelku/app/utils/all_material.dart';
import 'package:jaspelku/app/controller/general_controller.dart';
import 'package:jaspelku/app/modules/edit_profil/views/edit_profil_view.dart';
import 'package:jaspelku/app/modules/event_promo/views/event_promo_view.dart';
import 'package:jaspelku/app/modules/kebijakan_privasi/views/kebijakan_privasi_view.dart';
import 'package:jaspelku/app/modules/pengaturan_pembayaran/views/pengaturan_pembayaran_view.dart';
import 'package:jaspelku/app/modules/syarat_ketentuan/views/syarat_ketentuan_view.dart';
import 'package:jaspelku/app/modules/tentang_aplikasi/views/tentang_aplikasi_view.dart';
import 'package:jaspelku/app/modules/verifikasi_pengguna/views/verifikasi_pengguna_view.dart';
import 'package:jaspelku/app/utils/toast_dialog.dart';
import 'package:permission_handler/permission_handler.dart';
import '../controllers/pengaturan_controller.dart';

class PengaturanView extends GetView<PengaturanController> {
  @override
  final controller = Get.put(PengaturanController());
  PengaturanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            ListTile(
              title: const Text(
                'Pengaturan Pengguna',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            ListTile(
              title: const Text('Edit Profil'),
              subtitle:
                  const Text('Ubah foto profil, nama, dan informasi lainnya'),
              leading: const Icon(Icons.edit_outlined),
              onTap: () {
                Get.to(() => EditProfilView());
              },
            ),
            ListTile(
              title: const Text('Verifikasi Akun'),
              subtitle: const Text('Verifikasi email atau nomor telepon Anda'),
              leading: const Icon(Icons.verified_outlined),
              onTap: () {
                Get.to(() => VerifikasiPenggunaView());
              },
            ),
            const Divider(),
            ListTile(
              title: const Text(
                'Tampilan',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Obx(
              () => SwitchListTile(
                title: const Text("Mode Gelap"),
                value: AllMaterial.isDarkMode.value,
                onChanged: controller.toggleDarkMode,
              ),
            ),
            const Divider(),
            // Kategori Syarat & Ketentuan
            ListTile(
              title: const Text(
                'Pengaturan Aplikasi',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            ListTile(
              title: const Text('Syarat & Ketentuan'),
              leading: const Icon(Icons.rule_sharp),
              onTap: () {
                Get.to(() => SyaratKetentuanView());
              },
            ),
            ListTile(
              title: const Text('Preferensi Akses'),
              subtitle:
                  const Text('Kelola akses lokasi GPS, kamera & penyimpanan'),
              leading: const Icon(Icons.rule_folder_outlined),
              onTap: () {
                openAppSettings();
              },
            ),
            ListTile(
              title: const Text('Pengaturan Pembayaran'),
              subtitle: const Text('Metode pembayaran & jaspel coin'),
              leading: const Icon(Icons.payment_outlined),
              onTap: () {
                Get.to(() => PengaturanPembayaranView());
              },
            ),
            ListTile(
              title: const Text('Event & Promo'),
              subtitle: const Text('Lihat promo aktif dan event pengguna'),
              leading: const Icon(Icons.local_offer_outlined),
              onTap: () {
                Get.to(() => EventPromoView());
              },
            ),
            ListTile(
              title: const Text('Update Aplikasi'),
              subtitle: const Text('Cek versi terbaru & pembaruan sistem'),
              leading: const Icon(Icons.system_update_alt_outlined),
              onTap: () {
                // aksi untuk cek pembaruan aplikasi
                ToastService.show("Tidak ada update terbaru!");
              },
            ),
            ListTile(
              title: const Text('Umpan Balik Pengguna'),
              subtitle: const Text('Bantu kami meningkatkan aplikasi'),
              leading: const Icon(Icons.feedback_outlined),
              onTap: () {
                AllMaterial.umpanPengguna(context);
              },
            ),
            const Divider(),
            // Kategori Tentang Aplikasi
            ListTile(
              title: const Text(
                'Tentang Aplikasi',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            ListTile(
              title: const Text('Tentang Aplikasi'),
              subtitle: const Text('Versi, pengembang, dan lainnya'),
              leading: const Icon(Icons.info_outline),
              onTap: () {
                Get.to(() => TentangAplikasiView());
              },
            ),
            ListTile(
              title: const Text('Kebijakan Privasi'),
              leading: const Icon(Icons.privacy_tip_outlined),
              onTap: () {
                Get.to(() => KebijakanPrivasiView());
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
      ),
    );
  }
}
