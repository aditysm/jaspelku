import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:jaspelku/app/controller/general_controller.dart';
import 'package:jaspelku/app/widget/random_topic_container.dart';
import 'package:svg_flutter/svg.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:video_player/video_player.dart';

abstract class AllMaterial {
  // Role Validation
  static var isServant = false.obs;

  // Dark Mode
  static var isDarkMode = false.obs;

  // Font Weight
  static const fontBlack = FontWeight.w900;
  static const fontExtraBold = FontWeight.w800;
  static const fontBold = FontWeight.w700;
  static const fontSemiBold = FontWeight.w600;
  static const fontMedium = FontWeight.w500;
  static const fontRegular = FontWeight.w400;

  // Color
  static const colorComplementaryBlue = Color(0xff083D77);
  static const colorComplementaryBlueShade = Color(0xffF2F7FB);
  static const colorStrokePrimary = Color(0xffEDF1F3);
  static const colorPrimary = Color(0xffF95738);
  static const colorPrimaryShade = Color(0xffEE964B);
  static const colorSecondary = Color(0xffF4D35E);
  static const colorSecondaryShade = Color(0xffEBEBD3);
  static const colorGreyPrimary = Color(0xff696969);
  static const colorGreySecondary = Color(0xffEFEFEF);
  static const colorBlackPrimary = Color(0xff1F2024);
  static const colorWhite = Color(0xffF8F9FE);

  // Storage
  static var box = GetStorage();

  // Button
  static Widget cusButton({
    String? label,
    void Function()? onTap,
    Widget? icon,
    bool addIcon = true,
    bool isSecondary = false,
    Color? colorSecondary,
    double? width,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: isSecondary ? AllMaterial.colorWhite : AllMaterial.colorPrimary,
      child: InkWell(
        onTap: onTap,
        splashColor: isSecondary
            ? AllMaterial.colorBlackPrimary.withOpacity(0.2)
            : AllMaterial.colorBlackPrimary.withOpacity(0.2),
        highlightColor: isSecondary
            ? AllMaterial.colorBlackPrimary.withOpacity(0.1)
            : AllMaterial.colorPrimary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: isSecondary
                ? Border.all(color: AllMaterial.colorStrokePrimary, width: 2)
                : null,
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (addIcon && icon != null) icon,
              if (addIcon && icon != null) SizedBox(width: 5),
              Text(
                "$label",
                style: TextStyle(
                  color: isSecondary ? colorSecondary : AllMaterial.colorWhite,
                  fontSize: 16,
                  fontWeight: AllMaterial.fontSemiBold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Text Field
  static Widget textField({
    FocusNode? focusNode,
    String? hintText,
    TextEditingController? controller,
    bool isPassword = false,
    bool? obscureText,
    VoidCallback? onToggleObscureText,
    Widget? suffix,
    Widget? prefix,
    bool enabled = false,
    TextInputType? textInputType,
    Color? color,
    String? prefixText,
    String? labelText,
    TextInputAction? textInputAction = TextInputAction.next,
  }) {
    return TextField(
      keyboardType: textInputType,
      controller: controller,
      focusNode: focusNode,
      cursorColor: AllMaterial.colorPrimary,
      textInputAction: textInputAction,
      obscureText: isPassword ? (obscureText ?? true) : false,
      style: TextStyle(color: color),
      onTapOutside: (_) {
        focusNode?.unfocus();
      },
      readOnly: enabled,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: AllMaterial.isDarkMode.isTrue
              ? AllMaterial.colorWhite
              : AllMaterial.colorPrimary,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AllMaterial.colorStrokePrimary,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AllMaterial.colorPrimary,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: hintText,
        prefixText: prefixText,
        prefixStyle: TextStyle(
          color: AllMaterial.isDarkMode.isTrue
              ? AllMaterial.colorWhite
              : AllMaterial.colorPrimary,
        ),
        hintStyle: TextStyle(
          fontWeight: AllMaterial.fontRegular,
        ),
        hoverColor: AllMaterial.colorPrimary,
        focusColor: AllMaterial.colorPrimary,
        border: OutlineInputBorder(
          borderSide: BorderSide(
              // color: AllMaterial.colorStrokePrimary,
              ),
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: prefix,
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  (obscureText ?? true)
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: onToggleObscureText,
              )
            : suffix,
      ),
    );
  }

  static void showLoadingDialog({bool barrierDismissible = false}) {
    Get.dialog(
      Dialog(
        backgroundColor:
            AllMaterial.isDarkMode.isTrue ? Colors.grey[900] : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 40),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: AllMaterial.colorPrimary,
              ),
              const SizedBox(height: 16),
              Text(
                'Memuat...',
                style: Get.context != null
                    ? Theme.of(Get.context!).textTheme.bodyMedium
                    : TextStyle(),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  static void cusDialogValidasi({
    required String title,
    required String subtitle,
    required VoidCallback? onConfirm,
    required VoidCallback? onCancel,
  }) {
    Get.dialog(
      Dialog(
        backgroundColor:
            AllMaterial.isDarkMode.isTrue ? null : AllMaterial.colorWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: AllMaterial.fontBold,
                ),
              ),
              const SizedBox(height: 12),

              /// Subtitle
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 15,
                  color: AllMaterial.isDarkMode.isTrue
                      ? Colors.grey[300]
                      : Colors.grey[800],
                ),
              ),
              const SizedBox(height: 24),

              /// Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: onCancel,
                    child: const Text(
                      'BATAL',
                      style: TextStyle(
                        color: AllMaterial.colorPrimary,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: onConfirm,
                    child: Text(
                      'KONFIRMASI',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AllMaterial.colorPrimary,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget avatarWidget({
    required String name,
    String? imageUrl,
    double radius = 20,
    bool showEdit = false,
    VoidCallback? onEditTap,
    bool isOnline = true,
    bool isProfile = false,
  }) {
    final double innerPadding = radius * 0.1;
    final bool isProfilOrProductList = radius != 20;
    final bool isProfile = radius == 50;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: radius,
          backgroundColor: AllMaterial.colorPrimary,
          backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
          child: imageUrl == null
              ? Text(
                  name.isNotEmpty ? name[0] : '',
                  style: TextStyle(
                    color: AllMaterial.colorWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: radius * 0.8,
                  ),
                )
              : null,
        ),
        if (isOnline && !showEdit)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: isProfile
                  ? 25
                  : isProfilOrProductList
                      ? 15
                      : 12,
              height: isProfile
                  ? 25
                  : isProfilOrProductList
                      ? 15
                      : 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
                border: Border.all(
                  color: Colors.white,
                  width: isProfilOrProductList ? 3 : 2,
                ),
              ),
            ),
          ),
        if (showEdit)
          Positioned(
            right: -10 * 2,
            top: 0,
            bottom: 0,
            child: Center(
                child: Material(
              color: AllMaterial.colorPrimary,
              shape: const CircleBorder(),
              child: InkWell(
                onTap: onEditTap,
                customBorder: const CircleBorder(),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 5.5,
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(innerPadding),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )),
          ),
      ],
    );
  }

  static Widget namaDenganVerified({
    required String name,
    required bool isVerified,
    TextStyle? style,
    double iconSize = 18,
    bool isProfil = false,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            AllMaterial.formatNamaPanjang(name),
            overflow: TextOverflow.ellipsis,
            style: style ??
                TextStyle(
                  fontSize: isProfil ? 20 : 15,
                  fontWeight: AllMaterial.fontBold,
                ),
          ),
        ),
        if (isVerified) ...[
          const SizedBox(width: 6),
          Icon(
            Icons.verified,
            size: iconSize,
            color: Colors.green,
          ),
        ],
      ],
    );
  }

  static Widget spesialistCard({
    String? name,
    bool? isVerified,
    String? role,
    double? rating,
    List<String?>? mediaAsset,
    VoidCallback? onTawarTap,
    VoidCallback? onTap,
    BuildContext? context,
    bool isGallery = false,
  }) {
    final isDark = isDarkMode.value;

    return Row(
      children: [
        isGallery
            ? SizedBox.shrink()
            : Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: onTap,
                  child: Column(
                    children: [
                      AllMaterial.avatarWidget(
                        name: name![0],
                        isOnline: true,
                        radius: 25,
                      ),
                      const SizedBox(height: 5),
                      AllMaterial.namaDenganVerified(
                        name: name,
                        isVerified: isVerified!,
                      ),
                      Text(
                        role!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          Icon(Icons.star,
                              color: AllMaterial.colorPrimaryShade),
                          const SizedBox(width: 3),
                          Text(
                            rating!.toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: 16,
                              color: isDark
                                  ? AllMaterial.colorWhite
                                  : AllMaterial.colorComplementaryBlue,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 7),
                      AllMaterial.cusButton(
                        onTap: onTawarTap,
                        label: "Tawar",
                      ),
                    ],
                  ),
                ),
              ),
        ...List.generate(mediaAsset!.length, (index) {
          return GestureDetector(
            onTap: () {
              showFullScreenMedia(
                context: context!,
                media: mediaAsset,
                initialIndex: index,
                nama: name!,
                mediaBuilder: (mediaItem, hideUI, transformationController) {
                  final mediaItem = mediaAsset[index];
                  return AllMaterial.buildMedia(
                    mediaItem ?? "",
                    hideUI,
                    transformationController,
                  );
                },
              );
            },
            child: Container(
              margin: EdgeInsets.only(
                  left: index == 0
                      ? 5
                      : isGallery
                          ? 5
                          : 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(mediaAsset[index] ?? ""),
                ),
              ),
              width: isGallery ? 120 : 90,
              height: 165,
            ),
          );
        }),
      ],
    );
  }

  static Widget buildVideoPlayer(String videoPath) {
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

  static Widget buildMedia(
    String mediaItem,
    ValueNotifier<bool> hideUI,
    TransformationController transformationController,
  ) {
    final isVideo = mediaItem.endsWith('.mp4') || mediaItem.endsWith('.mov');

    if (isVideo) {
      return buildVideoPlayer(mediaItem);
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

  static void showFullScreenMedia({
    required BuildContext context,
    required List<dynamic> media,
    required int initialIndex,
    String? deskripsi,
    required String nama,
    required Widget Function(dynamic mediaItem, ValueNotifier<bool> hideUI,
            TransformationController transformationController)
        mediaBuilder,
  }) {
    final pageController = PageController(initialPage: initialIndex);
    int currentPage = initialIndex;
    final showFullDescription = false.obs;
    final hideUI = ValueNotifier(false);
    final transformationController = TransformationController();
    final descScrollController = ScrollController();

    transformationController.addListener(() {
      final scale = transformationController.value.getMaxScaleOnAxis();
      final shouldHide = scale > 1.0;

      if (hideUI.value != shouldHide) {
        hideUI.value = shouldHide;
        SystemChrome.setEnabledSystemUIMode(
          shouldHide ? SystemUiMode.immersive : SystemUiMode.edgeToEdge,
        );
      }

      if (shouldHide && showFullDescription.value) {
        showFullDescription.value = false;
      }
    });

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
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
              onVerticalDragEnd: (_) {
                if (dragOffset > 120) {
                  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
                  Get.back();
                }
                dragOffset = 0;
              },
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(kToolbarHeight + 25),
                  child: ValueListenableBuilder<bool>(
                    valueListenable: hideUI,
                    builder: (context, hidden, child) {
                      if (hidden) return const SizedBox.shrink();
                      return Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: AppBar(
                          surfaceTintColor: Colors.black,
                          title: Text(
                            AllMaterial.formatNamaPanjang(nama),
                            style: TextStyle(color: AllMaterial.colorWhite),
                          ),
                          leading: IconButton(
                            splashColor: AllMaterial.colorWhite,
                            highlightColor: Colors.white70.withOpacity(0.5),
                            onPressed: () {
                              SystemChrome.setEnabledSystemUIMode(
                                  SystemUiMode.edgeToEdge);
                              Get.back();
                            },
                            icon: Icon(Icons.arrow_back,
                                color: AllMaterial.colorWhite),
                          ),
                          backgroundColor: Colors.transparent,
                        ),
                      );
                    },
                  ),
                ),
                backgroundColor: Colors.black,
                body: Stack(
                  children: [
                    PageView.builder(
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
                        });
                      },
                      itemBuilder: (context, index) {
                        final mediaItem = media[index];
                        return AllMaterial.buildMedia(
                          mediaItem,
                          hideUI,
                          transformationController,
                        );
                      },
                    ),

                    // Page Indicator
                    ValueListenableBuilder<bool>(
                      valueListenable: hideUI,
                      builder: (context, hidden, child) {
                        if (hidden || media.length <= 1) {
                          return const SizedBox.shrink();
                        }
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
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                          ),
                        );
                      },
                    ),

                    deskripsi == "" || deskripsi == null
                        ? SizedBox.shrink()
                        :
                        // Description
                        ValueListenableBuilder<bool>(
                            valueListenable: hideUI,
                            builder: (context, hidden, child) {
                              if (hidden) return const SizedBox.shrink();
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
                                                horizontal: 15, vertical: 15)
                                            .copyWith(
                                                bottom: context
                                                        .mediaQueryPadding
                                                        .bottom +
                                                    20),
                                        child: Text(
                                          GeneralController.shortenWithSeeMore(
                                              deskripsi,
                                              maxLines: 3,
                                              context: context),
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
                                                  horizontal: 15, vertical: 15)
                                              .copyWith(
                                                  bottom: context
                                                      .mediaQueryPadding
                                                      .bottom),
                                          child: GestureDetector(
                                            onTap: () =>
                                                showFullDescription.toggle(),
                                            child: Text(
                                              deskripsi,
                                              style: TextStyle(
                                                  color:
                                                      AllMaterial.colorWhite),
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
            );
          },
        );
      },
    );
  }

  static Widget menuLayanan({
    required String title,
    required String svg,
    required VoidCallback? onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(3),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: SvgPicture.asset(
                "assets/icon/$svg.svg",
                height: 34,
              ),
            ),
            Text(title),
          ],
        ),
      ),
    );
  }

  static String getErrorMessage(int statusCode) {
    switch (statusCode) {
      case 400:
        return "Permintaan tidak dapat diproses. Pastikan data yang kamu isi sudah benar.";
      case 401:
        return "Kamu belum login. Silakan masuk terlebih dahulu.";
      case 403:
        return "Akses ditolak. Kamu tidak punya izin untuk fitur ini.";
      case 404:
        return "Layanan atau data yang kamu cari tidak ditemukan.";
      case 408:
        return "Permintaan terlalu lama. Coba lagi dalam beberapa saat.";
      case 500:
        return "Terjadi kesalahan di sistem kami. Tim kami sedang menanganinya.";
      case 502:
        return "Layanan sedang sibuk. Coba lagi nanti, ya.";
      case 503:
        return "Server sedang tidak tersedia. Silakan coba beberapa saat lagi.";
      case 504:
        return "Waktu tunggu habis. Koneksi ke server gagal.";
      default:
        return "Oops! Terjadi kesalahan yang tidak terduga.";
    }
  }

  static String formatTime24(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  static void bottomSheetMore(int? itemCount, List<String?> label,
      List<void Function()?> onTap, List<Widget> icon) {
    Get.bottomSheet(
      Material(
        color: AllMaterial.isDarkMode.isTrue ? null : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(itemCount ?? 0, (index) {
              return ListTile(
                leading: icon[index],
                title: Text(label[index] ?? ""),
                onTap: onTap[index],
              );
            }),
          ),
        ),
      ),
    );
  }

  static void messageScaffold({
    required String title,
    bool adaKendala = false,
    void Function()? kendalaTap,
    String? kendalaTitle,
  }) {
    if (Get.context != null) {
      final estimatedSeconds = (title.length / 12).ceil();
      final duration = Duration(
        seconds: estimatedSeconds.clamp(2, 10),
      );

      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          duration: duration,
          content: Text(title),
          action: adaKendala
              ? SnackBarAction(
                  textColor: AllMaterial.colorPrimary,
                  label: kendalaTitle ?? "Lihat",
                  onPressed: kendalaTap ?? () {},
                )
              : null,
        ),
      );
    }
  }

  static String formatEmail(String email) {
    if (!email.contains('@')) return email;

    final parts = email.split('@');
    final username = parts[0];
    final domain = parts[1];

    if (username.length > 10) {
      int half = username.length ~/ 2;
      String awal = username.substring(0, half ~/ 2);
      String akhir = username.substring(username.length - half ~/ 2);
      return '$awal...$akhir@$domain';
    }

    return email;
  }

  static String formatNamaPanjang(String namaPanjang) {
    List<String> namaArray = namaPanjang.split(' ');
    List<String> duaNamaPertama = namaArray.take(3).toList();
    return duaNamaPertama.join(' ');
  }

  // Format : 29/04/2025
  static String tahunBulanTanggal(String dateIsoString) {
    DateTime parsed = DateTime.parse(dateIsoString);
    return DateFormat('dd/MM/yyyy').format(parsed);
  }

  // Format : 25000 => 25.000
  static String formatHarga(dynamic harga) {
    try {
      final number = harga is String ? int.tryParse(harga) ?? 0 : harga ?? 0;
      return NumberFormat('#,###', 'id_ID').format(number);
    } catch (e) {
      return '0';
    }
  }

  static Widget buildRating(
    BuildContext context,
    Map<String, Object> data,
  ) {
    final deskripsi = data['deskripsi']?.toString() ?? '';
    final jamKerja = data["jam_kerja"]?.toString() ?? '';
    final List<dynamic> media = (data['media'] ?? []) as List<dynamic>;
    final List<dynamic> tags = (data['tags'] ?? []) as List<dynamic>;
    final List<dynamic> hariKerja = (data['hari_kerja'] ?? []) as List<dynamic>;

    final hideUI = ValueNotifier(false);
    final transformationController = TransformationController();

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
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
                    index < (int.tryParse(data['rating'].toString()) ?? 0)
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

          // Tags & Judul
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

          // Deskripsi, Jam Kerja, Hari Kerja
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Deskripsi : ",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  Expanded(child: Text(deskripsi)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Jam Kerja : ",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  Expanded(
                      child:
                          Text(jamKerja, style: const TextStyle(fontSize: 14))),
                ],
              ),
              const SizedBox(height: 8),
              if (hariKerja.isNotEmpty)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Hari Kerja : ",
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    Expanded(
                      child: Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: hariKerja
                            .map<Widget>((hari) => Text("$hari, "))
                            .toList(),
                      ),
                    ),
                  ],
                ),
            ],
          ),

          const SizedBox(height: 12),

          // Media
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
                      AllMaterial.buildMedia(
                          mediaItem, hideUI, transformationController);
                      AllMaterial.showFullScreenMedia(
                        context: context,
                        media: media,
                        initialIndex: index,
                        nama: data["nama"].toString(),
                        mediaBuilder:
                            (mediaItem, hideUI, transformationController) {
                          return AllMaterial.buildMedia(
                              mediaItem, hideUI, transformationController);
                        },
                      );
                    },
                    child: isVideo
                        ? AllMaterial.buildVideoPlayer(mediaItem)
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

  // Format : 08:05
  static String jamMenit(String dateIsoString) {
    DateTime parsed = DateTime.parse(dateIsoString);
    return DateFormat('HH:mm').format(parsed);
  }

  static Map<String, List<String>> jenisJasaMap = {
    'Jasa Kebersihan': [
      'Bersih Rumah',
      'Bersih Kost/Apartment',
      'Bersih Kantor',
      'Cuci AC',
      'Cuci Sofa',
      'Cuci Kasur',
      'Cuci Karpet',
      'Pembersihan Toilet',
      'Pembersihan Pasca Renovasi',
      'Pembersihan Kaca Gedung',
      'Pembersihan Kolam Renang',
      'Disinfeksi & Fogging',
      'Laundry Kiloan',
      'Laundry Sepatu',
      'Laundry Dry Cleaning',
      'Pembersihan Setelah Pesta',
      'Jasa Pembersihan Kotoran Hewan',
      'Cuci Mobil',
      'Pembersihan Rumah Pasca Kebakaran',
      'Jasa Pembersihan Limbah Rumah Tangga',
      'Pembersihan Pasca Banjir',
      'Jasa Pembersihan Spesial untuk Hotel',
    ],
    'Jasa Teknisi': [
      'Perbaikan AC',
      'Service Elektronik',
      'Instalasi Listrik',
      'Perbaikan Pompa Air',
      'Instalasi CCTV',
      'Service Mesin Cuci',
      'Service Kulkas',
      'Service TV',
      'Service Komputer / Laptop',
      'Pasang Antena / Parabola',
      'Instalasi Jaringan LAN/WiFi',
      'Service Printer',
      'Service Smartphone',
      'Service Drone',
      'Service Peralatan Elektronik Vintage',
      'Instalasi Pipa Gas',
      'Service Audio Mobil',
      'Service Mesin Fotocopy',
      'Service Alat Medis',
    ],
    'Jasa Transportasi & Logistik': [
      'Kurir Motor',
      'Rental Mobil',
      'Sewa Truk / Pickup',
      'Pindahan Rumah/Kantor',
      'Pengiriman Barang Besar',
      'Driver Harian',
      'Jemput Anak Sekolah',
      'Jasa Angkut Barang Bekas',
      'Transportasi Wisata',
      'Sewa Motor',
      'Jasa Titip (Jastip)',
      'Jasa Pengiriman Makanan',
      'Jasa Pengiriman Hewan',
      'Jasa Penyewaan Bus Pariwisata',
      'Jasa Sewa Van untuk Rombongan',
      'Jasa Pindahan Perusahaan',
      'Jasa Relokasi Perabotan',
      'Pengiriman dari Luar Negeri',
      'Jasa Penyimpanan Barang Sementara',
    ],
    'Jasa Kreatif & Desain': [
      'Desain Grafis',
      'Desain Logo',
      'UI/UX Design',
      'Fotografi Produk',
      'Fotografi Prewedding',
      'Videografi Event',
      'Editor Video',
      'Animator 2D/3D',
      'Ilustrator',
      'Content Creator',
      'Voice Over',
      'Penulis Konten',
      'Desain Interior',
      'Desain Arsitektur',
      'Desain Kemasan Produk',
      'Desain Toko Online',
      'Desain Brosur Digital Interaktif',
      'Desain Spanduk & Banner',
      'Desain Iklan Digital',
      'Penyusunan Infografis',
      'Desain Website dan E-Commerce',
    ],
    'Jasa Kecantikan & Kesehatan': [
      'Makeup Artist (MUA)',
      'Potong Rambut Panggilan',
      'Perawatan Wajah',
      'Nail Art',
      'Facial & Masker',
      'Spa & Massage Panggilan',
      'Terapis Bekam / Akupuntur',
      'Pijat Bayi',
      'Tukang Cukur Tradisional',
      'Perawat Lansia / Homecare',
      'Fisioterapi',
      'Konsultasi Dokter Online',
      'Konsultasi Gizi',
      'Yoga Instructor',
      'Personal Trainer',
      'Konsultasi Kesehatan dan Kecantikan Holistik',
      'Perawatan Rambut & Styling',
      'Tatu & Body Art',
      'Konsultasi Kesehatan Mental',
      'Jasa Pengobatan Herbal Tradisional',
      'Body Scrub & Perawatan Kulit',
      'Terapis Pijat Refleksi',
      'Jasa Kesehatan Gigi',
    ],
    'Jasa Pendidikan & Kursus': [
      'Les Privat SD-SMA',
      'Guru Bahasa Inggris',
      'Kursus Bahasa Korea / Jepang',
      'Kursus Musik (Gitar, Piano)',
      'Les Mengemudi',
      'Bimbel CPNS/UTBK',
      'Kursus Coding',
      'Les Public Speaking',
      'Guru Mengaji',
      'Les Calistung Anak',
      'Kursus Desain',
      'Kursus Editing Video',
      'Kursus Masak / Baking',
      'Pelatihan Digital Marketing',
      'Workshop Fotografi',
      'Kursus Menjahit',
      'Kursus Makeup',
      'Kursus Menulis Kreatif',
      'Pelatihan Manajemen Waktu',
      'Pelatihan Komunikasi Antarbudaya',
      'Pelatihan Keterampilan Kehidupan',
      'Kursus Bahasa Asing',
      'Pelatihan Leadership & Manajemen Tim',
    ],
    'Jasa Konstruksi & Renovasi': [
      'Tukang Bangunan Harian',
      'Renovasi Rumah',
      'Pengecatan Rumah',
      'Pasang Keramik / Granit',
      'Pasang Plafon Gypsum',
      'Pasang Kanopi',
      'Tukang Taman',
      'Pasang Wallpaper Dinding',
      'Perbaikan Pagar & Kunci',
      'Tukang Kayu / Lemari / Meja',
      'Pasang Atap',
      'Pasang Jendela / Kaca',
      'Pasang Pintu Otomatis',
      'Instalasi Pipa Air',
      'Perancang Taman Vertikal',
      'Pembuatan Furnitur Daur Ulang',
      'Renovasi Kantor',
      'Tukang Las & Fabrication',
      'Tukang Batu Alam',
      'Jasa Penataan Ruang Publik',
    ],
    'Jasa Event & Acara': [
      'MC / Pembawa Acara',
      'Dekorasi Acara',
      'Catering Prasmanan',
      'Sound System & Lighting',
      'Penyanyi / Band',
      'Talent Pernikahan',
      'Sewa Tenda & Kursi',
      'Wedding Organizer (WO)',
      'Event Organizer (EO)',
      'Makeup Wisuda / Lamaran',
      'Balon & Kue Ulang Tahun',
      'Penyewaan Gedung',
      'Undangan Digital',
      'Jasa Dokumentasi',
      'Sewa Jasa SPG',
      'Pemandu Tur',
      'Pemandu Wisata Virtual',
      'Dekorasi Ulang Tahun Anak',
      'Sewa Photo Booth',
      'Jasa Pengorganisasian Acara Korporat',
      'Sewa Alat Pesta',
    ],
    'Jasa Digital & IT': [
      'Pembuatan Website',
      'Pembuatan Aplikasi Mobile',
      'Maintenance Website',
      'SEO & SEM',
      'Digital Marketing',
      'Social Media Management',
      'Content Writer',
      'Data Entry',
      'Instalasi Software',
      'Konsultan IT',
      'Instalasi Server',
      'Cybersecurity Audit',
      'Data Analyst Freelance',
      'Pembuatan Chatbot',
      'Pembuatan Web E-learning',
      'Pengembangan Personal Branding',
      'Penyusunan Rencana Bisnis',
      'Pembuatan Tiket Undangan Khusus',
      'Pemulihan Pencurian Identitas',
      'Manajemen Medsos',
      'Jasa Riset Pemasaran',
      'Jasa Order Barang Luar Negeri',
      'Jasa Jual Beli Followers Instagram',
      'Jasa Jual Beli Halaman Facebook',
      'Pengelolaan Sistem ERP',
      'Konsultan Big Data & AI',
      'Pembuatan Sistem CRM',
    ],
    'Jasa Hukum & Keuangan': [
      'Konsultasi Hukum',
      'Pengacara / Advokat',
      'Notaris',
      'Konsultan Pajak',
      'Jasa Pembuatan PT / CV',
      'Audit Keuangan UMKM',
      'Konsultan Bisnis',
      'Asisten Legal Freelance',
      'Penerjemah Tersumpah',
      'Mediator Hukum',
      'Jasa Penagihan Piutang',
      'Konsultan Investasi',
      'Perencana Keuangan',
      'Konsultan Asuransi',
      'Perancang Kontrak Bisnis',
      'Konsultasi Warisan',
      'Konsultasi Pencatatan Keuangan',
      'Jasa Pembukuan Perusahaan',
      'Jasa Pembayaran Pajak Online',
    ],
    'Jasa Pertanian & Peternakan': [
      'Konsultasi Pertanian',
      'Jasa Semprot Hama',
      'Penyuluhan Organik',
      'Konsultasi Peternakan',
      'Dokter Hewan Ternak',
      'Pembersihan Kandang',
      'Service Alat Pertanian',
      'Sewa Traktor / Alat Berat',
      'Pembuatan Pakan Ternak',
      'Konsultan Hidroponik',
      'Penyuluhan Pertanian Berkelanjutan',
      'Penyuluhan Teknologi Pertanian',
      'Konsultan Pemasaran Hasil Pertanian',
      'Penyuluhan Peternakan Organik',
    ],
    'Jasa Fashion & Gaya Hidup': [
      'Jahit Baju Panggilan',
      'Stylist / Fashion Konsultan',
      'Laundry Panggilan',
      'Sewa Jas / Kebaya',
      'Service Sepatu / Tas',
      'Cuci Sepatu Premium',
      'Reparasi Jam Tangan',
      'Perancang Busana',
      'Personal Shopper',
      'Konsultan Gaya Hidup',
      'Rental Kostum Galaksi',
      'Desain Pakaian Custom',
      'Grooming Hewan Peliharaan',
      'Desain Perhiasan',
      'Sewa Fashion Show untuk Event',
    ],
    'Jasa Sosial': [
      'Relawan Pendidikan',
      'Bantuan Kemanusiaan',
      'Penggalangan Dana',
      'Pengasuh Anak Yatim',
      'Penyuluhan Masyarakat',
      'Pelatihan Pemberdayaan Masyarakat',
      'Konsultan Sosial & Pemberdayaan',
      'Pengorganisasian Kegiatan Sosial',
      'Kampanye Sosial',
      'Bimbingan Psikologis',
      'Program Bantuan Sosial (Bansos)',
      'Pemberdayaan Anak & Remaja',
      'Pengelolaan Kampanye Lingkungan',
      'Bimbingan Hukum untuk Kelompok Marginal',
      'Aksi Relawan Bencana Alam',
      'Pengelolaan Pengungsi',
      'Jasa Sumbangan Barang Bekas',
      'Kegiatan Volunteer Global',
      'Kampanye Peningkatan Kesadaran Sosial',
      'Organisasi Kemasyarakatan',
      'Penyuluhan tentang Kesehatan Mental',
      'Pelatihan Keterampilan Sosial',
    ],
    'Jasa Kesehatan': [
      'Konsultasi Dokter Umum',
      'Konsultasi Spesialis',
      'Perawatan Lansia',
      'Perawatan Rumah Sakit / Klinik',
      'Perawatan Pasien Paliatif',
      'Terapis Fisioterapi',
      'Terapis Psikologi',
      'Terapis Akupunktur',
      'Jasa Pemeriksaan Kesehatan',
      'Konsultasi Gizi',
      'Layanan Laboratorium Medis',
      'Perawatan Gigi dan Mulut',
      'Jasa Penyuluhan Kesehatan',
      'Pemeriksaan Mata',
      'Perawatan Kulit Medis',
      'Jasa Konseling Kesehatan Mental',
      'Jasa Pengobatan Herbal',
      'Perawatan Kesehatan Anak',
      'Vaksinasi Rumah',
      'Pemeriksaan Laboratorium Mandiri',
      'Jasa Layanan Kesehatan Homecare',
      'Pemeriksaan Kesehatan Rutin',
      'Konsultasi Kesehatan Online',
    ],
    'Lainnya': [
      'Jasa Screenshot dan Merekam Memakai iPhone',
      'Joki Foto di Gunung',
      'Joki Strava',
      'Joki Tugas',
      'Jasa Asah Pisau',
      'Translator Via Telepon',
      'Cuci Kendaraan Keliling',
      'Joki Menjual Barang',
      'Fotografer Drone',
      'Layanan Relaksasi',
      'Layanan Jasa Menghadapi Banjir',
      'Jasa Pemandu Wisata',
      'Jasa Consultant Percintaan',
      'Jasa Pet Walker Kucing',
      'Jasa Pelukis',
      'Jasa Sablon Barang Promosi',
      'Layanan Virtual Assistant',
      'Layanan Pelatihan Public Speaking',
      'Layanan Pengemasan Kreatif',
      'Jasa Pemulihan Data Digital',
      'Jasa Pembuatan Kue Kustom',
      'Layanan Konsultasi Kesehatan dan Kecantikan Holistik',
      'Jasa Perancangan Kursus Online',
      'Layanan Pembuatan Tiket Undangan Khusus',
      'Penyuluhan Lingkungan',
      'Jasa Penyusunan Proposal',
    ],
  };
}
