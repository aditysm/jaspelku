import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jaspelku/all_material.dart';
import 'package:jaspelku/app/modules/pencarian/views/pencarian_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final ScrollController? homeScrollController;
  const HomeView({super.key, this.homeScrollController});
  @override
  Widget build(BuildContext context) {
    var isDark = AllMaterial.isDarkMode.value;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: ListView(
            controller: homeScrollController,
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: 32,
                  right: 32,
                  top: 17,
                  bottom: 27,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: LinearGradient(
                    colors: [
                      AllMaterial.colorPrimary,
                      AllMaterial.colorPrimaryShade,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Saldo Jaspelku",
                          style: TextStyle(
                            color: AllMaterial.colorWhite,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "+ Topup",
                            style: TextStyle(
                              color: AllMaterial.colorWhite,
                              fontWeight: AllMaterial.fontMedium,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "IDR",
                          style: TextStyle(
                            color: AllMaterial.colorWhite,
                            fontWeight: AllMaterial.fontBold,
                          ),
                        ),
                        SizedBox(width: 7),
                        Text(
                          "150.000,00",
                          style: TextStyle(
                            color: AllMaterial.colorWhite,
                            fontWeight: AllMaterial.fontBold,
                            fontSize: 21,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Rekomendasi Layanan",
                style: TextStyle(
                  fontWeight: AllMaterial.fontSemiBold,
                  fontSize: 16,
                ),
              ),
              Wrap(
                spacing: 2,
                runSpacing: 5,
                children: [
                  AllMaterial.menuLayanan(
                    title: "Menjemput",
                    svg: isDark ? "jemput_dark" : "jemput",
                    onTap: () {},
                  ),
                  AllMaterial.menuLayanan(
                    title: "Mengantar",
                    svg: isDark ? "paket_dark" : "paket",
                    onTap: () {},
                  ),
                  AllMaterial.menuLayanan(
                    title: "Membeli",
                    svg: isDark ? "beli_dark" : "beli",
                    onTap: () {},
                  ),
                  AllMaterial.menuLayanan(
                    title: "Menitip",
                    svg: isDark ? "titip_dark" : "titip",
                    onTap: () {},
                  ),
                  AllMaterial.menuLayanan(
                    title: "Mengurus",
                    svg: isDark ? "urus_dark" : "urus",
                    onTap: () {},
                  ),
                  AllMaterial.menuLayanan(
                    title: "Menolong",
                    svg: isDark ? "tolong_dark" : "tolong",
                    onTap: () {},
                  ),
                  AllMaterial.menuLayanan(
                    title: "Merawat",
                    svg: isDark ? "rawat_dark" : "rawat",
                    onTap: () {},
                  ),
                  AllMaterial.menuLayanan(
                    title: "Semua",
                    svg: isDark ? "layanan_dark" : "layanan",
                    onTap: () {
                      Get.to(() => PencarianView());
                    },
                  ),
                ],
              ),
              SizedBox(height: 15),
              InkWell(
                onTap: () {
                  Get.to(() => PencarianView());
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Servant Unggulan",
                        style: TextStyle(
                          fontWeight: AllMaterial.fontSemiBold,
                          fontSize: 16,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 13,
                      ),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: AllMaterial.colorPrimary,
                            radius: 25,
                            child: Text(
                              "John"[0],
                              style: TextStyle(
                                color: AllMaterial.colorWhite,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          AllMaterial.namaDenganVerified(
                            name: "John Doe",
                            isVerified: true,
                          ),
                          Text("Spesialis Antar"),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: AllMaterial.colorPrimaryShade,
                              ),
                              Text(
                                "4.6",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AllMaterial.isDarkMode.value
                                      ? AllMaterial.colorWhite
                                      : AllMaterial.colorComplementaryBlue,
                                ),
                              ),
                              SizedBox(height: 5),
                            ],
                          ),
                          SizedBox(height: 7),
                          AllMaterial.cusButton(
                            onTap: () {},
                            label: "Tawar",
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/logo/spesialis.jpg"),
                        ),
                      ),
                      width: 90,
                      height: 165,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/logo/spesialis.jpg"),
                        ),
                      ),
                      width: 90,
                      height: 165,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/logo/spesialis.jpg"),
                        ),
                      ),
                      width: 90,
                      height: 165,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
