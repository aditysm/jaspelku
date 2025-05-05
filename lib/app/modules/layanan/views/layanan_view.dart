import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jaspelku/all_material.dart';
import 'package:jaspelku/app/controller/general_controller.dart';
import 'package:jaspelku/app/widget/random_topic_container.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:video_player/video_player.dart';

import '../controllers/layanan_controller.dart';

var showMedia = false.obs;

class LayananView extends GetView<LayananController> {
  final ScrollController? layananScrollController;
  const LayananView({super.key, this.layananScrollController});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LayananController());
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          var filtered = controller.layananController.text == ""
              ? [controller.postinganSaya, ...controller.postinganLainnya]
              : controller.filterPostingan(controller.searchQuery.value);

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 10),
                Expanded(
                  child: filtered.isNotEmpty
                      ? ListView.builder(
                          controller: layananScrollController,
                          itemCount: filtered.length,
                          itemBuilder: (context, index) {
                            final data = filtered[index];
                            return _buildPostingan(context, data, controller);
                          },
                        )
                      : Center(child: Text("Tidak ada postingan ditemukan")),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildPostingan(
    BuildContext context,
    Map<String, dynamic> data,
    LayananController controller,
  ) {
    final deskripsi = data['deskripsi'] ?? '';
    final showFullDescription = false.obs;
    final isPostinganSaya = data == controller.postinganSaya;
    final List media = data['media'] ?? [];

    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isPostinganSaya)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Icon(Icons.person_pin,
                      color: AllMaterial.colorPrimaryShade, size: 18),
                  SizedBox(width: 6),
                  Text(
                    "Tawaran Anda",
                    style: TextStyle(
                      color: AllMaterial.colorPrimaryShade,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

          // User info
          Row(
            children: [
              AllMaterial.avatarWidget(
                name: data['nama'][0],
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AllMaterial.namaDenganVerified(
                    name: AllMaterial.formatNamaPanjang(data['nama']),
                    isVerified: true,
                  ),
                  Text(
                    timeago.format(data['waktu']),
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  AllMaterial.bottomSheetMore(
                    2,
                    [
                      (AllMaterial.isServant.isTrue
                          ? "Ambil Tawaran"
                          : "Tawar Servant"),
                      isPostinganSaya ? "Hapus Tawaran" : "Hapus untuk Saya",
                    ],
                    [
                      () => Get.back(),
                      () => Get.back(),
                    ],
                    [
                      Icon(Icons.swap_horizontal_circle_outlined),
                      Icon(Icons.delete_outline),
                    ],
                  );
                },
                icon: Icon(Icons.more_horiz),
              ),
            ],
          ),
          SizedBox(height: 12),

          // Tags
          Wrap(
            spacing: 3,
            runSpacing: 5,
            children: [
              RandomTopicContainer(
                label: data['judul'],
                icon: Icons.home_repair_service,
              ),
              RandomTopicContainer(
                label: data['jenis'],
                icon: Icons.category_rounded,
              ),
              RandomTopicContainer(
                label: data['lokasi'],
                icon: Icons.location_on,
              ),
            ],
          ),
          SizedBox(height: 12),

          // Deskripsi
          Obx(
            () => GestureDetector(
              onTap: () => showFullDescription.toggle(),
              child: Text(
                showFullDescription.value
                    ? deskripsi
                    : GeneralController.shortenWithSeeMore(deskripsi,
                        maxLines: 3, context: context),
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          SizedBox(height: 12),

          // Media Display
          if (media.isNotEmpty)
            Column(
              children: [
                if (media.length > 3)
                  Stack(
                    children: [
                      GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 3,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 6,
                        ),
                        itemBuilder: (context, index) {
                          String mediaItem = media[index];
                          final isVideo = mediaItem.endsWith('.mp4') ||
                              mediaItem.endsWith('.mov');
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: GestureDetector(
                              onTap: () {
                                _showFullScreenMedia(context, media, index,
                                    deskripsi, data["nama"]);
                              },
                              child: isVideo
                                  ? _buildVideoPlayer(mediaItem)
                                  : Image.asset(
                                      mediaItem,
                                      width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          );
                        },
                      ),
                      Positioned(
                        right: 8,
                        bottom: 8,
                        child: Container(
                          color: Colors.black.withOpacity(0.5),
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Text(
                            "+${media.length - 3}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: media.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 6,
                    ),
                    itemBuilder: (context, index) {
                      String mediaItem = media[index];
                      final isVideo = mediaItem.endsWith('.mp4') ||
                          mediaItem.endsWith('.mov');
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: GestureDetector(
                          onTap: () {
                            _showFullScreenMedia(
                                context, media, index, deskripsi, data["nama"]);
                          },
                          child: isVideo
                              ? _buildVideoPlayer(mediaItem)
                              : Image.asset(
                                  mediaItem,
                                  width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      );
                    },
                  ),
              ],
            ),

          SizedBox(height: 12),

          // Tombol Tawar
          Stack(
            clipBehavior: Clip.none,
            children: [
              Material(
                color: AllMaterial.colorPrimary,
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  onTap: () {
                    AllMaterial.messageScaffold(
                      title: isPostinganSaya
                          ? "Membuka tawaran dan user dapat mengedit tawaran"
                          : "Mengarahkan ke chat dan membuat tawaran",
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    width: Get.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                            isPostinganSaya
                                ? Icons.edit
                                : Icons.swap_horizontal_circle_outlined,
                            color: AllMaterial.colorWhite),
                        SizedBox(width: 8),
                        Text(
                          isPostinganSaya
                              ? "Edit Tawaran"
                              : AllMaterial.isServant.value
                                  ? "Ambil Tawaran"
                                  : "Tawar Servant",
                          style: TextStyle(
                            color: AllMaterial.colorWhite,
                            fontWeight: AllMaterial.fontSemiBold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -40,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.green.shade600,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        data['harga'],
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ClipPath(
                      clipper: TriangleClipper(),
                      child: Container(
                        height: 12,
                        width: 16,
                        color: Colors.green.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Divider(),
        ],
      ),
    );
  }

  // Widget untuk menampilkan video
  Widget _buildVideoPlayer(String videoPath) {
    final VideoPlayerController controller =
        VideoPlayerController.asset(videoPath);

    return FutureBuilder(
      future: controller.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: Stack(
              alignment: Alignment.center,
              children: [
                VideoPlayer(controller),
                IconButton(
                  icon: Icon(Icons.play_circle_fill,
                      color: Colors.white, size: 40),
                  onPressed: () {
                    controller.value.isPlaying
                        ? controller.pause()
                        : controller.play();
                  },
                ),
              ],
            ),
          );
        } else {
          return SizedBox(
            height: 100,
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  void _showFullScreenMedia(
    BuildContext context,
    List<dynamic> media,
    int initialIndex,
    String deskripsi,
    String nama,
  ) {
    final pageController = PageController(initialPage: initialIndex);
    int currentPage = initialIndex;
    final showFullDescription = false.obs;
    final hideUI = ValueNotifier(false);
    final transformationController = TransformationController();
    final ScrollController descScrollController = ScrollController();

    transformationController.addListener(() {
      final scale = transformationController.value.getMaxScaleOnAxis();
      final shouldHide = scale > 1.0;

      if (hideUI.value != shouldHide) {
        hideUI.value = shouldHide;
        if (shouldHide) {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
        } else {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        }
      }

      if (shouldHide && showFullDescription.value) {
        showFullDescription.value = false;
      }
    });

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      // backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            double dragOffset = 0;
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                if (showFullDescription.value) {
                  showFullDescription.value = false;
                }
              },
              onVerticalDragUpdate: (details) {
                dragOffset += details.primaryDelta ?? 0;
              },
              onVerticalDragEnd: (details) {
                if (dragOffset > 120) {
                  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
                  Get.back();
                }
                dragOffset = 0;
              },
              child: ClipRRect(
                borderRadius: BorderRadius.zero,
                child: Scaffold(
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(kToolbarHeight + 25),
                    child: ValueListenableBuilder<bool>(
                        valueListenable: hideUI,
                        builder: (context, hidden, child) {
                          if (hidden) return SizedBox.shrink();
                          return Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: ValueListenableBuilder<bool>(
                              valueListenable: hideUI,
                              builder: (context, hidden, child) {
                                if (hidden) return SizedBox.shrink();
                                return AppBar(
                                  surfaceTintColor: Colors.black,
                                  title: Text(
                                    AllMaterial.formatNamaPanjang(nama),
                                    style: TextStyle(
                                        color: AllMaterial.colorWhite),
                                  ),
                                  leading: IconButton(
                                    splashColor: AllMaterial.colorWhite,
                                    highlightColor:
                                        Colors.white70.withOpacity(0.5),
                                    onPressed: () {
                                      SystemChrome.setEnabledSystemUIMode(
                                          SystemUiMode.edgeToEdge);
                                      Get.back();
                                    },
                                    icon: Icon(Icons.arrow_back,
                                        color: AllMaterial.colorWhite),
                                  ),
                                  backgroundColor: Colors.transparent,
                                );
                              },
                            ),
                          );
                        }),
                  ),
                  backgroundColor: Colors.black,
                  body: Stack(
                    children: [
                      PageView.builder(
                        pageSnapping: true,
                        controller: pageController,
                        itemCount: media.length,
                        onPageChanged: (index) {
                          setState(() {
                            currentPage = index;
                            hideUI.value = false;
                            showFullDescription.value = false;
                            transformationController.value = Matrix4.identity();
                            SystemChrome.setEnabledSystemUIMode(
                                SystemUiMode.edgeToEdge);
                            transformationController.value = Matrix4.identity();
                          });
                        },
                        itemBuilder: (context, index) {
                          final mediaItem = media[index];
                          return AllMaterial.buildMedia(
                              mediaItem, hideUI, transformationController);
                        },
                      ),
                      ValueListenableBuilder<bool>(
                        valueListenable: hideUI,
                        builder: (context, hidden, child) {
                          if (hidden) return SizedBox.shrink();
                          if (media.length <= 1) return SizedBox.shrink();
                          return Positioned(
                            top: 16,
                            right: 16,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${currentPage + 1} / ${media.length}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                          );
                        },
                      ),

                      // Ini tetap untuk "Page Indicator" di pojok kanan atas
                      ValueListenableBuilder<bool>(
                        valueListenable: hideUI,
                        builder: (context, hidden, child) {
                          if (hidden) return SizedBox.shrink();
                          if (media.length <= 1) return SizedBox.shrink();
                          return Positioned(
                            top: 16,
                            right: 16,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${currentPage + 1} / ${media.length}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                          );
                        },
                      ),

                      ValueListenableBuilder<bool>(
                        valueListenable: hideUI,
                        builder: (context, hidden, child) {
                          if (hidden) return SizedBox.shrink();
                          return Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Obx(() {
                              final isFull = showFullDescription.value;

                              if (!isFull) {
                                return GestureDetector(
                                  onTap: () => showFullDescription.toggle(),
                                  child: Container(
                                    width: double.infinity,
                                    color: Colors.black38,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 15,
                                    ).copyWith(
                                        bottom:
                                            context.mediaQueryPadding.bottom +
                                                20),
                                    child: Text(
                                      GeneralController.shortenWithSeeMore(
                                        deskripsi,
                                        maxLines: 3,
                                        context: context,
                                      ),
                                      style: TextStyle(
                                          color: AllMaterial.colorWhite),
                                    ),
                                  ),
                                );
                              }

                              return SafeArea(
                                child: Container(
                                  color: Colors.black38,
                                  constraints: BoxConstraints(
                                    maxHeight:
                                        MediaQuery.of(context).size.height *
                                            0.4,
                                  ),
                                  child: Scrollbar(
                                    controller: descScrollController,
                                    thumbVisibility: true,
                                    child: SingleChildScrollView(
                                      controller: descScrollController,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 15,
                                      ).copyWith(
                                          bottom:
                                              context.mediaQueryPadding.bottom),
                                      child: GestureDetector(
                                        onTap: () =>
                                            showFullDescription.toggle(),
                                        child: Text(
                                          deskripsi,
                                          style: TextStyle(
                                            color: AllMaterial.colorWhite,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// Custom triangle shape (untuk harga)
class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width / 2, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}
