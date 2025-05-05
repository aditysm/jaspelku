import 'package:get/get.dart';

import '../controllers/pengenalan_controller.dart';

class PengenalanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PengenalanController>(
      () => PengenalanController(),
    );
  }
}
