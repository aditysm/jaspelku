import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:jaspelku/app/utils/all_material.dart';
import 'package:jaspelku/app/modules/login/views/login_view.dart';
import 'package:jaspelku/app/modules/main_page/views/main_page_view.dart';
import 'package:jaspelku/app/modules/pengenalan/views/pengenalan_view.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await initializeDateFormatting('id_ID', null);

  final box = GetStorage();

  final bool isLogged = box.read("login") == true;
  final bool sudahPengenalan = box.read("sudahPengenalan") == true;
  final dynamic isDarkRaw = box.read('isDarkMode');
  final String? role = box.read("role");

  ThemeMode themeMode;
  if (isDarkRaw is bool) {
    themeMode = isDarkRaw ? ThemeMode.dark : ThemeMode.light;
  } else {
    themeMode = ThemeMode.system;
  }

  AllMaterial.isDarkMode.value = isDarkRaw is bool
      ? isDarkRaw
      : WidgetsBinding.instance.window.platformBrightness == Brightness.dark;

  AllMaterial.isServant.value = role == "servant";

  Widget defaultPage;
  if (isLogged) {
    defaultPage = MainPageView();
  } else if (!sudahPengenalan) {
    defaultPage = PengenalanView();
  } else {
    defaultPage = const LoginView();
  }

  runApp(MyApp(
    defaultPage: defaultPage,
    themeMode: themeMode,
  ));
}

class MyApp extends StatelessWidget {
  final Widget defaultPage;
  final ThemeMode themeMode;

  const MyApp({
    super.key,
    required this.defaultPage,
    required this.themeMode,
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
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
        dividerColor: const Color(0xFFE9E9E9),
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
        chipTheme: ThemeData.dark().chipTheme.copyWith(
              selectedColor: AllMaterial.colorPrimary,
              backgroundColor: Colors.transparent,
              disabledColor: Colors.transparent,
              shadowColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
            ),
        dialogBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF121212),
          surfaceTintColor: Color(0xFF121212),
        ),
        dividerColor: const Color(0xFF2C2C2C),
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
      title: "Jasa Pelayanan Ku",
      getPages: AppPages.routes,
      home: defaultPage,
    );
  }
}
