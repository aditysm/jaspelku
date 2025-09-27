import 'package:get/get.dart';

class PengaturanPembayaranController extends GetxController {
  var saldo = 150000.obs;
  var autoPayment = false.obs;
  var notifikasiPembayaran = true.obs;

  var historiPembayaran = <Map<String, dynamic>>[
    {
      'deskripsi': 'Bayar Jasa Angkut Barang',
      'tanggal': '01 Mei 2025',
      'jumlah': 50000,
    },
    {
      'deskripsi': 'Bayar Jasa Jaga Pasien',
      'tanggal': '15 April 2025',
      'jumlah': 30000,
    },
  ].obs;

  void topUp() {
    // Simulasi top up
    saldo.value += 10000;
  }

  void toggleAutoPayment(bool value) {
    autoPayment.value = value;
  }

  void toggleNotifikasi(bool value) {
    notifikasiPembayaran.value = value;
  }
}
