import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  var isObscure = true.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController noTeleponC = TextEditingController();
  TextEditingController tanggalLahirC = TextEditingController();
  TextEditingController namaLengkapC = TextEditingController();
  TextEditingController passC = TextEditingController();
  FocusNode emailF = FocusNode();
  FocusNode passF = FocusNode();
  FocusNode tanggalLahirF = FocusNode();
  FocusNode namaLengkapF = FocusNode();
  FocusNode noTeleponF = FocusNode();
}
