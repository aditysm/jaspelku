import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jaspelku/all_material.dart';
import 'package:jaspelku/app/controller/general_controller.dart';
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
    final searchProfile = Get.arguments?["searchProfile"] == true;
    final isServant = AllMaterial.isServant.value;

    final controller = Get.put(ProfilController());
    return Scaffold(
      appBar: searchProfile
          ? AppBar(
              title: Obx(
                () => AnimatedOpacity(
                  opacity: controller.showTitle.value ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 100),
                  child: const Text("John Borino"),
                ),
              ),
              centerTitle: true,
              elevation: 1,
              actions: [
                IconButton(
                  onPressed: () {
                    AllMaterial.bottomSheetMore(
                      2,
                      [
                        "Hubungi Servant",
                        "Laporkan Servant",
                      ],
                      [
                        () {
                          Get.back();
                          AllMaterial.messageScaffold(
                            title: "Menghubungi Servant",
                          );
                        },
                        () {
                          Get.back();
                          AllMaterial.messageScaffold(
                            title: "Laporkan Servant",
                          );
                        },
                      ],
                      [
                        Icon(Icons.message),
                        Icon(Icons.report_sharp),
                      ],
                    );
                  },
                  icon: Icon(
                    Icons.more_vert,
                  ),
                ),
              ],
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            controller: searchProfile
                ? controller.scrollController
                : profilScrollController,
            children: isServant
                ? [
                    ServantProfile(
                      searchProfile: searchProfile,
                      controller: controller,
                      photoUrls: photoUrls,
                    ),
                  ]
                : [
                    searchProfile
                        ? ServantProfile(
                            searchProfile: searchProfile,
                            controller: controller,
                            photoUrls: photoUrls,
                          )
                        : VendeeProfile(
                            searchProfile: searchProfile,
                            controller: controller,
                            photoUrls: photoUrls,
                          ),
                  ],
          ),
        ),
      ),
      bottomNavigationBar: searchProfile
          ? SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: AllMaterial.cusButton(
                  label: "Tawar Servant",
                  icon: Icon(
                    Icons.swap_horizontal_circle_outlined,
                    color: AllMaterial.colorWhite,
                  ),
                  onTap: () {
                    AllMaterial.messageScaffold(
                        title: "Mengarahkan ke chat untuk menawar");
                  },
                ),
              ),
            )
          : null,
    );
  }
}

class ServantProfile extends StatelessWidget {
  const ServantProfile({
    super.key,
    required this.searchProfile,
    required this.controller,
    required this.photoUrls,
  });

  final bool searchProfile;
  final ProfilController controller;
  final List<String> photoUrls;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AllMaterial.avatarWidget(
              isProfile: true,
              name: "John Borino",
              showEdit: !searchProfile,
              isOnline: searchProfile ? true : false,
              onEditTap: () {
                print(controller.histori);
                Get.to(
                  () => EditProfilView(),
                );
              },
              radius: 50,
            ),
            SizedBox(width: 35),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Wrap(
                    spacing: 15,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      AllMaterial.namaDenganVerified(
                        name: "John Borino",
                        isProfil: true,
                        isVerified: true,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star,
                            color: AllMaterial.colorSecondary,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "4.2",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Obx(
                    () {
                      if (controller.showFullDescription.value) {
                        return GestureDetector(
                          onTap: () => controller.showFullDescription.toggle(),
                          child: Text(
                            GeneralController.shortenWithSeeMore(
                              searchProfile
                                  ? "Seorang spesialis antar jemput yang siap dipanggil langsung kapan pun dibutuhkan. Berpengalaman, responsif, dan mengutamakan kenyamanan pelanggan."
                                  : "johnborino25@gmail.com",
                              maxLines: 1,
                              context: context,
                            ),
                          ),
                        );
                      } else {
                        return GestureDetector(
                          onTap: () => controller.showFullDescription.toggle(),
                          child: Text(
                            searchProfile
                                ? "Seorang spesialis antar jemput yang siap dipanggil langsung kapan pun dibutuhkan. Berpengalaman, responsif, dan mengutamakan kenyamanan pelanggan."
                                : "johnborino25@gmail.com",
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(height: 20),
        Text(
          "Layanan Unggulan",
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
            RandomTagContainer(label: "Spesialis Antar Jemput"),
          ],
        ),
        SizedBox(height: 20),
        Text(
          "Galeri ${searchProfile ? "Servant" : "Saya"}",
          style: TextStyle(
            fontWeight: AllMaterial.fontSemiBold,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 15),
        Column(
          children: List.generate(1, (index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: AllMaterial.spesialistCard(
                    name: "John Borino",
                    isGallery: true,
                    mediaAsset: [
                      "assets/logo/spesialis.jpg",
                      "assets/logo/iot.jpg",
                      "assets/logo/spesialis.jpg",
                      "assets/logo/iot.jpg",
                      "assets/logo/spesialis.jpg",
                      "assets/logo/iot.jpg",
                      "assets/logo/spesialis.jpg",
                      "assets/logo/iot.jpg",
                    ],
                    context: context,
                  ),
                ),
              ],
            );
          }),
        ),
        SizedBox(height: 20),
        !searchProfile
            ? InkWell(
                onTap: () {
                  // Get.to(() => PencarianView());
                  AllMaterial.messageScaffold(
                      title:
                          "Mengarahkan pada edit profil yang menampilkan pengalaman");
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Pengalaman ${searchProfile ? "Servant" : "Saya"}",
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
              )
            : Text(
                "Pengalaman ${searchProfile ? "Servant" : "Saya"}",
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
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: AllMaterial.colorPrimary,
                    child: Icon(
                      Icons.work_history,
                      color: AllMaterial.colorWhite,
                    ),
                  ),
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Text(
                          "S${index + 1} Jasa Angkut Barang",
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
                        "Pernah bekerja di PT. Jaya Abadi",
                        style: TextStyle(),
                      ),
                      Text(
                        "Dari Januari 2025 - 5 Bulan",
                        style: TextStyle(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            );
          }),
        ),
        SizedBox(height: 20),
        !searchProfile
            ? InkWell(
                onTap: () {
                  // Get.to(() => PencarianView());
                  AllMaterial.messageScaffold(
                      title:
                          "Mengarahkan pada edit profil yang menampilkan sertifikat");
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Lisensi & Sertifikat ${searchProfile ? "Servant" : "Saya"}",
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
              )
            : Text(
                "Lisensi & Sertifikat ${searchProfile ? "Servant" : "Saya"}",
                style: TextStyle(
                  fontWeight: AllMaterial.fontSemiBold,
                  fontSize: 16,
                ),
              ),
        SizedBox(height: 15),
        Column(
          children: List.generate(1, (index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: AllMaterial.colorPrimary,
                    child: Icon(
                      Icons.workspace_premium,
                      color: AllMaterial.colorWhite,
                    ),
                  ),
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Text(
                          "S${index + 1} Jasa Angkut Barang",
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
                        "Pernah bekerja di PT. Jaya Abadi",
                        style: TextStyle(),
                      ),
                      Text(
                        "Dari Januari 2025 - 5 Bulan",
                        style: TextStyle(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            );
          }),
        ),
        SizedBox(height: 20),
        !searchProfile
            ? InkWell(
                onTap: () {
                  // Get.to(() => PencarianView());
                  AllMaterial.messageScaffold(
                      title: "Mengarahkan pada list ulasan terbaru");
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Ulasan Terbaru ${searchProfile ? "Servant" : "Saya"}",
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
              )
            : Text(
                "Ulasan Terbaru ${searchProfile ? "Servant" : "Saya"}",
                style: TextStyle(
                  fontWeight: AllMaterial.fontSemiBold,
                  fontSize: 16,
                ),
              ),
        SizedBox(height: 25),
        ListView.builder(
          itemCount: controller.dataRating.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => AllMaterial.buildRating(
            context,
            controller.dataRating[index],
          ),
        ),
      ],
    );
  }
}

class VendeeProfile extends StatelessWidget {
  const VendeeProfile({
    super.key,
    required this.searchProfile,
    required this.controller,
    required this.photoUrls,
  });

  final bool searchProfile;
  final ProfilController controller;
  final List<String> photoUrls;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AllMaterial.avatarWidget(
              isProfile: true,
              name: "John Borino",
              showEdit: !searchProfile,
              isOnline: searchProfile ? true : false,
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
        InkWell(
          onTap: () {
            // Get.to(() => PencarianView());
            AllMaterial.messageScaffold(
                title: "Mengarahkan pada list histori pemesanan");
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Histori Pemesanan",
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
                    child: Icon(
                      Icons.home_repair_service,
                      color: AllMaterial.colorWhite,
                    ),
                  ),
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Text(
                          "Jasa Angkut Barang - Nama Servant ",
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
    );
  }
}
