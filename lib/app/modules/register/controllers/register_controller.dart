import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaspelku/app/utils/all_material.dart';
import 'package:jaspelku/app/modules/register_role/views/register_role_view.dart';
import 'package:jaspelku/app/utils/toast_dialog.dart';

class RegisterController extends GetxController {
  var isObscure = true.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController noTeleponC = TextEditingController();
  TextEditingController tanggalLahirC = TextEditingController();
  TextEditingController namaLengkapC = TextEditingController();
  TextEditingController passC = TextEditingController();
  TextEditingController passKonfirC = TextEditingController();
  FocusNode emailF = FocusNode();
  FocusNode passF = FocusNode();
  FocusNode passKonfirF = FocusNode();
  FocusNode tanggalLahirF = FocusNode();
  FocusNode namaLengkapF = FocusNode();
  FocusNode noTeleponF = FocusNode();

  var namaError = ''.obs;
  var emailError = ''.obs;
  var tanggalLahirError = ''.obs;
  var noTeleponError = ''.obs;
  var passwordError = ''.obs;
  var passwordKonfirError = ''.obs;

  final scrollController = ScrollController();
  var showTitle = false.obs;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
    namaLengkapC.addListener(() {
      if (namaLengkapC.text.isNotEmpty) namaError.value = '';
    });

    emailC.addListener(() {
      if (emailC.text.isNotEmpty) emailError.value = '';
    });

    tanggalLahirC.addListener(() {
      if (tanggalLahirC.text.isNotEmpty) tanggalLahirError.value = '';
    });

    noTeleponC.addListener(() {
      if (noTeleponC.text.isNotEmpty) noTeleponError.value = '';
    });

    passC.addListener(() {
      if (passC.text.isNotEmpty) passwordError.value = '';
    });

    passKonfirC.addListener(() {
      if (passKonfirC.text.isNotEmpty) passwordKonfirError.value = '';
    });
  }

  void _scrollListener() {
    showTitle.value = scrollController.offset > 40;
  }

  @override
  void onClose() {
    scrollController.dispose();
    emailC.dispose();
    noTeleponC.dispose();
    tanggalLahirC.dispose();
    namaLengkapC.dispose();
    passC.dispose();
    passKonfirC.dispose();

    emailF.dispose();
    passF.dispose();
    passKonfirF.dispose();
    tanggalLahirF.dispose();
    namaLengkapF.dispose();
    noTeleponF.dispose();
    super.onClose();
  }

  Future<bool> validateForm() async {
    bool isValid = true;

    namaError.value = '';
    emailError.value = '';
    tanggalLahirError.value = '';
    noTeleponError.value = '';
    passwordError.value = '';
    passwordKonfirError.value = '';

    if (namaLengkapC.text.trim().isEmpty) {
      namaError.value = 'Nama lengkap wajib diisi';
      isValid = false;
    }

    if (emailC.text.trim().isEmpty) {
      emailError.value = 'Email wajib diisi';
      isValid = false;
    } else if (!GetUtils.isEmail(emailC.text.trim())) {
      emailError.value = 'Format email tidak valid';
      isValid = false;
    }

    if (tanggalLahirC.text.trim().isEmpty) {
      tanggalLahirError.value = 'Tanggal lahir wajib diisi';
      isValid = false;
    }

    if (noTeleponC.text.trim().isEmpty) {
      noTeleponError.value = 'Nomor telepon wajib diisi';
      isValid = false;
    } else if (noTeleponC.text.length < 9) {
      noTeleponError.value = 'Nomor telepon minimal 9 digit';
      isValid = false;
    }

    if (passC.text.isEmpty) {
      passwordError.value = 'Kata sandi wajib diisi';
      isValid = false;
    } else if (passC.text.length < 8) {
      passwordError.value = 'Minimal 8 karakter';
      isValid = false;
    }

    if (passKonfirC.text.isEmpty) {
      passwordKonfirError.value = 'Kata sandi wajib diisi';
      isValid = false;
    } else if (passC.text != passKonfirC.text) {
      passwordKonfirError.value = 'Kata sandi tidak cocok';
      isValid = false;
    }

    if (!isValid) return false;

    if (emailError.isNotEmpty ||
        passwordError.isNotEmpty ||
        emailError.isNotEmpty ||
        tanggalLahirError.isNotEmpty ||
        noTeleponError.isNotEmpty ||
        passwordError.isNotEmpty ||
        passwordKonfirError.isNotEmpty) return false;

    return true;
  }

  void register() {
    AllMaterial.cusDialogValidasi(
      title: "Simpan Data",
      subtitle: "Apakah Anda yakin?",
      onConfirm: () async {
        Get.back();
        AllMaterial.showLoadingDialog();
        await Future.delayed(const Duration(milliseconds: 400));
        Get.back();
        Get.offAll(() => const RegisterRoleView());
        ToastService.show(
          "Data telah disimpan, Silahkan pilih role Anda",
        );
      },
      onCancel: () => Get.back(),
    );
  }
}
