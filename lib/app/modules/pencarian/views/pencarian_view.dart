import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaspelku/all_material.dart';
import 'package:svg_flutter/svg.dart';
import '../controllers/pencarian_controller.dart';

// ignore: must_be_immutable
class PencarianView extends GetView<PencarianController> {
  const PencarianView({super.key});

  @override
  Widget build(BuildContext context) {
    final PencarianController controller = Get.put(PencarianController());
    controller.searchNode.unfocus();
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
                      controller.searchText.text = "";
                    },
                    textInputAction: TextInputAction.search,
                    onChanged: (text) {
                      controller.updateSearchText(text);
                    },
                    onSubmitted: (_) {
                      controller.submitSearch();
                    },
                  ),
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
                  ],
                );
        }),
      ),
      body: Center(
        child: Text(
          controller.searchText.text,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
