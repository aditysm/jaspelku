import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:svg_flutter/svg.dart';

abstract class AllMaterial {
  // Role Validation
  static var isServant = false.obs;

  // Dark Mode
  static var isDarkMode = false.obs;

  // Font Weight
  static const fontBlack = FontWeight.w900;
  static const fontExtraBold = FontWeight.w800;
  static const fontBold = FontWeight.w700;
  static const fontSemiBold = FontWeight.w600;
  static const fontMedium = FontWeight.w500;
  static const fontRegular = FontWeight.w400;

  // Color
  static const colorComplementaryBlue = Color(0xff083D77);
  static const colorComplementaryBlueShade = Color(0xffF2F7FB);
  static const colorStrokePrimary = Color(0xffEDF1F3);
  static const colorPrimary = Color(0xffF95738);
  static const colorPrimaryShade = Color(0xffEE964B);
  static const colorSecondary = Color(0xffF4D35E);
  static const colorSecondaryShade = Color(0xffEBEBD3);
  static const colorGreyPrimary = Color(0xff696969);
  static const colorGreySecondary = Color(0xffEFEFEF);
  static const colorBlackPrimary = Color(0xff1F2024);
  static const colorWhite = Color(0xffF8F9FE);

  // Storage
  static var box = GetStorage();

  // Button
  static Widget cusButton({
    String? label,
    void Function()? onTap,
    Widget? icon,
    bool addIcon = true,
    bool isSecondary = false,
    Color? colorSecondary,
    double? width,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: isSecondary ? AllMaterial.colorWhite : AllMaterial.colorPrimary,
      child: InkWell(
        onTap: onTap,
        splashColor: isSecondary
            ? AllMaterial.colorBlackPrimary.withOpacity(0.2)
            : AllMaterial.colorBlackPrimary.withOpacity(0.2),
        highlightColor: isSecondary
            ? AllMaterial.colorBlackPrimary.withOpacity(0.1)
            : AllMaterial.colorPrimary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: isSecondary
                ? Border.all(color: AllMaterial.colorStrokePrimary, width: 2)
                : null,
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (addIcon && icon != null) icon,
              if (addIcon && icon != null) SizedBox(width: 5),
              Text(
                "$label",
                style: TextStyle(
                  color: isSecondary ? colorSecondary : AllMaterial.colorWhite,
                  fontSize: 16,
                  fontWeight: AllMaterial.fontSemiBold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Text Field
  static Widget textField({
    FocusNode? focusNode,
    String? hintText,
    TextEditingController? controller,
    bool isPassword = false,
    bool? obscureText,
    VoidCallback? onToggleObscureText,
    Widget? suffix,
    Widget? prefix,
    bool enabled = false,
    TextInputType? textInputType,
    Color? color,
    String? prefixText,
    String? labelText,
    TextInputAction? textInputAction = TextInputAction.next,
  }) {
    return TextField(
      keyboardType: textInputType,
      controller: controller,
      focusNode: focusNode,
      cursorColor: AllMaterial.colorPrimary,
      textInputAction: textInputAction,
      obscureText: isPassword ? (obscureText ?? true) : false,
      style: TextStyle(color: color),
      onTapOutside: (_) {
        focusNode?.unfocus();
      },
      readOnly: enabled,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: AllMaterial.isDarkMode.isTrue
              ? AllMaterial.colorWhite
              : AllMaterial.colorPrimary,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AllMaterial.colorStrokePrimary,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AllMaterial.colorPrimary,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: hintText,
        prefixText: prefixText,
        prefixStyle: TextStyle(
          color: AllMaterial.isDarkMode.isTrue
              ? AllMaterial.colorWhite
              : AllMaterial.colorPrimary,
        ),
        hintStyle: TextStyle(
          fontWeight: AllMaterial.fontRegular,
        ),
        hoverColor: AllMaterial.colorPrimary,
        focusColor: AllMaterial.colorPrimary,
        border: OutlineInputBorder(
          borderSide: BorderSide(
              // color: AllMaterial.colorStrokePrimary,
              ),
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: prefix,
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  (obscureText ?? true)
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: onToggleObscureText,
              )
            : suffix,
      ),
    );
  }

  static void cusDialogValidasi({
    required String title,
    required String subtitle,
    required VoidCallback? onConfirm,
    required VoidCallback? onCancel,
  }) {
    Get.dialog(
      Dialog(
        backgroundColor: AllMaterial.isDarkMode.isTrue ? null : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: AllMaterial.fontBold,
                ),
              ),
              const SizedBox(height: 12),

              /// Subtitle
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 15,
                  color: AllMaterial.isDarkMode.isTrue
                      ? Colors.grey[300]
                      : Colors.grey[800],
                ),
              ),
              const SizedBox(height: 24),

              /// Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: onCancel,
                    child: const Text(
                      'BATAL',
                      style: TextStyle(
                        color: AllMaterial.colorPrimary,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: onConfirm,
                    child: Text(
                      'KONFIRMASI',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AllMaterial.colorPrimary,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget avatarWidget({
    required String name,
    String? imageUrl,
    double radius = 20,
    bool showEdit = false,
    VoidCallback? onEditTap,
  }) {
    final double innerPadding = radius * 0.1;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: radius,
          backgroundColor: AllMaterial.colorPrimary,
          backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
          child: imageUrl == null
              ? Text(
                  name.isNotEmpty ? name[0] : '',
                  style: TextStyle(
                    color: AllMaterial.colorWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: radius * 0.8,
                  ),
                )
              : null,
        ),
        if (showEdit)
          Positioned(
            right: -10 * 2,
            top: 0,
            bottom: 0,
            child: Center(
                child: Material(
              color: AllMaterial.colorPrimary,
              shape: const CircleBorder(),
              child: InkWell(
                onTap: onEditTap,
                customBorder: const CircleBorder(),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 5.5,
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(innerPadding),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )),
          )
      ],
    );
  }

  static Widget namaDenganVerified({
    required String name,
    required bool isVerified,
    TextStyle? style,
    double iconSize = 18,
    bool isProfil = false,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            AllMaterial.formatNamaPanjang(name),
            overflow: TextOverflow.ellipsis,
            style: style ??
                TextStyle(
                  fontSize: isProfil ? 20 : 15,
                  fontWeight: AllMaterial.fontBold,
                ),
          ),
        ),
        if (isVerified) ...[
          const SizedBox(width: 6),
          Icon(
            Icons.verified,
            size: iconSize,
            color: Colors.green,
          ),
        ],
      ],
    );
  }

  static Widget menuLayanan({
    required String title,
    required String svg,
    required VoidCallback? onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(3),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: SvgPicture.asset(
                "assets/icon/$svg.svg",
                height: 34,
              ),
            ),
            Text(title),
          ],
        ),
      ),
    );
  }

  static String getErrorMessage(int statusCode) {
    switch (statusCode) {
      case 400:
        return "Permintaan tidak dapat diproses. Pastikan data yang kamu isi sudah benar.";
      case 401:
        return "Kamu belum login. Silakan masuk terlebih dahulu.";
      case 403:
        return "Akses ditolak. Kamu tidak punya izin untuk fitur ini.";
      case 404:
        return "Layanan atau data yang kamu cari tidak ditemukan.";
      case 408:
        return "Permintaan terlalu lama. Coba lagi dalam beberapa saat.";
      case 500:
        return "Terjadi kesalahan di sistem kami. Tim kami sedang menanganinya.";
      case 502:
        return "Layanan sedang sibuk. Coba lagi nanti, ya.";
      case 503:
        return "Server sedang tidak tersedia. Silakan coba beberapa saat lagi.";
      case 504:
        return "Waktu tunggu habis. Koneksi ke server gagal.";
      default:
        return "Oops! Terjadi kesalahan yang tidak terduga.";
    }
  }

  static String formatTime24(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  static void messageScaffold({required String title}) {
    if (Get.context != null) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(
            title,
          ),
        ),
      );
    }
  }

  static String formatEmail(String email) {
    if (!email.contains('@')) return email;

    final parts = email.split('@');
    final username = parts[0];
    final domain = parts[1];

    if (username.length > 10) {
      int half = username.length ~/ 2;
      String awal = username.substring(0, half ~/ 2);
      String akhir = username.substring(username.length - half ~/ 2);
      return '$awal...$akhir@$domain';
    }

    return email;
  }

  static String formatNamaPanjang(String namaPanjang) {
    List<String> namaArray = namaPanjang.split(' ');
    List<String> duaNamaPertama = namaArray.take(3).toList();
    return duaNamaPertama.join(' ');
  }

  // Format : 29/04/2025
  static String tahunBulanTanggal(String dateIsoString) {
    DateTime parsed = DateTime.parse(dateIsoString);
    return DateFormat('dd/MM/yyyy').format(parsed);
  }
}
