import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jaspelku/all_material.dart';
import 'package:jaspelku/app/widget/random_topic_container.dart';
import 'package:video_player/video_player.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../controllers/histori_pesanan_controller.dart';

var showMedia = false.obs;

class HistoriPesananView extends GetView<HistoriPesananController> {
  const HistoriPesananView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HistoriPesananController());
    final pesanan = {
      'id': 'JAS123456',
      'status': 'Selesai',
      'servant': 'Habil Arlian Asrori',
      'waktu': '2 Mei 2025, 10:15',
      'jasa': 'Angkut Barang',
      'alamat': 'Jl. Mawar No. 12, Jakarta',
      'jam_kerja': "8 jam (12.00 - 20.00)",
      'hari_kerja': [
        "Senin",
        "Selasa",
        "Rabu",
        "Minggu",
      ],
      'metode_pembayaran': 'Jaspel Coin',
      'harga': 150000,
      'ongkir': 20000,
      'total': 170000,
    };

    final isBayar = Get.arguments?["isBayar"] == true;

    return Scaffold(
      appBar: AppBar(
        title: isBayar ? Text("Pembayaran") : Text('Histori Pesanan'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              // Status Pesanan
              isBayar
                  ? SizedBox.shrink()
                  : Container(
                      margin: EdgeInsets.only(
                        top: 16,
                      ),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Pesanan ${pesanan['status']}",
                        style: TextStyle(
                          fontWeight: AllMaterial.fontMedium,
                          color: AllMaterial.colorWhite,
                          fontSize:
                              Theme.of(context).textTheme.titleMedium?.fontSize,
                        ),
                      ),
                    ),
              SizedBox(height: 20),

              // Info Pesanan
              Text("Detil Pesanan",
                  style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: 10),
              _rowInfo("ID Pesanan : ", pesanan['id'].toString()),
              _rowInfo("Waktu Pesan : ", pesanan['waktu'].toString()),
              _rowInfo("Layanan : ", pesanan['jasa'].toString()),
              _rowInfo("Lokasi Kerja : ", pesanan['alamat'].toString()),
              SizedBox(height: 20),

              // Rincian Biaya
              Text("Rincian Pembayaran",
                  style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: 10),
              _rowInfo("Harga Jasa: ", "Rp${pesanan['harga']}"),
              _rowInfo("Ongkos Kirim : ", "Rp${pesanan['ongkir']}"),
              _rowInfo(
                  "Metode Pembayaran : ", "${pesanan['metode_pembayaran']}"),
              Divider(),
              _rowInfo(
                "Total Bayar : ",
                "Rp${pesanan['total']}",
                isBold: true,
                context: context,
              ),

              if (isBayar) ...[
                const SizedBox(height: 30),
                Text("Pilih Metode Pembayaran",
                    style: Theme.of(context).textTheme.titleMedium),
                SizedBox(height: 10),
                Obx(() => RadioListTile<MetodePembayaran>(
                      value: MetodePembayaran.jaspelCoin,
                      groupValue: controller.selectedMethod.value,
                      title: const Text("Jaspel Coin"),
                      subtitle: const Text("Bayar dengan saldo coin"),
                      onChanged: (value) {
                        if (value != null) controller.changeMethod(value);
                      },
                    )),
                Obx(() => RadioListTile<MetodePembayaran>(
                      value: MetodePembayaran.midtrans,
                      groupValue: controller.selectedMethod.value,
                      title: const Text("Midtrans"),
                      subtitle: const Text("Pembayaran QRIS/Virtual Account"),
                      onChanged: (value) {
                        if (value != null) controller.changeMethod(value);
                      },
                    )),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: AllMaterial.cusButton(
            label: isBayar ? "Bayar Sekarang" : "Lihat Ulasan Saya",
            onTap: () {
              if (isBayar) {
                // Logika pembayaran
                if (controller.selectedMethod.value ==
                    MetodePembayaran.jaspelCoin) {
                  // Proses Jaspel Coin
                  Get.snackbar("Pembayaran", "Bayar dengan Jaspel Coin");
                } else {
                  // Proses Midtrans
                  // Get.snackbar("Pembayaran", "Arahkan ke Midtrans");
                  controller.bayarSekarang();
                }
              } else {
                // Tampilkan ulasan
                showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: AllMaterial.isDarkMode.isFalse
                      ? AllMaterial.colorWhite
                      : null,
                  context: context,
                  builder: (context) {
                    return DraggableScrollableSheet(
                      initialChildSize: 0.6,
                      minChildSize: 0.3,
                      maxChildSize: 1,
                      expand: false,
                      builder: (context, scrollController) {
                        return Column(
                          children: [
                            SizedBox(height: 20),
                            Container(
                              padding: EdgeInsets.all(15),
                              width: Get.height / 4.5,
                              height: 4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 20),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: SingleChildScrollView(
                                  controller: scrollController,
                                  child: _buildRating(context, controller),
                                ),
                              ),
                            ),
                            SafeArea(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: AllMaterial.cusButton(
                                  label: "Tutup Ulasan",
                                  icon: Icon(Icons.clear,
                                      color: AllMaterial.colorWhite),
                                  onTap: () => Get.back(),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _rowInfo(String label, String value,
      {bool isBold = false, BuildContext? context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text(label)),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                fontSize: isBold
                    ? Theme.of(context!).textTheme.titleMedium?.fontSize
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRating(
    BuildContext context,
    HistoriPesananController controller,
  ) {
    final data = controller.dataRating;
    final deskripsi = data['deskripsi']?.toString() ?? '';
    final jamKerja = data["jam_kerja"]?.toString() ?? '';
    final List<dynamic> media = (data['media'] ?? []) as List<dynamic>;
    final List<dynamic> tags = (data['tags'] ?? []) as List<dynamic>;
    final List<dynamic> hariKerja = (data['hari_kerja'] ?? []) as List<dynamic>;

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header: Avatar, Nama, Rating
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: AllMaterial.colorPrimary,
                child: Text(
                  (data['nama'] ?? '').toString().substring(0, 1),
                  style: TextStyle(color: AllMaterial.colorWhite),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AllMaterial.formatNamaPanjang(
                          data['nama']?.toString() ?? ''),
                      style: TextStyle(
                        fontWeight: AllMaterial.fontBold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      timeago.format(DateTime.now()),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < (int.parse(data['rating'].toString()))
                        ? Icons.star
                        : Icons.star_border,
                    color: Colors.amber,
                    size: 20,
                  );
                }),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// Tags
          if ((data['judul'] ?? '').toString().isNotEmpty || tags.isNotEmpty)
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                if ((data['judul'] ?? '').toString().isNotEmpty)
                  RandomTopicContainer(
                    label: data['judul'].toString(),
                    icon: Icons.home_repair_service_rounded,
                  ),
                ...tags.map<Widget>((tag) {
                  return RandomTopicContainer(
                    label: tag.toString(),
                    icon: Icons.label_outline,
                  );
                }),
              ],
            ),

          const SizedBox(height: 12),

          /// Deskripsi, Jam Kerja, Hari Kerja
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Deskripsi
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Deskripsi : ",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Expanded(
                    child: Text(
                      deskripsi,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              /// Jam Kerja
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Jam Kerja : ",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Expanded(
                    child: Text(jamKerja, style: const TextStyle(fontSize: 14)),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // / Hari Kerja

              if (hariKerja.isNotEmpty)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Hari Kerja : ",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Expanded(
                      child: Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: List<Widget>.from(
                          hariKerja.map<Widget>(
                            (hari) => Text("$hari, "),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),

          const SizedBox(height: 12),

          /// Media
          if (media.isNotEmpty)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: media.length > 3 ? 3 : media.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
              ),
              itemBuilder: (context, index) {
                String mediaItem = media[index];
                final isVideo =
                    mediaItem.endsWith('.mp4') || mediaItem.endsWith('.mov');

                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: GestureDetector(
                    onTap: () {
                      _showFullScreenMedia(context, media, index, deskripsi,
                          data["nama"].toString());
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

          if (media.length > 3)
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 6, right: 4),
                child: Container(
                  color: Colors.black.withOpacity(0.6),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    "+${media.length - 3} lainnya",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }

  // Widget untuk menampilkan gambar atau video
  Widget _buildMedia(
    String mediaItem,
    ValueNotifier<bool> hideUI,
    TransformationController transformationController,
  ) {
    final isVideo = mediaItem.endsWith('.mp4') || mediaItem.endsWith('.mov');

    if (isVideo) {
      return _buildVideoPlayer(mediaItem);
    }

    return InteractiveViewer(
      transformationController: transformationController,
      panEnabled: true,
      scaleEnabled: true,
      minScale: 1.0,
      maxScale: 4.0,
      child: Center(
        child: Image.asset(
          mediaItem,
          fit: BoxFit.contain,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }

  // Utility shorten text
  String shortenWithSeeMore(String text,
      {required int maxLines, required BuildContext context}) {
    final span = TextSpan(
      text: text,
      style: DefaultTextStyle.of(context).style,
    );
    final tp = TextPainter(
      text: span,
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.of(context).size.width);
    if (tp.didExceedMaxLines) {
      return "${text.substring(0, 80)}... Lihat Selengkapnya";
    } else {
      return text;
    }
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
                          return _buildMedia(
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
                                      shortenWithSeeMore(deskripsi,
                                          maxLines: 3, context: context),
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
