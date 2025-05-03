import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:jaspelku/all_material.dart';
import 'package:jaspelku/app/modules/login/views/login_view.dart';
import 'package:jaspelku/app/modules/main_page/views/main_page_view.dart';
import 'package:jaspelku/app/widget/splash_screen.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  await initializeDateFormatting('id_ID', null);
  WidgetsFlutterBinding.ensureInitialized();
  var isDark = AllMaterial.box.read('isDarkMode');
  AllMaterial.isDarkMode.value = isDark ?? false;
  runApp(
    GetMaterialApp(
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: AllMaterial.colorPrimary),
        primaryColorLight: AllMaterial.colorWhite,
        textTheme: ThemeData.light().textTheme.apply(),
        iconTheme: IconThemeData(color: AllMaterial.colorBlackPrimary),
        scaffoldBackgroundColor: AllMaterial.colorWhite,
        primaryColor: AllMaterial.colorPrimary,
        appBarTheme: AppBarTheme(
          backgroundColor: AllMaterial.colorWhite,
          surfaceTintColor: AllMaterial.colorWhite,
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: AllMaterial.colorPrimary,
        colorScheme: const ColorScheme.dark().copyWith(
          primary: AllMaterial.colorPrimary,
          surface: Color(0xFF121212),
          onSurface: Colors.white,
          background: Color(0xFF121212),
          onPrimary: Colors.white,
        ),
        dialogBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF121212),
          surfaceTintColor: Color(0xFF121212),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF121212),
          labelStyle: const TextStyle(color: Colors.white70),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        dropdownMenuTheme: const DropdownMenuThemeData(
          menuStyle: MenuStyle(
            backgroundColor: MaterialStatePropertyAll(Color(0xFF121212)),
            surfaceTintColor: MaterialStatePropertyAll(Color(0xFF121212)),
          ),
        ),
      ),
      themeMode: isDark != null
          ? isDark
              ? ThemeMode.dark
              : ThemeMode.light
          : ThemeMode.system,
      debugShowCheckedModeBanner: false,
      title: "Jasa Pelayanan Ku",
      home: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 2)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              // var controller = Get.put(GenerateKelompokController());
              // controller.loadHistory();
            });
            bool isLogged = AllMaterial.box.read("login") ?? false;
            if (isLogged) {
              return MainPageView();
            }
            return const LoginView();
          }
        },
      ),
      getPages: AppPages.routes,
    ),
  );
}
