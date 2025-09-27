import 'package:get/get.dart';

import '../controllers/verifikasi_pengguna_controller.dart';

class VerifikasiPenggunaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifikasiPenggunaController>(
      () => VerifikasiPenggunaController(),
    );
  }
}
