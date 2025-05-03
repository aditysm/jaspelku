import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaspelku/all_material.dart';

class PengaturanController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    final isDark = AllMaterial.box.read('isDarkMode') ?? false;
    AllMaterial.isDarkMode.value = isDark;

    Future.microtask(() {
      Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
    });
  }

  void toggleDarkMode(bool isDark) {
    AllMaterial.isDarkMode.value = isDark;
    AllMaterial.box.write('isDarkMode', isDark);

    Future.microtask(() {
      Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
    });
    update();
  }
}
