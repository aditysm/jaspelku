import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaspelku/all_material.dart';
import 'package:jaspelku/app/modules/main_page/views/main_page_view.dart';
import 'package:svg_flutter/svg.dart';
import 'package:flutter/gestures.dart'; // Untuk GestureRecognizer

import '../controllers/register_role_controller.dart';

class RegisterRoleView extends GetView<RegisterRoleController> {
  const RegisterRoleView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterRoleController());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      "Pilih Peran Anda",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: AllMaterial.fontBold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Peran mana yang ingin Anda pilih?",
                    ),
                    SizedBox(height: 32),
                    Material(
                      borderRadius: BorderRadius.circular(16),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          AllMaterial.isServant.value = false;
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AllMaterial.colorStrokePrimary,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 20,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                () => Container(
                                  padding: AllMaterial.isServant.isFalse
                                      ? EdgeInsets.all(2)
                                      : null,
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(200),
                                    border: Border.all(
                                      color: AllMaterial.colorPrimary,
                                    ),
                                  ),
                                  child: Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        200,
                                      ),
                                      color: AllMaterial.isServant.isFalse
                                          ? AllMaterial.colorPrimary
                                          : null,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Vendee",
                                    style: TextStyle(
                                      color: AllMaterial.isDarkMode.value
                                          ? AllMaterial.colorWhite
                                          : AllMaterial.colorComplementaryBlue,
                                      fontWeight: AllMaterial.fontBold,
                                    ),
                                  ),
                                  Text("Mencari Jasa"),
                                  Text("Terhubung dengan ribuan Servant"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Material(
                      borderRadius: BorderRadius.circular(16),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          AllMaterial.isServant.value = true;
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AllMaterial.colorStrokePrimary,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 20,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                () => Container(
                                  padding: AllMaterial.isServant.isTrue
                                      ? EdgeInsets.all(2)
                                      : null,
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(200),
                                    border: Border.all(
                                      color: AllMaterial.colorPrimary,
                                    ),
                                  ),
                                  child: Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        200,
                                      ),
                                      color: AllMaterial.isServant.isTrue
                                          ? AllMaterial.colorPrimary
                                          : null,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Servant",
                                    style: TextStyle(
                                      color: AllMaterial.isDarkMode.value
                                          ? AllMaterial.colorWhite
                                          : AllMaterial.colorComplementaryBlue,
                                      fontWeight: AllMaterial.fontBold,
                                    ),
                                  ),
                                  Text("Menawarkan Jasa"),
                                  Text("Jangkau lebih banyak Vendee"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 3),
                    SizedBox(height: 16),
                    AllMaterial.cusButton(
                      width: Get.width,
                      label: "Daftar",
                      onTap: () {
                        AllMaterial.cusDialogValidasi(
                          title:
                              "Menjadi ${AllMaterial.isServant.isTrue ? "Servant" : "Vendee"}",
                          subtitle: "Apakah Anda yakin?",
                          onConfirm: () {
                            Get.offAll(() => MainPageView());
                            controller.daftar(AllMaterial.isServant.isTrue ? "servant" : "vendee");
                            AllMaterial.box.write("login", true);
                          },
                          onCancel: () => Get.back(),
                        );
                      },
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text:
                                    "Dengan mendaftar, Anda menyetujui & menerima\n",
                                style: TextStyle(),
                                children: [
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        print(
                                            "Teks Syarat & Ketentuan Jaspelku ditekan");
                                      },
                                    text: "Syarat & Ketentuan Jaspelku",
                                    style: TextStyle(
                                      fontWeight: AllMaterial.fontSemiBold,
                                      color: AllMaterial.colorPrimaryShade,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
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
