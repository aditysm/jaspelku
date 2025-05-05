import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaspelku/all_material.dart';
import 'package:jaspelku/app/modules/login/views/login_view.dart';

class PengenalanController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentIndex = 0.obs;
  var isLast = false.obs;

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void selesaiPengenalan() {
    AllMaterial.showLoadingDialog();

    Future.delayed(const Duration(milliseconds: 400), () {
      var dialog = Get.isDialogOpen ?? false;
      if (dialog == true) {
        Get.back();
        Get.offAll(
          () => LoginView(),
        );
        AllMaterial.box.write('sudahPengenalan', true);
        AllMaterial.messageScaffold(
          title: "Selamat Datang! Silahkan isi data diri terlebih dahulu",
        );
      }
    });
  }
}
