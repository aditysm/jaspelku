import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaspelku/all_material.dart';
import 'package:jaspelku/app/modules/main_page/views/main_page_view.dart';
import 'package:video_player/video_player.dart';
import '../controllers/postingan_baru_controller.dart';

class PostinganBaruView extends GetView<PostinganBaruController> {
  const PostinganBaruView({super.key});

  @override
  Widget build(BuildContext context) {
    final isTawaranBaru = Get.arguments?["isTawaranBaru"] == true;
    final controller = Get.put(PostinganBaruController());
    DateTime now = DateTime.now();
    TimeOfDay defaultStart = TimeOfDay.fromDateTime(now);
    TimeOfDay defaultEnd = TimeOfDay.fromDateTime(now.add(Duration(hours: 8)));

    controller.waktuMulaiC.text = controller.waktuMulaiC.text.isNotEmpty
        ? controller.waktuMulaiC.text
        : AllMaterial.formatTime24(defaultStart);
    controller.waktuSelesaiC.text = controller.waktuSelesaiC.text.isNotEmpty
        ? controller.waktuSelesaiC.text
        : AllMaterial.formatTime24(defaultEnd);
    final harga = int.tryParse(controller.totalHargaC.text) ?? 0;

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              if (harga == 0) {
                AllMaterial.messageScaffold(
                  title: "Tawaran Harga tidak boleh kosong",
                );
              } else {
                if (isTawaranBaru) {
                  Get.offAll(() => MainPageView());
                  AllMaterial.messageScaffold(
                    title: "Tawaran berhasil diajukan!",
                  );
                }

                // logika posting
                // Implement posting logic here
              }
            },
            child: Text(
              "Ajukan",
              style: TextStyle(
                color: AllMaterial.colorPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.clear),
        ),
        title: isTawaranBaru ? Text("Tawaran Baru") : Text("Postingan Baru"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 22,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        isTawaranBaru
                            ? Row(
                                children: [
                                  Text(
                                    "Nama Pengguna",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_right,
                                  ),
                                  Text(
                                    "Nama Servantt",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                "Nama Pengguna",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                        SizedBox(height: 3),
                        Wrap(
                          spacing: 3,
                          runSpacing: 5,
                          children: [
                            // Kategori
                            _buildTopic(
                              labelRx: controller.selectedKategori,
                              defaultLabel: "Kategori",
                              context: context,
                              title: "Pilih Kategori Jasa",
                              options: AllMaterial.jenisJasaMap.keys.toList(),
                              selected: controller.selectedKategori,
                              controller: controller,
                              isKategori: true,
                            ),

                            // Jenis Jasa
                            Obx(() {
                              final jenisList =
                                  controller.getJenisJasaByKategori(
                                      controller.selectedKategori.value);
                              return _buildTopic(
                                labelRx: controller.selectedJenis,
                                defaultLabel: "Jenis Jasa",
                                context: context,
                                title: "Pilih Jenis Jasa",
                                options: jenisList,
                                selected: controller.selectedJenis,
                                controller: controller,
                                isKategori: false,
                                onEmpty: () => AllMaterial.messageScaffold(
                                    title: "Pilih kategori terlebih dahulu"),
                                enabled: jenisList.isNotEmpty,
                              );
                            }),

                            // Lokasi
                            _buildTopic(
                              labelRx: controller.selectedLokasi,
                              defaultLabel: "Lokasi Kerja",
                              context: context,
                              title: "Pilih Lokasi Kerja",
                              options: AllMaterial.isServant.isFalse
                                  ? ["Lokasi Saat Ini", "Tentukan Lokasi Saya"]
                                  : [
                                      "Lokasi Saat Ini",
                                      "Sekitar Saya (Radius 5 km)",
                                      'Dalam Kota',
                                      'Luar Kota / Antar Provinsi',
                                      'Online / Remote Service',
                                      'Mana Saja'
                                    ],
                              selected: controller.selectedLokasi,
                              controller: controller,
                              isKategori: false,
                              isSearch: true,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Obx(
                () => TextField(
                  controller: controller.kebutuhanC,
                  focusNode: controller.kebutuhanF,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  onTapOutside: (_) => controller.kebutuhanF.unfocus(),
                  decoration: InputDecoration(
                    fillColor: AllMaterial.isDarkMode.isTrue
                        ? Color(0xFF121212)
                        : null,
                    hintStyle: TextStyle(fontWeight: AllMaterial.fontRegular),
                    hintText:
                        "Deskripsikan ${AllMaterial.isServant.isFalse ? "kebutuhan" : "jasa"} Anda...",
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Obx(() {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1,
                  ),
                  itemCount: controller.selectedMedia.length,
                  itemBuilder: (context, index) {
                    final file = controller.selectedMedia[index];

                    if (file.path.endsWith(".mp4")) {
                      VideoPlayerController videoController =
                          VideoPlayerController.file(File(file.path));
                      return FutureBuilder(
                        future: videoController.initialize(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Stack(
                              children: [
                                AspectRatio(
                                  aspectRatio:
                                      videoController.value.aspectRatio / 2,
                                  child: VideoPlayer(videoController),
                                ),
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: GestureDetector(
                                    onTap: () => controller.removeMedia(index),
                                    child: const CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.black54,
                                      child: Icon(Icons.close,
                                          size: 14, color: Colors.white),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  top: 0,
                                  right: 0,
                                  child: Icon(
                                    Icons.play_arrow,
                                    size: 50,
                                    color: AllMaterial.colorWhite,
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Icon(
                                Icons.videocam,
                              ),
                            );
                          }
                        },
                      );
                    } else {
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(file.path),
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: GestureDetector(
                              onTap: () => controller.removeMedia(index),
                              child: const CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.black54,
                                child: Icon(
                                  Icons.close,
                                  size: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                );
              }),

              const SizedBox(height: 12),

              TextButton.icon(
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: AllMaterial.isDarkMode.isTrue
                        ? Color(0xFF121212)
                        : AllMaterial.colorWhite,
                    context: context,
                    builder: (_) => SafeArea(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 15),
                          ListTile(
                            leading: const Icon(Icons.photo_library),
                            title: const Text("Dari Galeri"),
                            onTap: () {
                              Get.back();
                              controller.pickMediaFromGallery();
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.photo_camera),
                            title: const Text("Dari Kamera"),
                            onTap: () {
                              Get.back();
                              controller.pickMediaFromCamera();
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
                icon: Obx(
                  () => Icon(
                    Icons.add,
                    color: AllMaterial.isDarkMode.isTrue
                        ? AllMaterial.colorWhite
                        : AllMaterial.colorPrimary,
                  ),
                ),
                label: Obx(
                  () => Text(
                    "Tambah Media",
                    style: TextStyle(
                      color: AllMaterial.isDarkMode.isTrue
                          ? AllMaterial.colorWhite
                          : AllMaterial.colorPrimary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Price Range Inputs
              const Text("Tawaran Harga", style: TextStyle(fontSize: 16)),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: AllMaterial.textField(
                      controller: controller.totalHargaC,
                      color: AllMaterial.isDarkMode.isFalse
                          ? AllMaterial.colorPrimary
                          : null,
                      labelText: "Harga",
                      prefixText: "Rp ",
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              const Text("Jam Kerja", style: TextStyle(fontSize: 16)),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final picked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                          builder: (context, child) {
                            return MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(alwaysUse24HourFormat: true),
                              child: child!,
                            );
                          },
                        );
                        if (picked != null) {
                          controller.waktuMulaiC.text =
                              AllMaterial.formatTime24(picked);
                        }
                      },
                      child: AbsorbPointer(
                        child: AllMaterial.textField(
                          controller: controller.waktuMulaiC,
                          labelText: "Waktu Mulai",
                          prefix: Icon(Icons.access_time),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text("━"),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final picked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(
                            DateTime.now().add(
                              Duration(hours: 8),
                            ),
                          ),
                          builder: (context, child) {
                            return MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(alwaysUse24HourFormat: true),
                              child: child!,
                            );
                          },
                        );
                        if (picked != null) {
                          controller.waktuSelesaiC.text =
                              AllMaterial.formatTime24(picked);
                        }
                      },
                      child: AbsorbPointer(
                        child: AllMaterial.textField(
                          controller: controller.waktuSelesaiC,
                          labelText: "Waktu Selesai",
                          prefix: Icon(Icons.access_time),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              const Text("Hari Kerja", style: TextStyle(fontSize: 16)),
              const SizedBox(height: 15),
              Obx(
                () => DropdownButtonFormField<String>(
                  borderRadius: BorderRadius.circular(5),
                  dropdownColor: AllMaterial.isDarkMode.isTrue
                      ? Color(0xFF121212)
                      : AllMaterial.colorWhite,
                  decoration: InputDecoration(
                    fillColor: AllMaterial.isDarkMode.isTrue
                        ? Color(0xFF121212)
                        : AllMaterial.colorWhite,
                    hintText: "Pilih Jenis Hari",
                    border: OutlineInputBorder(),
                  ),
                  value: controller.selectedOpsi.value,
                  items: ['Sekali / Sehari', 'Kustom']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (val) {
                    controller.selectedOpsi.value = val!;
                    if (val == 'Sekali / Sehari') {
                      controller.selectedHari.clear();
                    }
                  },
                ),
              ),
              const SizedBox(height: 12),
              Obx(() {
                if (controller.selectedOpsi.value == 'Kustom') {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: controller.allHari.map((hari) {
                      return Obx(() => CheckboxListTile(
                            title: Text(hari),
                            value: controller.selectedHari.contains(hari),
                            onChanged: (bool? selected) {
                              if (selected == true) {
                                controller.selectedHari.add(hari);
                              } else {
                                controller.selectedHari.remove(hari);
                              }
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                          ));
                    }).toList(),
                  );
                }
                return const SizedBox.shrink();
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: AllMaterial.cusButton(
            label: "Ajukan Tawaran",
            onTap: () {
              if (harga == 0) {
                AllMaterial.messageScaffold(
                  title: "Tawaran Harga tidak boleh kosong",
                );
              } else {
                if (isTawaranBaru) {
                  Get.offAll(() => MainPageView());
                  AllMaterial.messageScaffold(
                    title: "Tawaran berhasil diajukan!",
                  );
                }
                // logika posting
                // Implement posting logic here
              }
            },
          ),
        ),
      ),
    );
  }
}

Widget _buildTopic({
  required RxString labelRx,
  required String defaultLabel,
  required BuildContext context,
  required String title,
  required List<String> options,
  required RxString selected,
  required PostinganBaruController controller,
  required bool isKategori,
  bool isSearch = false,
  bool enabled = true,
  VoidCallback? onEmpty,
}) {
  print(options);
  return Obx(() => TopicWidget(
        label: labelRx.value.isEmpty ? defaultLabel : labelRx.value,
        onTap: enabled
            ? () => showTopicOptions(
                  context: context,
                  title: title,
                  options: options,
                  selected: selected,
                  controller: controller,
                  isKategori: isKategori,
                  isSearch: isSearch,
                )
            : (onEmpty ?? () {}),
      ));
}

void showTopicOptions({
  required BuildContext context,
  required String title,
  required List<String> options,
  required RxString selected,
  bool isSearch = false,
  required PostinganBaruController controller,
  required bool isKategori,
}) {
  TextEditingController searchController = TextEditingController();
  List<String> originalOptions = options;

  RxList<String> filteredOptions = RxList<String>(originalOptions);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => Material(
      color: AllMaterial.isDarkMode.isFalse ? Colors.white : Colors.black,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 16, left: 20, right: 20, top: 16),
              child: Container(
                padding: const EdgeInsets.all(15),
                width: Get.height / 4.5,
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.clear),
                  ),
                ],
              ),
            ),

            (isSearch)
                ? SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: searchController,
                      style: TextStyle(fontWeight: AllMaterial.fontRegular),
                      decoration: InputDecoration(
                        hintText: 'Cari...',
                        hintStyle:
                            TextStyle(fontWeight: AllMaterial.fontRegular),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                      ),
                      onChanged: (query) {
                        filteredOptions.value = originalOptions
                            .where((item) => item
                                .toLowerCase()
                                .contains(query.toLowerCase()))
                            .toList();
                      },
                    ),
                  ),

            isSearch ? SizedBox.shrink() : const SizedBox(height: 10),

            // List pilihan
            Flexible(
              child: Obx(
                () => SingleChildScrollView(
                  child: Column(
                    children: filteredOptions
                        .map((item) => ListTile(
                              title: Text(item),
                              onTap: () {
                                selected.value = item;
                                Get.back();
                              },
                            ))
                        .toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ignore: must_be_immutable
class TopicWidget extends StatelessWidget {
  void Function()? onTap;
  String? label;
  TopicWidget({super.key, this.onTap, this.label});

  @override
  Widget build(BuildContext context) {
    return Material(
      color:
          AllMaterial.isDarkMode.isTrue ? Color(0xffFFC75F) : Color(0xffFEEBC8),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.add,
                size: 14,
                color: AllMaterial.isDarkMode.isTrue
                    ? Color(0xff1d1d1d)
                    : Color(0xffDD6B20),
              ),
              SizedBox(width: 2),
              Text(
                "$label",
                style: TextStyle(
                  color: AllMaterial.isDarkMode.isTrue
                      ? Color(0xff1d1d1d)
                      : Color(0xffDD6B20),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 2),
              Icon(
                Icons.arrow_drop_down,
                size: 16,
                color: AllMaterial.isDarkMode.isTrue
                    ? Color(0xff1d1d1d)
                    : Color(0xffDD6B20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
