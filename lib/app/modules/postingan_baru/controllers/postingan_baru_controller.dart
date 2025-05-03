import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jaspelku/all_material.dart';

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
  final hargaMinC = TextEditingController();
  final waktuMulaiC = TextEditingController();
  final waktuSelesaiC = TextEditingController();
  final hargaMaxC = TextEditingController();

  RxList<XFile> selectedMedia = <XFile>[].obs;
  final ImagePicker _picker = ImagePicker();

  // Fungsi untuk memilih gambar dari galeri
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

  // Fungsi untuk memilih video dari galeri
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

  // Fungsi untuk memilih gambar atau video dari galeri
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

      // Pilih foto atau video berdasarkan pilihan
      if (mediaType == 'photo') {
        await pickImagesFromGallery();
      } else if (mediaType == 'video') {
        await pickVideoFromGallery();
      }
    } catch (e) {
      print("Error selecting media from gallery: $e");
    }
  }

  // Fungsi untuk memilih gambar atau video dari kamera
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

      // Pilih foto atau video berdasarkan pilihan
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

  // Fungsi untuk menghapus media
  void removeMedia(int index) {
    selectedMedia.removeAt(index);
  }

  // Fungsi untuk memeriksa apakah media adalah video
  bool isVideo(XFile file) {
    final extension = file.path.split('.').last.toLowerCase();
    return ['mp4', 'mov', 'avi', 'mkv'].contains(extension);
  }

  final Map<String, List<String>> jenisJasaMap = {
    'Jasa Kebersihan': ['Cuci AC', 'Bersih Rumah', 'Bersih Kantor'],
    'Jasa Teknisi': ['Perbaikan AC', 'Service Elektronik', 'Instalasi Listrik'],
    'Jasa Kreatif': ['Desain Grafis', 'Fotografi', 'Videografi'],
    'Jasa Transportasi': ['Kurir Motor', 'Rental Mobil', 'Pindahan Barang'],
  };

  // Fungsi untuk ambil jenis jasa berdasarkan kategori terpilih
  List<String> getJenisJasaByKategori(String kategori) {
    return jenisJasaMap[kategori] ?? [];
  }

  // Opsional: reset semua pilihan
  void resetFilter() {
    selectedKategori.value = '';
    selectedJenis.value = '';
    selectedLokasi.value = '';
  }
}
