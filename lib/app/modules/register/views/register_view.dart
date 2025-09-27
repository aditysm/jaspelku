// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jaspelku/app/utils/all_material.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());

    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => AnimatedOpacity(
            opacity: controller.showTitle.value ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 100),
            child: const Text("Daftar akun baru"),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: controller.scrollController,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Daftar akun baru",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    const Text("Buat akun untuk melanjutkan!"),
                    const SizedBox(height: 32),
                    const Text("Nama Lengkap"),
                    const SizedBox(height: 8),
                    Obx(() => AllMaterial.textField(
                          controller: controller.namaLengkapC,
                          focusNode: controller.namaLengkapF,
                          hintText: "Masukkan nama lengkap Anda...",
                          errorText: controller.namaError.value.isNotEmpty
                              ? controller.namaError.value
                              : null,
                        )),
                    const SizedBox(height: 16),
                    const Text("Email"),
                    const SizedBox(height: 8),
                    Obx(() => AllMaterial.textField(
                          controller: controller.emailC,
                          focusNode: controller.emailF,
                          hintText: "Masukkan email Anda...",
                          errorText: controller.emailError.value.isNotEmpty
                              ? controller.emailError.value
                              : null,
                        )),
                    const SizedBox(height: 16),
                    const Text("Tanggal Lahir"),
                    const SizedBox(height: 8),
                    Obx(() => AllMaterial.textField(
                          enabled: true,
                          controller: controller.tanggalLahirC,
                          focusNode: controller.tanggalLahirF,
                          textInputType: TextInputType.datetime,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (pickedDate != null) {
                              controller.tanggalLahirC.text =
                                  DateFormat('dd/MM/yyyy').format(pickedDate);
                            }
                          },
                          suffix: IconButton(
                            onPressed: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );
                              if (pickedDate != null) {
                                controller.tanggalLahirC.text =
                                    DateFormat('dd/MM/yyyy').format(pickedDate);
                              }
                            },
                            icon: const Icon(Icons.date_range_outlined),
                          ),
                          hintText: "Masukkan tanggal lahir Anda...",
                          errorText:
                              controller.tanggalLahirError.value.isNotEmpty
                                  ? controller.tanggalLahirError.value
                                  : null,
                        )),
                    const SizedBox(height: 16),
                    const Text("Nomor Telepon"),
                    const SizedBox(height: 8),
                    Obx(() => AllMaterial.textField(
                          textInputType:
                              const TextInputType.numberWithOptions(),
                          controller: controller.noTeleponC,
                          focusNode: controller.noTeleponF,
                          limit: 13,
                          prefix: Container(
                            padding: const EdgeInsets.all(15),
                            child: const Text("+62"),
                          ),
                          hintText: "Masukkan nomor telepon Anda...",
                          errorText: controller.noTeleponError.value.isNotEmpty
                              ? controller.noTeleponError.value
                              : null,
                        )),
                    const SizedBox(height: 16),
                    const Text("Tentukan Kata Sandi"),
                    const SizedBox(height: 8),
                    Obx(() => AllMaterial.textField(
                          isPassword: true,
                          obscureText: controller.isObscure.value,
                          onToggleObscureText: () =>
                              controller.isObscure.toggle(),
                          controller: controller.passC,
                          focusNode: controller.passF,
                          textInputAction: TextInputAction.done,
                          hintText: "Tentukan kata sandi Anda...",
                          errorText: controller.passwordError.value.isNotEmpty
                              ? controller.passwordError.value
                              : null,
                        )),
                    const SizedBox(height: 16),
                    const Text("Konfirmasi Kata Sandi"),
                    const SizedBox(height: 8),
                    Obx(() => AllMaterial.textField(
                          isPassword: true,
                          onSubmitted: (value) async {
                            var status = await controller.validateForm();

                            if (status) {
                              controller.register();
                            }
                          },
                          obscureText: controller.isObscure.value,
                          onToggleObscureText: () =>
                              controller.isObscure.toggle(),
                          controller: controller.passKonfirC,
                          focusNode: controller.passKonfirF,
                          textInputAction: TextInputAction.done,
                          hintText: "Konfirmasi kata sandi Anda...",
                          errorText:
                              controller.passwordKonfirError.value.isNotEmpty
                                  ? controller.passwordKonfirError.value
                                  : null,
                        )),
                    const SizedBox(height: 16),
                    AllMaterial.cusButton(
                      width: Get.width,
                      label: "Lanjutkan",
                      onTap: () async {
                        var status = await controller.validateForm();
                        if (status) {
                          controller.register();
                        }
                        // Get.offAll(() => const RegisterRoleView());
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Sudah punya akun?"),
                    TextButton(
                      onPressed: () => Get.back(),
                      child: Text(
                        "Masuk",
                        style: TextStyle(
                          color: AllMaterial.colorPrimaryShade,
                          fontWeight: AllMaterial.fontSemiBold,
                        ),
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
