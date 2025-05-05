import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LayananController extends GetxController {
  ValueNotifier<bool> hideUI = ValueNotifier(false);

  final layananController = TextEditingController();
  var isSearching = false.obs;
  final searchQuery = ''.obs;

  final postinganSaya = {
    'id': '1',
    'nama': 'Kamu',
    'waktu': DateTime.now().subtract(Duration(minutes: 2)),
    'deskripsi':
        "Layanan angkut barang profesional menawarkan solusi efisien dan aman untuk memenuhi kebutuhan transportasi barang dalam berbagai skala. Dengan tim yang terlatih dan pengalaman di bidang logistik, layanan ini memastikan barang Anda dipindahkan dengan hati-hati dan tepat waktu. Kami menyediakan berbagai jenis kendaraan sesuai dengan ukuran dan jenis barang, mulai dari barang kecil hingga barang besar dan berat.\n\nDengan menggunakan teknologi terbaru, kami memastikan proses angkutan berjalan lancar, meminimalisir risiko kerusakan, dan memberikan kepuasan bagi pelanggan. Apakah Anda pindahan rumah, memindahkan peralatan bisnis, atau membutuhkan pengiriman barang dalam jumlah besar, layanan kami siap memenuhi kebutuhan Anda dengan kualitas terbaik.",
    'judul': 'Jasa Servis',
    "jenis": 'Servis AC',
    "lokasi": "Panggilan",
    'harga': 'Rp100.000',
    "media": [
      "assets/logo/spesialis.jpg",
      "assets/logo/iot.jpg",
      "assets/logo/spesialis.jpg",
      "assets/logo/potrait.png",
      "assets/logo/iot.jpg",
    ]
  };

  final postinganLainnya = <Map<String, dynamic>>[
    {
      'id': '2',
      'nama': 'Budi',
      'waktu': DateTime.now().subtract(Duration(minutes: 10)),
      'deskripsi':
          "Dalam era digital ini, teknologi telah membawa perubahan signifikan dalam berbagai sektor, termasuk pendidikan. Akses ke internet memungkinkan kita untuk belajar kapan saja dan di mana saja, membuka peluang tak terbatas untuk memperoleh pengetahuan. Namun, di balik kemudahan tersebut, ada tantangan dalam memilih sumber yang tepat dan menjaga keseimbangan antara pembelajaran mandiri dan interaksi sosial. Untuk itu, penting bagi kita untuk memanfaatkan teknologi secara bijaksana agar tetap dapat mengembangkan keterampilan dan membangun hubungan yang bermakna dalam proses belajar.",
      'judul': 'Jasa Angkut Barang',
      "jenis": 'Servis AC',
      "lokasi": "Mana Saja",
      'harga': 'Rp200.000',
      'media': [
        "assets/logo/spesialis.jpg",
      ]
    },
    {
      'id': '3',
      'nama': 'Sari',
      'waktu': DateTime.now().subtract(Duration(hours: 1)),
      'judul': 'Jasa Rental',
      'deskripsi':
          'Rental mobil harian dengan driver atau lepas kunci terbaik.',
      "jenis": 'Rental Mobil',
      "lokasi": "Mana Saja",
      'harga': 'Rp350.000',
      'media': [
        "assets/logo/spesialis.jpg",
        "assets/logo/spesialis.jpg",
      ]
    },
  ].obs;

  List<Map<String, dynamic>> filterPostingan(String query) {
    final queryLower = query.toLowerCase();

    bool containsQuery(Map<String, dynamic> post) {
      final judul = post['judul']?.toString().toLowerCase() ?? '';
      final deskripsi = post['deskripsi']?.toString().toLowerCase() ?? '';
      final nama = post['nama']?.toString().toLowerCase() ?? '';
      final tags = (post['tags'] as List<dynamic>?)
              ?.map((e) => e.toString().toLowerCase())
              .toList() ??
          [];

      return judul.contains(queryLower) ||
          deskripsi.contains(queryLower) ||
          nama.contains(queryLower) ||
          tags.any((tag) => tag.contains(queryLower));
    }

    List<Map<String, dynamic>> filteredPosts = [
      if (containsQuery(postinganSaya)) postinganSaya,
      ...postinganLainnya.where(containsQuery),
    ];

    return filteredPosts;
  }
}
