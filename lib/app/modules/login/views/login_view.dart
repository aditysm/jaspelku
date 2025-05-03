// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jaspelku/all_material.dart';
import 'package:jaspelku/app/modules/main_page/views/main_page_view.dart';
import 'package:jaspelku/app/modules/register/views/register_view.dart';
import 'package:svg_flutter/svg.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/logo/logo.svg",
                          color: AllMaterial.colorPrimary,
                          width: 18,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Jaspelku",
                          style: TextStyle(
                            fontWeight: AllMaterial.fontBold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32),
                    Text(
                      "Masuk ke akun Anda",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: AllMaterial.fontBold,
                      ),
                    ),
                    Text(
                      "Masukkan email dan kata sandi Anda untuk masuk",
                    ),
                    SizedBox(height: 32),
                    Text("Email"),
                    SizedBox(height: 8),
                    AllMaterial.textField(
                      controller: controller.emailC,
                      focusNode: controller.emailF,
                      hintText: "Masukkan email Anda...",
                    ),
                    SizedBox(height: 16),
                    Text("Kata Sandi"),
                    SizedBox(height: 8),
                    Obx(
                      () => AllMaterial.textField(
                        textInputAction: TextInputAction.done,
                        isPassword: true,
                        obscureText: controller.isObscure.value,
                        onToggleObscureText: () =>
                            controller.isObscure.toggle(),
                        controller: controller.passC,
                        focusNode: controller.passF,
                        hintText: "Masukkan kata sandi Anda...",
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Lupa Kata Sandi ?",
                            style: TextStyle(
                              fontWeight: AllMaterial.fontSemiBold,
                              color: AllMaterial.colorPrimaryShade,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    AllMaterial.cusButton(
                      width: Get.width,
                      label: "Masuk",
                      onTap: () {
                        Get.offAll(() => MainPageView());
                        AllMaterial.box.write("login", true);
                      },
                    ),
                    SizedBox(height: 24),
                    Row(
                      children: [
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                width: 1,
                                color: AllMaterial.colorGreyPrimary,
                              ),
                            ),
                            height: 1,
                            width: Get.width,
                          ),
                        ),
                        SizedBox(width: 16),
                        Text("Atau"),
                        SizedBox(width: 16),
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                width: 1,
                                color: AllMaterial.colorGreyPrimary,
                              ),
                            ),
                            height: 1,
                            width: Get.width,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    AllMaterial.cusButton(
                      width: Get.width,
                      addIcon: true,
                      colorSecondary: AllMaterial.colorBlackPrimary,
                      icon: SvgPicture.asset("assets/logo/google.svg"),
                      label: "Lanjutkan dengan Google",
                      isSecondary: true,
                      onTap: () {},
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Belum punya akun?",
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => RegisterView());
                      },
                      child: Text(
                        "Daftar",
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
