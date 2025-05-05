import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:jaspelku/all_material.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum MetodePembayaran { jaspelCoin, midtrans }

class HistoriPesananController extends GetxController {
  ValueNotifier<bool> hideUI = ValueNotifier(false);
  final selectedMethod = Rx<MetodePembayaran?>(null);

  void changeMethod(MetodePembayaran method) {
    selectedMethod.value = method;
    print(method);
    update();
  }

  void bayarSekarang() {
    if (selectedMethod.value == MetodePembayaran.jaspelCoin) {
      AllMaterial.messageScaffold(title: "Diproses dengan Jaspel Coin");
    } else if (selectedMethod.value == MetodePembayaran.midtrans) {
      final paymentUrl =
          "https://app.sandbox.midtrans.com/snap/v2/vtweb/12345678-aaaa-bbbb-cccc-123456789abc";
      showMidtransWebView(paymentUrl);
    } else {
      AllMaterial.messageScaffold(
        title: "Silakan pilih metode pembayaran terlebih dahulu",
      );
    }
  }

  void showMidtransWebView(String paymentUrl) {
    Get.generalDialog(
      barrierDismissible: false,
      barrierLabel: "Midtrans WebView",
      pageBuilder: (context, animation, secondaryAnimation) {
        final controller = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse(paymentUrl));

        return Scaffold(
          appBar: AppBar(
            title: const Text("Pembayaran Midtrans"),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Get.back(),
              ),
            ],
          ),
          body: WebViewWidget(controller: controller),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  final dataRating = [ {
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
  }].obs;
}
