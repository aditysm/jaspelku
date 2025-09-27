import 'package:get/get.dart';

class VerifikasiPenggunaController extends GetxController {
  var emailVerified = false.obs;
  var phoneVerified = false.obs;
  var isAccountVerified = false.obs;

  void verifyEmail() {
    // Logika verifikasi email
    emailVerified.value = true; // Set setelah verifikasi berhasil
  }

  void verifyPhone() {
    // Logika verifikasi nomor telepon
    phoneVerified.value = true; // Set setelah verifikasi berhasil
  }
}
