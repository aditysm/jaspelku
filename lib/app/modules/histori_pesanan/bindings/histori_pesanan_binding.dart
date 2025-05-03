import 'package:get/get.dart';

import '../controllers/histori_pesanan_controller.dart';

class HistoriPesananBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoriPesananController>(
      () => HistoriPesananController(),
    );
  }
}
