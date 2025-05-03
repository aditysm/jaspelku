// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jaspelku/all_material.dart';
import 'package:jaspelku/app/modules/register_role/views/register_role_view.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Daftar akun baru",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: AllMaterial.fontBold,
                      ),
                    ),
                    Text(
                      "Buat akun untuk melanjutkan!",
                    ),
                    SizedBox(height: 32),
                    Text("Nama Lengkap"),
                    SizedBox(height: 8),
                    AllMaterial.textField(
                      controller: controller.namaLengkapC,
                      focusNode: controller.namaLengkapF,
                      hintText: "Masukkan nama lengkap Anda...",
                    ),
                    SizedBox(height: 16),
                    Text("Email"),
                    SizedBox(height: 8),
                    AllMaterial.textField(
                      controller: controller.emailC,
                      focusNode: controller.emailF,
                      hintText: "Masukkan email Anda...",
                    ),
                    SizedBox(height: 16),
                    Text("Tanggal Lahir"),
                    SizedBox(height: 8),
                    AllMaterial.textField(
                      enabled: true,
                      controller: controller.tanggalLahirC,
                      focusNode: controller.tanggalLahirF,
                      suffix: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.date_range_outlined),
                      ),
                      hintText: "Masukkan tanggal lahir Anda...",
                    ),
                    SizedBox(height: 16),
                    Text("Nomor Telepon"),
                    SizedBox(height: 8),
                    AllMaterial.textField(
                      textInputType: TextInputType.numberWithOptions(),
                      controller: controller.noTeleponC,
                      focusNode: controller.noTeleponF,
                      prefix: Container(
                        padding: EdgeInsets.all(15),
                        child: Text("+62"),
                      ),
                      hintText: "Masukkan nomor telepon Anda...",
                    ),
                    SizedBox(height: 16),
                    Text("Tentukan Kata Sandi"),
                    SizedBox(height: 8),
                    Obx(
                      () => AllMaterial.textField(
                        isPassword: true,
                        obscureText: controller.isObscure.value,
                        onToggleObscureText: () =>
                            controller.isObscure.toggle(),
                        controller: controller.passC,
                        focusNode: controller.passF,
                        textInputAction: TextInputAction.done,
                        hintText: "Tentukan kata sandi Anda...",
                      ),
                    ),
                    SizedBox(height: 16),
                    AllMaterial.cusButton(
                      width: Get.width,
                      label: "Lanjutkan",
                      onTap: () {
                        AllMaterial.cusDialogValidasi(
                          title: "Simpan Data",
                          subtitle: "Apakah Anda yakin?",
                          onConfirm: () {
                            Get.back();
                            Get.offAll(() => RegisterRoleView());
                          },
                          onCancel: () => Get.back(),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Sudah punya akun?",
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        "Masuk",
                        style: TextStyle(
                            color: AllMaterial.colorPrimaryShade,
                            fontWeight: AllMaterial.fontSemiBold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
