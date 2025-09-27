import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaspelku/app/utils/all_material.dart';
import 'package:jaspelku/app/modules/histori_pesanan/views/histori_pesanan_view.dart';
import '../controllers/pengaturan_pembayaran_controller.dart';

class PengaturanPembayaranView extends GetView<PengaturanPembayaranController> {
  const PengaturanPembayaranView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PengaturanPembayaranController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan Pembayaran'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 1. Dashboard Saldo
            Obx(() => Card(
                  elevation: 0,
                  color: AllMaterial.isDarkMode.isTrue
                      ? null
                      : AllMaterial.colorWhite,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: const Icon(Icons.account_balance_wallet,
                        color: Colors.orange),
                    title: const Text("Saldo Jaspel Coin"),
                    subtitle: Text(
                      "IDR ${AllMaterial.formatHarga(controller.saldo.value)}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: AllMaterial.isDarkMode.isTrue
                            ? AllMaterial.colorWhite
                            : AllMaterial.colorPrimary,
                      ),
                      onPressed: controller.topUp,
                      child: Text(
                        "Top Up",
                        style: TextStyle(
                          color: AllMaterial.isDarkMode.isTrue
                              ? null
                              : AllMaterial.colorWhite,
                        ),
                      ),
                    ),
                  ),
                )),
            const SizedBox(height: 20),

            // 🔹 2. Pengaturan Terkait Pembayaran
            const Text(
              "Pengaturan Pembayaran",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Obx(() => SwitchListTile(
                  value: controller.autoPayment.value,
                  onChanged: controller.toggleAutoPayment,
                  title: const Text("Pembayaran Otomatis"),
                  subtitle: const Text("Bayar otomatis saat tagihan tersedia"),
                )),
            Obx(() => SwitchListTile(
                  value: controller.notifikasiPembayaran.value,
                  onChanged: controller.toggleNotifikasi,
                  title: const Text("Notifikasi Pembayaran"),
                  subtitle: const Text("Kirim notifikasi saat jatuh tempo"),
                )),
            const SizedBox(height: 20),

            // 🔹 3. Histori Pembayaran
            const Text(
              "Riwayat Pembayaran",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Obx(() {
              if (controller.historiPembayaran.isEmpty) {
                return const Text("Belum ada histori pembayaran.");
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.historiPembayaran.length,
                itemBuilder: (context, index) {
                  final item = controller.historiPembayaran[index];
                  final harga = AllMaterial.formatHarga(item['jumlah'] ?? 0);
                  return ListTile(
                    onTap: () {
                      Get.to(() => HistoriPesananView());
                    },
                    leading: const Icon(Icons.receipt_long),
                    title: Text(item['deskripsi']),
                    subtitle: Text(item['tanggal']),
                    trailing: Text(
                      "-Rp$harga",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
