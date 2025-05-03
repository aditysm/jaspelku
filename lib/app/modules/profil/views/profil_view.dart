import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jaspelku/all_material.dart';
import 'package:jaspelku/app/modules/edit_profil/views/edit_profil_view.dart';
import 'package:jaspelku/app/modules/histori_pesanan/views/histori_pesanan_view.dart';
import 'package:jaspelku/app/widget/random_tag_container.dart';

import '../controllers/profil_controller.dart';

class ProfilView extends GetView<ProfilController> {
  final ScrollController? profilScrollController;
  const ProfilView({super.key, this.profilScrollController});
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(microseconds: 1));
    final List<String> photoUrls = [
      "assets/logo/spesialis.jpg",
      "assets/logo/spesialis.jpg",
    ];

    final controller = Get.put(ProfilController());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ListView(
            controller: profilScrollController,
            children: [
              Row(
                children: [
                  AllMaterial.avatarWidget(
                    name: "John Borino",
                    showEdit: true,
                    onEditTap: () {
                      print(controller.histori);
                      Get.to(
                        () => EditProfilView(),
                      );
                    },
                    radius: 50,
                  ),
                  SizedBox(width: 35),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      AllMaterial.namaDenganVerified(
                        name: "John Borino",
                        isProfil: true,
                        isVerified: true,
                      ),
                      Text(
                        // AllMaterial.formatEmail("habilarlian25@gmail.com"),
                        "johnborino25@gmail.com",
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Dibutuhkan Akhir-Akhir Ini",
                style: TextStyle(
                  fontWeight: AllMaterial.fontSemiBold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 5,
                runSpacing: 3,
                children: [
                  RandomTagContainer(label: "Jasa Angkut Barang"),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Histori Pemesanan",
                style: TextStyle(
                  fontWeight: AllMaterial.fontSemiBold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 15),
              Column(
                children: List.generate(photoUrls.length, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        onTap: () {
                          Get.to(() => HistoriPesananView());
                        },
                        contentPadding: EdgeInsets.zero,
                        trailing: const Icon(Icons.arrow_forward_ios_rounded),
                        leading: CircleAvatar(
                          backgroundColor: AllMaterial.colorPrimary,
                          backgroundImage: AssetImage(
                            photoUrls[index],
                          ),
                        ),
                        title: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Text(
                                "Jasa Angkut Barang - Habil Arlian Asrori",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  fontWeight: AllMaterial.fontSemiBold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Dipesan pada: ${DateFormat('dd-MM-yyyy', 'id_ID').format(DateTime.now())}",
                              style: TextStyle(),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Status Pesanan : ",
                                  style: TextStyle(),
                                ),
                                Text(
                                  "Selesai",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: AllMaterial.fontMedium,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
