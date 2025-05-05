import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pengenalan_controller.dart';

class PengenalanView extends GetView<PengenalanController> {
  const PengenalanView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PengenalanController());

    final pages = [
      {
        'title': 'Selamat Datang di Jaspelku',
        'desc':
            'Ekosistem pelayanan untuk semua kalangan.\nDekat, Cepat & Terpercaya!',
        'image': 'assets/logo/intro-1.jpg',
        'icon': Icons.diversity_3,
      },
      {
        'title': 'Akses Dalam Genggaman',
        'desc':
            'Nikmati layanan jasa dari orang-orang hebat tanpa ribet, cukup lewat satu aplikasi.',
        'image': 'assets/logo/intro-2.jpg',
        'icon': Icons.mobile_friendly,
      },
      {
        'title': 'Terbuka dan Inklusif',
        'desc': 'Siapa pun bisa mengakses dan memberi pelayanan dengan aman.',
        'image': 'assets/logo/intro-3.jpg',
        'icon': Icons.diversity_3,
      },
      {
        'title': 'Mulai Sekarang',
        'desc':
            'Gabung ke dalam ekosistem Jaspelku.\nNikmati pengalaman tak terlupakan!',
        'image': 'assets/logo/intro-4.jpg',
        'icon': Icons.rocket_launch,
      },
    ];

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: controller.pageController,
            pageSnapping: true,
            itemCount: pages.length,
            onPageChanged: (index) {
              controller.currentIndex.value = index;
              controller.isLast.value = index == pages.length - 1;
            },
            itemBuilder: (_, i) {
              final page = pages[i];
              return GestureDetector(
                onTap: () {
                  if (controller.currentIndex.value == pages.length - 1) {
                    controller.isLast.value = true;
                  } else {
                    controller.pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      page['image']!.toString(),
                      fit: BoxFit.cover,
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            page['icon'] as IconData,
                            size: 100,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 30),
                          Text(
                            page['title']!.toString(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            page['desc']!.toString(),
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                          Obx(() => controller.isLast.value
                              ? SizedBox(height: 15)
                              : SizedBox.shrink()),
                          Obx(
                            () => controller.isLast.value
                                ? ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14, horizontal: 24),
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onPressed: controller.selesaiPengenalan,
                                    child: const Text("Mulai Sekarang"),
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          // Indikator strip
          Positioned(
            bottom: context.mediaQueryPadding.bottom + 5,
            left: 0,
            right: 0,
            child: Obx(() {
              final current = controller.currentIndex.value;
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  pages.length,
                  (index) => GestureDetector(
                    onTap: () {
                      controller.pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 6,
                      width: current == index ? 30 : 10,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
