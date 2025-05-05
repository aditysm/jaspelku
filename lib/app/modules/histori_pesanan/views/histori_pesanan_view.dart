import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaspelku/all_material.dart';
import 'package:jaspelku/app/modules/home/controllers/home_controller.dart';
import 'package:jaspelku/app/modules/main_page/views/main_page_view.dart';

import '../controllers/histori_pesanan_controller.dart';

var showMedia = false.obs;

class HistoriPesananView extends GetView<HistoriPesananController> {
  const HistoriPesananView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HistoriPesananController());
    final pesanan = {
      'id': 'JAS123456',
      'status': 'Selesai',
      'servant': 'Nama Servant ',
      'waktu': '2 Mei 2025, 10:15',
      'jasa': 'Angkut Barang',
      'alamat': 'Jl. Mawar No. 12, Jakarta',
      'jam_kerja': "8 jam (12.00 - 20.00)",
      'hari_kerja': [
        "Senin",
        "Selasa",
        "Rabu",
        "Minggu",
      ],
      'metode_pembayaran': 'Jaspel Coin',
      'harga': 150000,
      'ongkir': 20000,
      'total': 170000,
    };

    final isBayar = Get.arguments?["isBayar"] == true;
    final isPesananAktif = Get.arguments?["isPesananAktif"] == true;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isBayar
              ? "Pembayaran"
              : isPesananAktif
                  ? "Pesanan Saat Ini"
                  : 'Histori ${AllMaterial.isServant.isTrue ? "Pelayanan" : "Pemesanan"}',
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              // Status Pesanan
              isBayar
                  ? SizedBox.shrink()
                  : Container(
                      margin: EdgeInsets.only(
                        top: 16,
                      ),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isPesananAktif
                            ? AllMaterial.colorPrimaryShade
                            : Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Pesanan ${isPesananAktif ? "Diproses" : pesanan['status']}",
                        style: TextStyle(
                          fontWeight: AllMaterial.fontMedium,
                          color: AllMaterial.colorWhite,
                          fontSize:
                              Theme.of(context).textTheme.titleMedium?.fontSize,
                        ),
                      ),
                    ),
              SizedBox(height: 20),

              // Info Pesanan
              Text("Detil Pesanan",
                  style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: 10),
              _rowInfo("ID Pesanan : ", pesanan['id'].toString()),
              _rowInfo("Waktu Pesan : ", pesanan['waktu'].toString()),
              _rowInfo("Layanan : ", pesanan['jasa'].toString()),
              _rowInfo("Lokasi Kerja : ", pesanan['alamat'].toString()),
              _rowInfo("Catatan : ", "Minta tolong bang"),
              SizedBox(height: 20),

              // Rincian Biaya
              Text("Rincian Pembayaran",
                  style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: 10),
              _rowInfo("Harga Jasa: ", "Rp${pesanan['harga']}"),
              _rowInfo("Ongkos Kirim : ", "Rp${pesanan['ongkir']}"),
              _rowInfo(
                  "Metode Pembayaran : ", "${pesanan['metode_pembayaran']}"),
              Divider(),
              _rowInfo(
                "Total Pesanan : ",
                "Rp${pesanan['total']}",
                isBold: true,
                context: context,
              ),

              if (isBayar) ...[
                const SizedBox(height: 30),
                Text("Pilih Metode Pembayaran",
                    style: Theme.of(context).textTheme.titleMedium),
                SizedBox(height: 10),
                Obx(() => RadioListTile<MetodePembayaran>(
                      value: MetodePembayaran.jaspelCoin,
                      groupValue: controller.selectedMethod.value,
                      title: const Text("Jaspel Coin"),
                      subtitle: const Text("Bayar dengan saldo coin"),
                      onChanged: (value) {
                        if (value != null) controller.changeMethod(value);
                      },
                    )),
                Obx(() => RadioListTile<MetodePembayaran>(
                      value: MetodePembayaran.midtrans,
                      groupValue: controller.selectedMethod.value,
                      title: const Text("Midtrans"),
                      subtitle: const Text("Pembayaran QRIS/Virtual Account"),
                      onChanged: (value) {
                        if (value != null) controller.changeMethod(value);
                      },
                    )),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: AllMaterial.cusButton(
            label: isBayar
                ? "Bayar Sekarang"
                : isPesananAktif
                    ? "Ajukan Pembatalanan"
                    : "Lihat Ulasan",
            onTap: () {
              if (isBayar) {
                if (controller.selectedMethod.value == null) {
                  null;
                }
                if (controller.selectedMethod.value ==
                    MetodePembayaran.jaspelCoin) {
                  AllMaterial.cusDialogValidasi(
                    title: "Membayar Pesanan?",
                    subtitle: "Aksi setelahnya tidak dapat dibatalkan",
                    onConfirm: () {
                      HomeController.isPesananAktif.value = true;
                      Get.offAll(() => MainPageView());
                      AllMaterial.messageScaffold(
                          title:
                              "Pesanan telah dibayar! Servant akan diberitahu");
                    },
                    onCancel: () => Get.back(),
                  );
                } else {
                  AllMaterial.cusDialogValidasi(
                    title: "Membayar Pesanan?",
                    subtitle: "Aksi setelahnya tidak dapat dibatalkan",
                    onConfirm: () {
                      controller.bayarSekarang();
                    },
                    onCancel: () => Get.back(),
                  );
                }
              } else if (isPesananAktif) {
                AllMaterial.cusDialogValidasi(
                  title: "Membatalkan Pesanan?",
                  subtitle:
                      "${AllMaterial.isServant.value ? "Vendee" : "Servant"} akan diberitahu",
                  onConfirm: () {
                    HomeController.isPesananAktif.value = false;
                    Get.back();
                    AllMaterial.messageScaffold(
                      title: AllMaterial.isServant.value
                          ? "Ajuan pembatalan berhasil!"
                          : "Pesanan berhasil dibatalkan!",
                      adaKendala: true,
                      kendalaTitle: "Laporkan",
                      kendalaTap: () {},
                    );
                  },
                  onCancel: () => Get.back(),
                );
              } else {
                showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: AllMaterial.isDarkMode.isFalse
                      ? AllMaterial.colorWhite
                      : null,
                  context: context,
                  builder: (context) {
                    return DraggableScrollableSheet(
                      initialChildSize: 0.6,
                      minChildSize: 0.3,
                      maxChildSize: 1,
                      expand: false,
                      builder: (context, scrollController) {
                        return Column(
                          children: [
                            SizedBox(height: 20),
                            Container(
                              padding: EdgeInsets.all(15),
                              width: Get.height / 4.5,
                              height: 4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 20),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: SingleChildScrollView(
                                  controller: scrollController,
                                  child: ListView.builder(
                                    itemCount: controller.dataRating.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) =>
                                        AllMaterial.buildRating(context,
                                            controller.dataRating[index]),
                                  ),
                                ),
                              ),
                            ),
                            SafeArea(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: AllMaterial.cusButton(
                                  label: "Tutup Ulasan",
                                  icon: Icon(Icons.clear,
                                      color: AllMaterial.colorWhite),
                                  onTap: () => Get.back(),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _rowInfo(String label, String value,
      {bool isBold = false, BuildContext? context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text(label)),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                fontSize: isBold
                    ? Theme.of(context!).textTheme.titleMedium?.fontSize
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
