import 'package:get/get.dart';

import '../controllers/event_promo_controller.dart';

class EventPromoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EventPromoController>(
      () => EventPromoController(),
    );
  }
}
