import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jaspelku/all_material.dart';
import 'package:jaspelku/app/modules/histori_pesanan/views/histori_pesanan_view.dart';
import 'package:jaspelku/app/modules/pencarian/views/pencarian_view.dart';
import 'package:jaspelku/app/modules/profil/views/profil_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final ScrollController? homeScrollController;
  const HomeView({super.key, this.homeScrollController});
  @override
  Widget build(BuildContext context) {
    var isDark = AllMaterial.isDarkMode.value;
    final controller = Get.put(HomeController());
    var isServant = AllMaterial.isServant.value;
    final List<String> photoUrls = [
      "assets/logo/spesialis.jpg",
      "assets/logo/spesialis.jpg",
    ];
    print("role: ${isServant ? "Servant" : "Vendee"}");
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
                clipBehavior: Clip.none,
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
                  boxShadow: [
                    BoxShadow(
                      color: AllMaterial.colorPrimary.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Saldo Jaspel Coin",
                          style: TextStyle(
                            color: AllMaterial.colorWhite,
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: AllMaterial.colorWhite,
                          ),
                          onPressed: () {
                            final paymentUrl =
                                "https://app.sandbox.midtrans.com/snap/v2/vtweb/12345678-aaaa-bbbb-cccc-123456789abc";
                            controller.showMidtransWebView(paymentUrl);
                          },
                          child: Text(
                            "+ Topup",
                            style: TextStyle(
                              color: AllMaterial.colorPrimary,
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
                          AllMaterial.formatHarga("150000"),
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
              Obx(
                () => HomeController.isPesananAktif.isTrue
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            "Pesanan Aktif Saat Ini",
                            style: TextStyle(
                              fontWeight: AllMaterial.fontSemiBold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 10),
                          Material(
                            borderRadius: BorderRadius.circular(15),
                            color: isDark ? null : AllMaterial.colorWhite,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {
                                AllMaterial.bottomSheetMore(2, [
                                  "Hubungi ${!isServant ? "Servant" : "Vendee"}",
                                  isServant
                                      ? "Ajukan Pembatalan"
                                      : "Batalkan Pesanan",
                                ], [
                                  () => Get.back(),
                                  () {
                                    AllMaterial.cusDialogValidasi(
                                      title: isServant
                                          ? "Ajukan Pembatalan?"
                                          : "Membatalkan Pesanan?",
                                      subtitle:
                                          "${!isServant ? "Servant" : "Vendee"} akan diberitahu",
                                      onConfirm: () {
                                        HomeController.isPesananAktif.value =
                                            false;
                                        Get.back();
                                        Get.back();
                                        AllMaterial.messageScaffold(
                                          title: isServant
                                              ? "Ajuan pembatalan berhasil!"
                                              : "Pesanan berhasil dibatalkan!",
                                          adaKendala: true,
                                          kendalaTitle: "Laporkan Kendala",
                                          kendalaTap: () {},
                                        );
                                      },
                                      onCancel: () => Get.back(),
                                    );
                                  },
                                ], [
                                  Icon(Icons.chat_sharp),
                                  Icon(Icons.clear),
                                ]);
                              },
                              onLongPress: () {
                                AllMaterial.bottomSheetMore(2, [
                                  "Hubungi ${!isServant ? "Servant" : "Vendee"}",
                                  isServant
                                      ? "Ajukan Pembatalan"
                                      : "Batalkan Pesanan",
                                ], [
                                  () => Get.back(),
                                  () {
                                    AllMaterial.cusDialogValidasi(
                                      title: "Membatalkan Pesanan?",
                                      subtitle:
                                          "${!isServant ? "Servant" : "Vendee"} akan diberitahu",
                                      onConfirm: () {
                                        HomeController.isPesananAktif.value =
                                            false;
                                        Get.back();
                                        Get.back();
                                        AllMaterial.messageScaffold(
                                          title: isServant
                                              ? "Ajuan pembatalan berhasil!"
                                              : "Pesanan berhasil dibatalkan!",
                                          adaKendala: true,
                                          kendalaTitle: "Laporkan Kendala",
                                          kendalaTap: () {},
                                        );
                                      },
                                      onCancel: () => Get.back(),
                                    );
                                  },
                                ], [
                                  Icon(Icons.chat_sharp),
                                  Icon(Icons.clear),
                                ]);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      tileColor: isDark
                                          ? null
                                          : AllMaterial.colorWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(15),
                                        ),
                                      ),
                                      leading: AllMaterial.avatarWidget(
                                          name:
                                              "Nama ${!isServant ? "Servant" : "Vendee"}"),
                                      trailing: IconButton(
                                        onPressed: () {
                                          AllMaterial.bottomSheetMore(2, [
                                            "Hubungi ${!isServant ? "Servant" : "Vendee"}",
                                            isServant
                                                ? "Ajukan Pembatalan"
                                                : "Batalkan Pesanan",
                                          ], [
                                            () => Get.back(),
                                            () => AllMaterial.cusDialogValidasi(
                                                  title: "Membatalkan Pesanan",
                                                  subtitle:
                                                      "${isServant ? "Vendee" : "Servant"} akan diberitahu",
                                                  onConfirm: () {
                                                    HomeController
                                                        .isPesananAktif
                                                        .value = false;
                                                    Get.back();
                                                    Get.back();
                                                    AllMaterial.messageScaffold(
                                                      title: isServant
                                                          ? "Ajuan pembatalan berhasil!"
                                                          : "Pesanan berhasil dibatalkan!",
                                                      adaKendala: true,
                                                      kendalaTitle:
                                                          "Laporkan Kendala",
                                                      kendalaTap: () {},
                                                    );
                                                  },
                                                  onCancel: () => Get.back(),
                                                ),
                                          ], [
                                            Icon(Icons.chat_sharp),
                                            Icon(Icons.clear),
                                          ]);
                                        },
                                        icon: Icon(Icons.more_vert),
                                      ),
                                      title: Text(
                                        "Nama ${!isServant ? "Servant" : "Vendee"}",
                                        style: TextStyle(
                                          fontWeight: AllMaterial.fontSemiBold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "3 menit tersisa",
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 4),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.home_repair_service,
                                          ),
                                          SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              "Angkut Barang",
                                              style: TextStyle(
                                                color: isDark
                                                    ? Colors.white
                                                    : null,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 4),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.sticky_note_2_rounded,
                                          ),
                                          SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              "Minta tolong bang",
                                              style: TextStyle(
                                                color: isDark
                                                    ? Colors.white
                                                    : null,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 4),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                          ),
                                          SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              "Jl. Raya Besar, Jakarta Pusat No. 25",
                                              style: TextStyle(
                                                color: isDark
                                                    ? Colors.white
                                                    : Colors.black87,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Divider(thickness: 1),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 6),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Rp150.000",
                                            style: TextStyle(
                                              fontWeight:
                                                  AllMaterial.fontSemiBold,
                                              color: AllMaterial.colorPrimary,
                                              fontSize: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.fontSize,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Get.to(() => HistoriPesananView(),
                                                  arguments: {
                                                    "isPesananAktif": true,
                                                  });
                                            },
                                            child: Text(
                                              "Lihat",
                                              style: TextStyle(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : isServant
                        ? SizedBox.shrink()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Text(
                                "Rekomendasi Layanan",
                                style: TextStyle(
                                  fontWeight: AllMaterial.fontSemiBold,
                                  fontSize: 16,
                                ),
                              ),
                              Wrap(
                                alignment: WrapAlignment.center,
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
                            ],
                          ),
              ),
              isServant
                  ? Column(
                      children: [
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            // Get.to(() => PencarianView());
                            AllMaterial.messageScaffold(
                                title: "Mengarahkan ke list riwayat pelayanan");
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Riwayat Pelayanan",
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
                      ],
                    )
                  : SizedBox.shrink(),
              isServant
                  ? Column(
                      children: List.generate(photoUrls.length, (index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              onTap: () {
                                Get.to(() => HistoriPesananView());
                              },
                              contentPadding: EdgeInsets.zero,
                              trailing:
                                  const Icon(Icons.arrow_forward_ios_rounded),
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
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                            children: List.generate(
                              controller.servantUnggulan.value,
                              (index) => Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: AllMaterial.spesialistCard(
                                  name: "John Borino",
                                  isVerified: false,
                                  role: "Spesialis Antar",
                                  rating: 4.5,
                                  onTap: () {
                                    Get.to(() => ProfilView(), arguments: {
                                      "searchProfile": true,
                                    });
                                  },
                                  mediaAsset: index == 2
                                      ? [
                                          "assets/logo/iot.jpg",
                                          "assets/logo/spesialis.jpg",
                                          "assets/logo/spesialis.jpg",
                                        ]
                                      : [
                                          "assets/logo/spesialis.jpg",
                                          "assets/logo/iot.jpg"
                                        ],
                                  onTawarTap: () {
                                    AllMaterial.messageScaffold(
                                        title:
                                            "Mengarahkan ke chat room untuk menawar");
                                  },
                                  context: context,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
