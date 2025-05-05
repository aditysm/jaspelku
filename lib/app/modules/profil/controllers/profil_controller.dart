import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilController extends GetxController {
  var showFullDescription = true.obs;

  var histori = <dynamic>[].obs;

  final scrollController = ScrollController();
  var showTitle = false.obs;

  final RxList<Map<String, Object>> dataRating = <Map<String, Object>>[
    {
      'id': '2',
      'nama': 'Budi',
      'waktu': DateTime.now().subtract(Duration(minutes: 10)),
      'judul': 'Jasa Angkut Barang',
      'deskripsi':
          "Pelayanan cepat dan ramah! Barang sampai dengan aman tanpa kerusakan. Sopir juga sangat membantu saat proses angkut. Sangat direkomendasikan!",
      'tags': ['Angkut', 'Panggilan'],
      'harga': 'Rp200.000 - 300.000',
      'rating': 4,
      'jam_kerja': "8 jam (12.00 - 20.00)",
      'hari_kerja': [
        "Senin",
        "Selasa",
        "Rabu",
        "Minggu",
      ],
      'media': [
        "assets/logo/spesialis.jpg",
      ]
    },
  ].obs;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    showTitle.value = scrollController.offset > 20;
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
