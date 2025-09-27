import 'package:get/get.dart';

class EventPromoController extends GetxController {
  var activePromos = <String>[].obs;
  var userEvents = <String>[].obs;
  var otherItems = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadEventData();
  }

  void loadEventData() {
    // Simulasi data
    activePromos.assignAll([
      'Diskon 50% Pengguna Baru',
      'Gratis Ongkir Hari Ini',
    ]);

    userEvents.assignAll([
      'Ada Event 5.5 Spesial 5 Mei 2025',
      'Yuk ikuti Quiz Tebak Jasa oleh CV. Bale Kotak GVINUM',
    ]);

    otherItems.assignAll([
      'Kode Referral: JASPEL2025',
      'Info sistem maintenance tanggal 10 Mei',
    ]);
  }
}
