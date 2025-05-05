import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaspelku/all_material.dart';
import 'package:jaspelku/app/modules/main_page/views/main_page_view.dart';

class LoginController extends GetxController {
  var isObscure = true.obs;

  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  FocusNode emailF = FocusNode();
  FocusNode passF = FocusNode();

  var emailError = ''.obs;
  var passwordError = ''.obs;
  var allError = ''.obs;

  @override
  void onInit() {
    super.onInit();

    emailC.addListener(() {
      if (emailError.isNotEmpty) emailError.value = '';
      if (allError.isNotEmpty) allError.value = '';
    });

    passC.addListener(() {
      if (passwordError.isNotEmpty) passwordError.value = '';
      if (allError.isNotEmpty) allError.value = '';
    });
  }

  void login() async {
    final email = emailC.text.trim();
    final password = passC.text.trim();

    emailError.value = '';
    passwordError.value = '';
    allError.value = '';

    if (email.isEmpty && password.isEmpty) {
      allError.value = 'Email dan kata sandi harus diisi';
      return;
    }

    if (email.isEmpty) {
      emailError.value = 'Email harus diisi';
    } else if (!email.contains('@')) {
      emailError.value = 'Email tidak valid';
    }

    if (password.isEmpty) {
      passwordError.value = 'Kata sandi harus diisi';
    }

    if (emailError.isNotEmpty || passwordError.isNotEmpty) return;

    AllMaterial.showLoadingDialog();

    await Future.delayed(const Duration(milliseconds: 400));

    if (email == 'servant@demo.com' && password == '1234') {
      AllMaterial.isServant.value = true;
    } else if (email == 'vendee@demo.com' && password == '1234') {
      AllMaterial.isServant.value = false;
    } else {
      Get.back();
      allError.value = 'Email atau kata sandi salah';
      return;
    }

    Get.back();
    AllMaterial.box.write("login", true);
    Get.offAll(() => const MainPageView());
    AllMaterial.messageScaffold(
      title: "Autentikasi Berhasil, Selamat Datang!",
    );
  }
}
