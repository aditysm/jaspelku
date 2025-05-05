import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaspelku/all_material.dart';
import 'package:jaspelku/app/modules/home/views/home_view.dart';
import 'package:jaspelku/app/modules/layanan/controllers/layanan_controller.dart';
import 'package:jaspelku/app/modules/layanan/views/layanan_view.dart';
import 'package:jaspelku/app/modules/main_page/controllers/main_page_controller.dart';
import 'package:jaspelku/app/modules/notifikasi/views/notifikasi_view.dart';
import 'package:jaspelku/app/modules/pencarian/views/pencarian_view.dart';
import 'package:jaspelku/app/modules/pengaturan/views/pengaturan_view.dart';
import 'package:jaspelku/app/modules/pesan/controllers/pesan_controller.dart';
import 'package:jaspelku/app/modules/pesan/views/pesan_view.dart';
import 'package:jaspelku/app/modules/postingan_baru/views/postingan_baru_view.dart';
import 'package:jaspelku/app/modules/profil/views/profil_view.dart';
import 'package:badges/badges.dart' as badges;
import 'package:svg_flutter/svg.dart';

class MainPageView extends StatefulWidget {
  const MainPageView({super.key});

  @override
  State<MainPageView> createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView> {
  final messCont = Get.put(PesanController());
  final layananCont = Get.put(LayananController());

  bool isSearching = false;
  bool isSearchingMessage = false;
  final TextEditingController searchController = TextEditingController();

  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  final controller = Get.put(MainPageController());

  final ScrollController homeScrollController = ScrollController();
  final ScrollController layananScrollController = ScrollController();
  final ScrollController pesanScrollController = ScrollController();
  final ScrollController profilScrollController = ScrollController();

  List<Widget> buildScreens() => [
        HomeView(homeScrollController: homeScrollController),
        LayananView(layananScrollController: layananScrollController),
        PesanView(pesanScrollController: pesanScrollController),
        ProfilView(profilScrollController: profilScrollController),
      ];

  PreferredSizeWidget? appBarBuilder() {
    if (_selectedIndex == 0) {
      if (isSearching) {
        return AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                isSearching = false;
                searchController.clear();
              });
            },
          ),
          title: TextField(
            controller: searchController,
            focusNode: controller.searchNode,
            autofocus: true,
            onTapOutside: (_) {
              controller.searchNode.unfocus();
              setState(() {
                isSearching = false;
                searchController.clear();
              });
            },
            cursorColor: AllMaterial.colorPrimary,
            decoration: const InputDecoration(
              hintStyle: TextStyle(fontWeight: AllMaterial.fontRegular),
              hintText: 'Cari layanan...',
              border: InputBorder.none,
            ),
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  isSearching = false;
                  searchController.clear();
                });
                Get.to(() => PencarianView(), arguments: value);
              }
            },
          ),
        );
      }

      return AppBar(
        title: Row(
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
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => NotifikasiView());
            },
            icon: const Icon(Icons.notifications),
          ),
          AllMaterial.isServant.isTrue
              ? SizedBox.shrink()
              : IconButton(
                  tooltip: "Cari Layanan",
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                  icon: const Icon(Icons.search),
                ),
        ],
      );
    }

    if (_selectedIndex == 1) {
      if (layananCont.isSearching.value) {
        return AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                layananCont.isSearching.value = false;
                layananCont.layananController.clear();
              });
            },
          ),
          title: TextField(
            controller: layananCont.layananController,
            focusNode: controller.searchNode,
            autofocus: true,
            onChanged: (value) => layananCont.searchQuery.value = value,
            onTapOutside: (_) {
              controller.searchNode.unfocus();
              setState(() {
                layananCont.isSearching.value = false;
                layananCont.layananController.clear();
                layananCont.update();
              });
            },
            cursorColor: AllMaterial.colorPrimary,
            decoration: const InputDecoration(
              hintStyle: TextStyle(fontWeight: AllMaterial.fontRegular),
              hintText: 'Cari postingan...',
              border: InputBorder.none,
            ),
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  layananCont.isSearching.value = false;
                  layananCont.layananController.clear();
                });
                Get.to(() => PencarianView(), arguments: value);
              }
            },
          ),
        );
      }

      return AppBar(
        title: Row(
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
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => NotifikasiView());
            },
            icon: const Icon(Icons.notifications),
          ),
          IconButton(
            tooltip: "Cari Postingan",
            onPressed: () {
              setState(() {
                layananCont.isSearching.value = true;
              });
            },
            icon: const Icon(Icons.search),
          ),
        ],
      );
    }

    if (_selectedIndex == 3) {
      if (messCont.isSearchingMessage.value) {
        return AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                messCont.isSearchingMessage.value = false;
                controller.messageController.clear();
              });
            },
          ),
          title: TextField(
            controller: controller.messageController,
            focusNode: controller.messageNode,
            autofocus: true,
            onChanged: (value) => messCont.searchMessage(value),
            onTapOutside: (_) {
              controller.messageNode.unfocus();
              setState(() {
                messCont.isSearchingMessage.value = false;
                controller.messageController.clear();
              });
            },
            cursorColor: AllMaterial.colorPrimary,
            decoration: const InputDecoration(
              hintStyle: TextStyle(fontWeight: AllMaterial.fontRegular),
              hintText: 'Cari pesan...',
              border: InputBorder.none,
            ),
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  messCont.isSearchingMessage.value = false;
                  controller.messageController.clear();
                });
              }
            },
          ),
        );
      }

      return AppBar(
        title: Row(
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
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => NotifikasiView());
            },
            icon: const Icon(Icons.notifications),
          ),
          IconButton(
            tooltip: "Cari Pesan",
            onPressed: () {
              setState(() {
                messCont.isSearchingMessage.value = true;
              });
            },
            icon: const Icon(Icons.search),
          ),
        ],
      );
    }

    if (_selectedIndex == 4) {
      return AppBar(
        actions: [
          IconButton(
            tooltip: "Hubungi Admin",
            onPressed: () =>
                AllMaterial.messageScaffold(title: "Menampilkan chat admin"),
            icon: const Icon(
              Icons.headset_mic_outlined,
            ),
          ),
          IconButton(
            tooltip: "Pengaturan",
            onPressed: () => Get.to(() => PengaturanView()),
            icon: const Icon(Icons.settings),
          ),
        ],
        title: Row(
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
      );
    }

    return null;
  }

  void _onItemTapped(int index) {
    if (index == 2) {
      Get.to(() => PostinganBaruView());
      return;
    }

    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });

    int targetPageIndex = index > 2 ? index - 1 : index;

    _pageController.animateToPage(
      targetPageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void _onItemDoubleTapped(int index) {
    final Map<int, ScrollController> controllerMap = {
      0: homeScrollController,
      1: layananScrollController,
      3: pesanScrollController,
      4: profilScrollController,
    };

    if (controllerMap.containsKey(index)) {
      controllerMap[index]!.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBuilder(),
      body: PageView(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index >= 2 ? index + 1 : index;
          });
        },
        children: buildScreens(),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor:
              AllMaterial.isDarkMode.isFalse ? AllMaterial.colorWhite : null,
          selectedItemColor: AllMaterial.isDarkMode.value
              ? AllMaterial.colorWhite
              : AllMaterial.colorComplementaryBlue,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: [
            BottomNavigationBarItem(
              icon: GestureDetector(
                onDoubleTap: () => _onItemDoubleTapped(0),
                child: const Icon(Icons.home),
              ),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                onDoubleTap: () => _onItemDoubleTapped(1),
                child: const Icon(Icons.home_repair_service),
              ),
              label: 'Layanan',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.add_sharp),
              label: 'Posting',
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                onDoubleTap: () => _onItemDoubleTapped(3),
                child: Obx(
                  () => (messCont.filteredChat.isEmpty)
                      ? const Icon(Icons.mail)
                      : badges.Badge(
                          position: badges.BadgePosition.topEnd(),
                          showBadge: true,
                          badgeStyle: const badges.BadgeStyle(
                            badgeColor: AllMaterial.colorPrimary,
                            padding: EdgeInsets.all(6),
                            elevation: 0,
                          ),
                          badgeContent: Obx(
                            () => Text(
                              '${messCont.filteredChat.length}',
                              style: TextStyle(
                                color: AllMaterial.colorWhite,
                                fontSize: 12,
                                fontWeight: AllMaterial.fontBold,
                              ),
                            ),
                          ),
                          child: const Icon(Icons.mail),
                        ),
                ),
              ),
              label: 'Pesan',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
