import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaspelku/all_material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeController extends GetxController {
  static var isPesananAktif =
      AllMaterial.isServant.isTrue ? true.obs : false.obs;
  var servantUnggulan = 3.obs;

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
            title: const Text("Topup Jaspel Coin"),
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
}
