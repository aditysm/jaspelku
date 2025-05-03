import 'package:get/get.dart';

import '../controllers/postingan_baru_controller.dart';

class PostinganBaruBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostinganBaruController>(
      () => PostinganBaruController(),
    );
  }
}
