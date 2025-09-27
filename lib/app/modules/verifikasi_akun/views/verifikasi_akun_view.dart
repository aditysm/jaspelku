import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaspelku/app/utils/all_material.dart';
import '../controllers/verifikasi_akun_controller.dart';

class VerifikasiAkunView extends GetView<VerifikasiAkunController> {
  const VerifikasiAkunView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifikasiAkunController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verifikasi Akun'),
        centerTitle: true,
      ),
      body: Obx(
        () => SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nama + centang
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 5,
                  runSpacing: 5,
                  children: [
                    AllMaterial.namaDenganVerified(
                      name: controller.namaUser.value,
                      isVerified: true,
                      isProfil: true,
                    ),
                    Text("(Akan ditampilkan seperti ini)")
                  ],
                ),
                const SizedBox(height: 24),

                const Text(
                  "Syarat Verifikasi Akun",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),

                const ListTile(
                  leading: Icon(Icons.badge),
                  title: Text("Identitas Diri"),
                  subtitle: Text(
                      "KTP / SIM / Paspor (upload foto), Nama lengkap, Tanggal lahir"),
                ),
                const ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text("Foto Selfie dengan Identitas"),
                  subtitle: Text(
                      "Untuk membuktikan bahwa identitas yang diunggah milik sendiri"),
                ),
                const ListTile(
                  leading: Icon(Icons.phone_android),
                  title: Text("Nomor Telepon Aktif"),
                  subtitle:
                      Text("Untuk menerima kode OTP sebagai bukti kepemilikan"),
                ),
                const ListTile(
                  leading: Icon(Icons.home),
                  title: Text("Alamat Lengkap"),
                  subtitle: Text("Domisili atau alamat tetap"),
                ),
                const ListTile(
                  leading: Icon(Icons.email),
                  title: Text("Email Aktif"),
                  subtitle:
                      Text("Akan menggunakan email yang telah diverifikasi"),
                ),
                const ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text("Foto Profil yang Jelas"),
                  subtitle: Text(
                      "Untuk tampilan profesional dan meningkatkan kepercayaan"),
                ),
                const ListTile(
                  leading: Icon(Icons.link),
                  title: Text("Akun Media Sosial (Opsional)"),
                  subtitle: Text(
                      "Instagram / Facebook / LinkedIn untuk membangun kepercayaan"),
                ),
                const ListTile(
                  leading: Icon(Icons.workspace_premium),
                  title: Text("Portofolio atau Bukti Keahlian (Opsional)"),
                  subtitle: Text(
                    "Sertifikat, hasil pekerjaan, atau proyek sebelumnya",
                  ),
                ),

                const ListTile(
                  leading: Icon(Icons.account_balance),
                  title: Text("Rekening Bank"),
                  subtitle:
                      Text("Untuk pencairan pembayaran dan keamanan transaksi"),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 20, vertical: context.mediaQueryPadding.bottom / 2),
          child: AllMaterial.cusButton(
            icon: Icon(
              Icons.verified,
              color: AllMaterial.colorWhite,
            ),
            label: "Mulai Verifikasi",
            onTap: () {
              controller.mulaiVerifikasiModal(context);
            },
          ),
        ),
      ),
    );
  }
}
