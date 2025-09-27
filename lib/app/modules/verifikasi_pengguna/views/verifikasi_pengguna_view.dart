import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaspelku/app/utils/all_material.dart';
import 'package:jaspelku/app/modules/syarat_ketentuan/views/syarat_ketentuan_view.dart';
import 'package:jaspelku/app/modules/verifikasi_akun/views/verifikasi_akun_view.dart';
import '../controllers/verifikasi_pengguna_controller.dart';

class VerifikasiPenggunaView extends GetView<VerifikasiPenggunaController> {
  const VerifikasiPenggunaView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifikasiPenggunaController());
    var isServant = AllMaterial.isServant.value;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verifikasi Akun Anda',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isServant
                ? buildVerificationSection(
                    context,
                    "Akun",
                    controller.isAccountVerified,
                    "Verifikasi Akun",
                    Icons.verified_outlined,
                  )
                : SizedBox.shrink(),

            // Verifikasi Email
            buildVerificationSection(
              context,
              'Email',
              controller.emailVerified,
              'Verifikasi Email',
              Icons.email_outlined,
            ),

            // Verifikasi Nomor Telepon
            buildVerificationSection(
              context,
              'Nomor Telepon',
              controller.phoneVerified,
              'Verifikasi Nomor Telepon',
              Icons.phone_outlined,
            ),
            const SizedBox(height: 20),
            Text(
              'Pastikan email dan nomor telepon Anda terverifikasi untuk menjaga keamanan akun.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildVerificationSection(
    BuildContext context,
    String title,
    RxBool isVerified,
    String buttonText,
    IconData icon,
  ) {
    return Card(
      elevation: 0,
      color: AllMaterial.isDarkMode.isTrue ? null : AllMaterial.colorWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, color: Theme.of(context).primaryColor, size: 28),
                    const SizedBox(width: 12),
                    Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Obx(() => Row(
                      children: [
                        Icon(
                          isVerified.value ? Icons.check_circle : Icons.error,
                          color: isVerified.value ? Colors.green : Colors.red,
                          size: 22,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          isVerified.value
                              ? 'Terverifikasi'
                              : 'Belum Terverifikasi',
                          style: TextStyle(
                            color: isVerified.value ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
            isVerified.isTrue ? SizedBox.shrink() : SizedBox(height: 16),
            Obx(
              () => isVerified.value
                  ? SizedBox.shrink()
                  : AllMaterial.cusButton(
                      onTap: isVerified.value
                          ? null
                          : () => showVerificationModal(context, title),
                      label: buttonText,
                      addIcon: true,
                      icon: (!isVerified.value)
                          ? const Icon(
                              Icons.check_circle_outline,
                              size: 18,
                              color: Colors.white,
                            )
                          : null,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Menampilkan Modal Bottom Sheet
  void showVerificationModal(BuildContext context, String title) {
    var isDark = AllMaterial.isDarkMode.value;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          maxChildSize: 1,
          minChildSize: 0.3,
          initialChildSize: 1,
          builder: (BuildContext context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: isDark
                    ? Theme.of(context).cardColor
                    : AllMaterial.colorWhite,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Indikator swipe
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: 5,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Verifikasi $title',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        if (title == "Akun") ...[
                          ListTile(
                            leading: Icon(Icons.verified, color: Colors.green),
                            title: Text("Meningkatkan Kredibilitas"),
                            subtitle: Text(
                                "Profil Anda terlihat lebih profesional dan terpercaya."),
                          ),
                          ListTile(
                            leading: Icon(Icons.search, color: Colors.blue),
                            title: Text("Prioritas di Hasil Pencarian"),
                            subtitle: Text(
                                "Muncul lebih atas saat vendee mencari jasa."),
                          ),
                          ListTile(
                            leading:
                                Icon(Icons.lock_open, color: Colors.orange),
                            title: Text("Akses Fitur Eksklusif"),
                            subtitle: Text(
                                "Seperti statistik profil dan testimoni premium."),
                          ),
                          ListTile(
                            leading:
                                Icon(Icons.handshake, color: Colors.purple),
                            title: Text("Mudah Mendapat Vendee"),
                            subtitle: Text(
                                "Meningkatkan peluang dipilih oleh calon pelanggan."),
                          ),
                          ListTile(
                            leading: Icon(Icons.security, color: Colors.red),
                            title: Text("Keamanan Lebih Baik"),
                            subtitle: Text(
                                "Perlindungan ekstra dari penyalahgunaan akun."),
                          ),
                          const SizedBox(height: 20),
                          AllMaterial.cusButton(
                            label: "Lanjutkan Verifikasi",
                            onTap: () {
                              if (title == "Akun") {
                                Get.back();
                                Get.to(() => VerifikasiAkunView());
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text:
                                  "Dengan melanjutkan, Anda menyetujui & menerima\n",
                              style: TextStyle(
                                color: AllMaterial.isDarkMode.value
                                    ? AllMaterial.colorWhite
                                    : AllMaterial.colorBlackPrimary,
                              ),
                              children: [
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.to(() => SyaratKetentuanView());
                                    },
                                  text: "Syarat & Ketentuan Jaspelku",
                                  style: TextStyle(
                                    fontWeight: AllMaterial.fontSemiBold,
                                    decoration: TextDecoration.underline,
                                    decorationColor:
                                        AllMaterial.colorPrimaryShade,
                                    color: AllMaterial.colorPrimaryShade,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ] else ...[
                          // Form verifikasi email/telepon
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '$title',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text("Kirim Kode OTP"),
                              ),
                            ],
                          ),
                          AllMaterial.textField(
                            labelText: title == "Email"
                                ? 'Masukkan Email...'
                                : 'Masukkan Nomor Telepon...',
                            textInputType: title == "Email"
                                ? TextInputType.emailAddress
                                : TextInputType.phone,
                            limit: title == 'Email' ? null : 13,
                          ),

                          const SizedBox(height: 10),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Kode OTP',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Opacity(
                                opacity: 0,
                                child: Text(""),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          AllMaterial.textField(
                            labelText: "Masukkan kode OTP",
                            textInputType: TextInputType.numberWithOptions(),
                            limit: 6,
                          ),

                          const SizedBox(height: 20),
                          AllMaterial.cusButton(
                            label: "Verifikasi $title",
                            onTap: () {
                              // controller.verifyAccount();
                              Get.back();
                            },
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Tidak menerima kode?",
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Kirim Ulang",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
