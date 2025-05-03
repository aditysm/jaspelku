import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaspelku/app/modules/histori_pesanan/views/histori_pesanan_view.dart';

class NotifikasiController extends GetxController {
  var listNotifikasi = <NotifikasiModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    listNotifikasi.addAll([
      NotifikasiModel(
        judul: "Pesanan diterima",
        isi: "Pesanan kamu telah diterima oleh mitra.",
        tanggal: DateTime.now().subtract(Duration(minutes: 10)),
        tipe: "sistem",
        showAction: true,
        terbaca: false,
        actionLabel: "Bayar Tawaran",
        onActionTap: () {
          Get.to(() => HistoriPesananView(), arguments: {
            "isBayar": true,
          });
          print("Bayar bos");
        },
      ),
      NotifikasiModel(
        judul: "Diskon Spesial Hari Ini!",
        isi: "Dapatkan potongan hingga 40% untuk layanan tertentu.",
        tanggal: DateTime.now().subtract(Duration(hours: 2)),
        tipe: "promo",
        showAction: true,
        actionLabel: "Lihat Promo",
        onActionTap: () {
          print("Promo dibuka!");
        },
      ),
      NotifikasiModel(
        judul: "Pesanan selesai",
        isi: "Pesanan kamu telah selesai kemarin.",
        tanggal: DateTime.now().subtract(Duration(days: 1, hours: 2)),
        tipe: "sistem",
        showAction: true,
        actionLabel: "Beri Ulasan",
        onActionTap: () {
          print("Bintang limanya kk");
        },
      ),
      NotifikasiModel(
        judul: "Pesan Baru dari Admin",
        isi: "Silakan isi form evaluasi pengalamanmu.",
        tanggal: DateTime.now().subtract(Duration(days: 1, hours: 3)),
        tipe: "chat",
        showAction: true,
        actionLabel: "Buka Pesan",
        onActionTap: () {
          print("Pesan dibuka!");
        },
      ),
      NotifikasiModel(
        judul: "Update Aplikasi Tersedia",
        isi: "Versi terbaru kini tersedia dengan fitur baru.",
        tanggal: DateTime.now().subtract(Duration(days: 3)),
        tipe: "sistem",
        terbaca: false,
      ),
      NotifikasiModel(
        judul: "Event Spesial Minggu Ini",
        isi: "Ikuti webinar eksklusif dengan narasumber ternama.",
        tanggal: DateTime.now().subtract(Duration(days: 5)),
        tipe: "promo",
      ),
    ]);
  }
}

class NotifikasiModel {
  final String judul;
  final String isi;
  final DateTime tanggal;
  final bool terbaca;
  final String tipe;
  final VoidCallback? onTap;
  final bool showAction;
  final String? actionLabel;
  final VoidCallback? onActionTap;

  NotifikasiModel({
    required this.judul,
    required this.isi,
    required this.tanggal,
    this.terbaca = true,
    this.tipe = 'sistem',
    this.onTap,
    this.showAction = false,
    this.actionLabel,
    this.onActionTap,
  });
}
