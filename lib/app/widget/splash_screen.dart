import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaspelku/all_material.dart';
import 'package:svg_flutter/svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllMaterial.colorPrimary,
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/logo/logo.svg"),
            const SizedBox(height: 20),
            const Text(
              "Jaspelku",
              style: TextStyle(
                color: AllMaterial.colorWhite,
                fontSize: 28,
                fontWeight: AllMaterial.fontExtraBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
