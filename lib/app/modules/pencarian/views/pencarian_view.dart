import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaspelku/all_material.dart';
import 'package:jaspelku/app/modules/profil/views/profil_view.dart';
import 'package:svg_flutter/svg.dart';
import '../controllers/pencarian_controller.dart';

// ignore: must_be_immutable
class PencarianView extends GetView<PencarianController> {
  const PencarianView({super.key});

  @override
  Widget build(BuildContext context) {
    final PencarianController controller = Get.put(PencarianController());
    controller.searchNode.unfocus();
    final filteredServants = controller.data.where((servant) {
      if (controller.selectedRating.value == 'high' &&
          (servant['rating'] ?? 0) < 4.0) {
        return false;
      }
      if (controller.selectedRating.value == 'low' &&
          (servant['rating'] ?? 5) > 2.0) {
        return false;
      }
      if (controller.selectedLocation.value.isNotEmpty &&
          servant['location'] != controller.selectedLocation.value) {
        return false;
      }
      if (controller.jenisJasa.value.isNotEmpty &&
          !(servant['jenis_jasa'] ?? []).contains(controller.jenisJasa.value)) {
        return false;
      }
      if (controller.selectedKategori.value.isNotEmpty &&
          servant['kategori'] != controller.selectedKategori.value) {
        return false;
      }
      if (controller.isOnline.value && servant['isOnline'] != true) {
        return false;
      }
      if (controller.isVerified.value && servant['isVerified'] != true) {
        return false;
      }
      return true;
    }).toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Obx(() {
          return controller.isSearching.value
              ? AppBar(
                  leading: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      Future.delayed(Durations.long1);
                      controller.toggleSearch();
                      controller.searchText.text = '';
                    },
                  ),
                  title: TextField(
                    controller: controller.searchText,
                    focusNode: controller.searchNode,
                    cursorColor: AllMaterial.colorPrimary,
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(fontWeight: AllMaterial.fontRegular),
                      hintText: 'Cari...',
                      border: InputBorder.none,
                    ),
                    onTapOutside: (event) {
                      controller.searchNode.unfocus();
                      controller.isSearching.value = false;
                      controller.resetFilters();
                      controller.searchText.text = "";
                    },
                    textInputAction: TextInputAction.search,
                    onChanged: (text) {
                      controller.submitSearch();
                    },
                    onSubmitted: (_) {
                      controller.submitSearch();
                    },
                  ),
                  actions: [
                    Builder(
                      builder: (context) => IconButton(
                        icon: Icon(
                          Icons.filter_alt,
                        ),
                        onPressed: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                      ),
                    ),
                  ],
                )
              : AppBar(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/logo/logo.svg",
                        color: AllMaterial.colorPrimary,
                        width: 18,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "Jaspelku",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: AllMaterial.fontBold,
                        ),
                      ),
                    ],
                  ),
                  centerTitle: true,
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: controller.toggleSearch,
                    ),
                    Builder(
                      builder: (context) => IconButton(
                        icon: Icon(
                          Icons.filter_alt,
                        ),
                        onPressed: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                      ),
                    ),
                  ],
                );
        }),
      ),
      onEndDrawerChanged: (isOpened) {
        if (!isOpened) {
          controller.filteredData
              .assignAll(controller.applyFilters(controller.data));
        }
      },
      endDrawer: BuildEndDrawer(controller: controller),
      body: Obx(
        () {
          final filtered = controller.filteredData;
          if (filtered.isEmpty) {
            return Center(
              child: Text("Tidak ada hasil ditemukan."),
            );
          }
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListView(
                children: [
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(
                      controller.data.length,
                      (index) {
                        final servant = controller.isReset.isTrue
                            ? controller.data[index]
                            : filteredServants[index];

                        return InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            Get.to(() => ProfilView(), arguments: {
                              "searchProfile": true,
                            });
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width - 50) / 2,
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AllMaterial.avatarWidget(
                                    name: servant['name'] ?? "Servant"),
                                SizedBox(height: 8),
                                AllMaterial.namaDenganVerified(
                                  name: servant['name'] ?? "Servant",
                                  isVerified: servant['isVerified'] ?? false,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  servant['bio'] ?? '',
                                  style: Theme.of(context).textTheme.bodySmall,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 6),
                                Row(
                                  children: [
                                    Icon(Icons.star,
                                        color: AllMaterial.colorPrimaryShade),
                                    SizedBox(width: 4),
                                    Text((servant['rating'] ?? 0).toString()),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(Icons.location_on,
                                        color: Colors.redAccent),
                                    SizedBox(width: 4),
                                    Flexible(
                                      child: Text(
                                        servant['location'] ?? '',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                AllMaterial.cusButton(
                                  onTap: () {
                                    AllMaterial.messageScaffold(
                                        title:
                                            "Mengarahkan ke chat untuk menawar");
                                  },
                                  icon: Icon(
                                    Icons.swap_horizontal_circle_outlined,
                                    color: AllMaterial.colorWhite,
                                  ),
                                  label: "Tawar",
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class BuildEndDrawer extends StatelessWidget {
  const BuildEndDrawer({
    super.key,
    required this.controller,
  });

  final PencarianController controller;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor:
          AllMaterial.isDarkMode.isFalse ? AllMaterial.colorWhite : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      surfaceTintColor:
          AllMaterial.isDarkMode.isFalse ? AllMaterial.colorWhite : null,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter Servant',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                    controller.resetFilters();
                  },
                  child: Text(
                    'Reset Filter',
                    style: TextStyle(
                      color: AllMaterial.colorPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('Rating'),
            Wrap(
              spacing: 10,
              children: [
                Obx(() => ChoiceChip(
                      backgroundColor: Colors.transparent,
                      selectedColor: AllMaterial.colorPrimary,
                      checkmarkColor: AllMaterial.colorWhite,
                      label: Text(
                        "Tertinggi",
                        style: TextStyle(
                          color: controller.selectedRating.value == 'high'
                              ? AllMaterial.colorWhite
                              : (AllMaterial.isDarkMode.isTrue
                                  ? AllMaterial.colorWhite
                                  : AllMaterial.colorBlackPrimary),
                        ),
                      ),
                      selected: controller.selectedRating.value == 'high',
                      onSelected: (_) {
                        controller.selectedRating.value = 'high';
                      },
                    )),
                Obx(() => ChoiceChip(
                      backgroundColor: Colors.transparent,
                      selectedColor: AllMaterial.colorPrimary,
                      checkmarkColor: AllMaterial.colorWhite,
                      label: Text(
                        "Terendah",
                        style: TextStyle(
                          color: controller.selectedRating.value == 'low'
                              ? AllMaterial.colorWhite
                              : (AllMaterial.isDarkMode.isTrue
                                  ? AllMaterial.colorWhite
                                  : AllMaterial.colorBlackPrimary),
                        ),
                      ),
                      selected: controller.selectedRating.value == 'low',
                      onSelected: (_) {
                        controller.selectedRating.value = 'low';
                      },
                    )),
              ],
            ),
            SizedBox(height: 20),
            Text('Lokasi'),
            Wrap(
              spacing: 10,
              children: [
                Obx(() => ChoiceChip(
                      backgroundColor: Colors.transparent,
                      selectedColor: AllMaterial.colorPrimary,
                      checkmarkColor: AllMaterial.colorWhite,
                      label: Text(
                        "Terdekat",
                        style: TextStyle(
                          color: controller.selectedLocation.value == 'near'
                              ? AllMaterial.colorWhite
                              : (AllMaterial.isDarkMode.isTrue
                                  ? AllMaterial.colorWhite
                                  : AllMaterial.colorBlackPrimary),
                        ),
                      ),
                      selected: controller.selectedLocation.value == 'near',
                      onSelected: (_) {
                        controller.selectedLocation.value = 'near';
                      },
                    )),
                Obx(() => ChoiceChip(
                      backgroundColor: Colors.transparent,
                      selectedColor: AllMaterial.colorPrimary,
                      checkmarkColor: AllMaterial.colorWhite,
                      label: Text(
                        "Terjauh",
                        style: TextStyle(
                          color: controller.selectedLocation.value == 'far'
                              ? AllMaterial.colorWhite
                              : (AllMaterial.isDarkMode.isTrue
                                  ? AllMaterial.colorWhite
                                  : AllMaterial.colorBlackPrimary),
                        ),
                      ),
                      selected: controller.selectedLocation.value == 'far',
                      onSelected: (_) {
                        controller.selectedLocation.value = 'far';
                      },
                    )),
              ],
            ),
            SizedBox(height: 20),
            Text('Kategori Jasa'),
            SizedBox(height: 10),
            Obx(() {
              return DropdownButtonFormField<String>(
                dropdownColor: AllMaterial.isDarkMode.isTrue
                    ? Color(0xFF121212)
                    : AllMaterial.colorWhite,
                decoration: InputDecoration(
                  fillColor: AllMaterial.isDarkMode.isTrue
                      ? Color(0xFF121212)
                      : AllMaterial.colorWhite,
                  hintText: "Pilih Kategori Jasa",
                  border: OutlineInputBorder(),
                ),
                hint: Text('Pilih Kategori Jasa'),
                value: controller.selectedKategori.value.isNotEmpty
                    ? controller.selectedKategori.value
                    : null,
                items: AllMaterial.jenisJasaMap.keys.toList().map((kategori) {
                  return DropdownMenuItem(
                    value: kategori,
                    child: Text(kategori),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.selectedKategori.value = value ?? "";
                  controller.jenisJasa.value = "";
                },
                isExpanded: true,
              );
            }),
            SizedBox(height: 20),
            Text('Jenis Jasa'),
            SizedBox(height: 10),
            Obx(() {
              final jenisJasaList = controller
                  .getJenisJasaByKategori(controller.selectedKategori.value)
                  .toSet()
                  .toList();
              return DropdownButtonFormField<String>(
                dropdownColor: AllMaterial.isDarkMode.isTrue
                    ? Color(0xFF121212)
                    : AllMaterial.colorWhite,
                decoration: InputDecoration(
                  fillColor: AllMaterial.isDarkMode.isTrue
                      ? Color(0xFF121212)
                      : AllMaterial.colorWhite,
                  hintText: "Pilih Jenis Jasa",
                  border: OutlineInputBorder(),
                ),
                value: jenisJasaList.contains(controller.jenisJasa.value)
                    ? controller.jenisJasa.value
                    : null,
                hint: Text('Pilih Jenis Jasa'),
                items: jenisJasaList.map((jenis) {
                  return DropdownMenuItem(
                    value: jenis,
                    child: Text(jenis),
                  );
                }).toList(),
                onChanged: controller.selectedKategori.value.isEmpty
                    ? null
                    : (value) {
                        controller.jenisJasa.value = value ?? "";
                      },
                isExpanded: true,
              );
            }),
            SizedBox(height: 20),
            Obx(
              () => CheckboxListTile(
                title: Text("Tersedia (Online)"),
                value: controller.isOnline.value,
                onChanged: (value) {
                  controller.isOnline.value = value ?? false;
                },
              ),
            ),
            Obx(
              () => CheckboxListTile(
                title: Text("Terverifikasi"),
                value: controller.isVerified.value,
                onChanged: (value) {
                  controller.isVerified.value = value ?? false;
                },
              ),
            ),
            SizedBox(height: 20),
            AllMaterial.cusButton(
              label: "Terapkan Filter",
              onTap: () {
                Get.back();
                controller.filteredData
                    .assignAll(controller.applyFilters(controller.data));
              },
            ),
          ],
        ),
      ),
    );
  }
}
