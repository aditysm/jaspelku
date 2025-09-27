import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jaspelku/app/utils/all_material.dart';
import 'package:jaspelku/app/utils/toast_dialog.dart';

class PostinganBaruController extends GetxController {
  RxString selectedOpsi = 'Sekali / Sehari'.obs;
  RxList<String> selectedHari = <String>[].obs;

  final List<String> allHari = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu',
  ];

  final selectedKategori = ''.obs;
  final selectedJenis = ''.obs;
  final selectedLokasi = ''.obs;
  final kebutuhanC = TextEditingController();
  final kebutuhanF = FocusNode();
  final totalHargaC = TextEditingController();
  final waktuMulaiC = TextEditingController();
  final waktuSelesaiC = TextEditingController();
  var totalHargaError = "".obs;
  var waktuMulaiError = "".obs;
  var waktuSelesaiError = "".obs;
  var hariKerjaError = "".obs;

  RxList<XFile> selectedMedia = <XFile>[].obs;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImagesFromGallery() async {
    try {
      final List<XFile> pickedImages =
          await _picker.pickMultiImage(imageQuality: 70);
      if (pickedImages.isNotEmpty) {
        selectedMedia.addAll(pickedImages);
      }
    } catch (e) {
      print("Error picking images: $e");
    }
  }

  Future<void> pickVideoFromGallery() async {
    try {
      final XFile? pickedVideo =
          await _picker.pickVideo(source: ImageSource.gallery);
      if (pickedVideo != null) {
        selectedMedia.add(pickedVideo);
      }
    } catch (e) {
      print("Error picking video: $e");
    }
  }

  Future<void> pickMediaFromGallery() async {
    try {
      final mediaType = await showDialog<String>(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            backgroundColor:
                AllMaterial.isDarkMode.isFalse ? AllMaterial.colorWhite : null,
            title: Text('Pilih Media'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop('photo'),
                child: Text(
                  'Foto',
                  style: TextStyle(color: AllMaterial.colorPrimary),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop('video'),
                child: Text(
                  'Video',
                  style: TextStyle(color: AllMaterial.colorPrimary),
                ),
              ),
            ],
          );
        },
      );

      if (mediaType == 'photo') {
        await pickImagesFromGallery();
      } else if (mediaType == 'video') {
        await pickVideoFromGallery();
      }
    } catch (e) {
      print("Error selecting media from gallery: $e");
    }
  }

  Future<void> pickMediaFromCamera() async {
    try {
      final mediaType = await showDialog<String>(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            backgroundColor:
                AllMaterial.isDarkMode.isFalse ? AllMaterial.colorWhite : null,
            title: Text('Pilih Media'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop('photo'),
                child: Text(
                  'Foto',
                  style: TextStyle(color: AllMaterial.colorPrimary),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop('video'),
                child: Text(
                  'Video',
                  style: TextStyle(color: AllMaterial.colorPrimary),
                ),
              ),
            ],
          );
        },
      );

      if (mediaType == 'photo') {
        final XFile? image = await _picker.pickImage(
            source: ImageSource.camera, imageQuality: 70);
        if (image != null) {
          selectedMedia.add(image);
        }
      } else if (mediaType == 'video') {
        final XFile? video =
            await _picker.pickVideo(source: ImageSource.camera);
        if (video != null) {
          selectedMedia.add(video);
        }
      }
    } catch (e) {
      print("Error selecting media from camera: $e");
    }
  }

  void removeMedia(int index) {
    selectedMedia.removeAt(index);
  }

  bool isVideo(XFile file) {
    final extension = file.path.split('.').last.toLowerCase();
    return ['mp4', 'mov', 'avi', 'mkv'].contains(extension);
  }

  List<String> getJenisJasaByKategori(String kategori) {
    return AllMaterial.jenisJasaMap[kategori] ?? [];
  }

  void resetFilter() {
    selectedKategori.value = '';
    selectedJenis.value = '';
    selectedLokasi.value = '';
  }

  @override
  void onInit() {
    totalHargaC.addListener(() {
      if (totalHargaC.text.isNotEmpty) totalHargaError.value = '';
    });
    waktuMulaiC.addListener(() {
      if (waktuMulaiC.text.isNotEmpty) waktuMulaiError.value = '';
    });
    waktuSelesaiC.addListener(() {
      if (waktuSelesaiC.text.isNotEmpty) waktuSelesaiError.value = '';
    });
    super.onInit();
  }

  Future<void> validateForm() async {
    bool isValid = true;

    if (totalHargaC.text.trim().isEmpty) {
      totalHargaError.value = 'Harga wajib diisi';
      isValid = false;
    }

    if (waktuMulaiC.text.trim().isEmpty) {
      waktuMulaiError.value = 'Waktu mulai wajib diisi';
      isValid = false;
    }

    if (waktuSelesaiC.text.trim().isEmpty) {
      waktuSelesaiError.value = 'Waktu selesai wajib diisi';
      isValid = false;
    }

    if (selectedOpsi == "Kustom") {
      if (selectedHari.isNotEmpty) {
      } else {
        hariKerjaError.value = "Hari Kerja wajib dipilih";
        isValid = false;
      }
    } else {}

    if (!isValid) return;

    if (totalHargaError.isNotEmpty ||
        waktuMulaiError.isNotEmpty ||
        waktuSelesaiError.isNotEmpty) return;

    AllMaterial.cusDialogValidasi(
      title: "Ajukan Tawaran",
      subtitle: "Apakah Anda yakin?",
      onConfirm: () async {
        Get.back();
        AllMaterial.showLoadingDialog();
        await Future.delayed(const Duration(milliseconds: 400));
        Get.back();
        ToastService.show(
          "Mengajukan tawaran",
        );
      },
      onCancel: () => Get.back(),
    );
  }

  @override
  void onClose() {
    kebutuhanC.dispose();
    totalHargaC.dispose();
    waktuMulaiC.dispose();
    waktuSelesaiC.dispose();
    super.onClose();
  }
}
