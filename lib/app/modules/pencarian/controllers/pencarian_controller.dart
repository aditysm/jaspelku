import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaspelku/all_material.dart';

class PencarianController extends GetxController {
  var selectedRating = "".obs;
  var selectedLocation = "".obs;
  var selectedService = "AC".obs;
  var isOnline = false.obs;
  var isVerified = false.obs;
  var jenisJasa = "".obs;
  var selectedKategori = "".obs;
  var isReset = false.obs;
  List<Map<String, dynamic>> data = [
    {
      "name": "Joko",
      "bio": "Ahli servis AC & Elektronik",
      "rating": 4.7,
      "location": "Jakarta Selatan",
      "isOnline": true,
      "isVerified": true,
      "jenis_jasa": ["AC", "Elektronik"],
      "kategori": "Service"
    },
    {
      "name": "Budi",
      "bio": "Tukang taman dan perawatan",
      "rating": 4.5,
      "location": "Depok",
      "isOnline": false,
      "isVerified": false,
      "jenis_jasa": ["Taman"],
      "kategori": "Pertamanan"
    },
  ];
  var filteredData = <Map<String, dynamic>>[].obs;

  var isSearching = true.obs;
  final searchText = TextEditingController();
  final searchNode = FocusNode();

  @override
  void onInit() {
    var searchKeyword = Get.arguments ?? "";
    searchText.text = searchKeyword ?? "";
    if (searchKeyword == null || searchKeyword == "") {
      isSearching.value = false;
      update();
    }
    resetFilters();
    super.onInit();
  }

  @override
  void onClose() {
    resetFilters();
    super.onClose();
  }

  void resetFilters() {
    print("jaajjdwa");
    selectedRating.value = '';
    selectedLocation.value = '';
    selectedService.value = '';
    isOnline.value = false;
    isVerified.value = false;
    selectedKategori.value = "";
    jenisJasa.value = "";
    isReset.value = true;
    filteredData.assignAll(data);
    update();
  }

  void toggleSearch() {
    isSearching.value = !isSearching.value;
    searchNode.requestFocus();
  }

  void updateSearchText(String text) {
    searchText.text = text;
  }

  List<String> getJenisJasaByKategori(String? kategori) {
    return AllMaterial.jenisJasaMap[kategori] ?? [];
  }

  void submitSearch() {
    final query = searchText.text.toLowerCase();
    final jenis = jenisJasa.value;
    final kategori = selectedKategori.value;

    final results = data.where((item) {
      final name = (item['name'] ?? '').toString().toLowerCase();
      final jenisJasa = (item['jenis_jasa'] ?? []) as List;
      final kategoriItem = (item['kategori'] ?? '').toString().toLowerCase();

      final matchQuery = query.isEmpty || name.contains(query);
      final matchJenis = jenis == 'Semua' ||
          jenisJasa
              .map((j) => j.toString().toLowerCase())
              .contains(jenis.toLowerCase());
      final matchKategori =
          kategori == 'Semua' || kategoriItem == kategori.toLowerCase();

      return matchQuery && matchJenis && matchKategori;
    }).toList();

    filteredData.assignAll(results);
  }

  List<Map<String, dynamic>> applyFilters(List<Map<String, dynamic>> data) {
    List<Map<String, dynamic>> filteredData = data;

    if (selectedRating.value.isNotEmpty) {
      filteredData = filteredData.where((item) {
        final rating = item['rating'];
        if (rating is num) {
          if (selectedRating.value == "high") {
            return rating >= 4.0;
          } else {
            return rating < 4.0;
          }
        }
        return false;
      }).toList();
    }

    if (selectedLocation.value.isNotEmpty) {
      filteredData = filteredData.where((item) {
        return item['location'] == selectedLocation.value;
      }).toList();
    }

    if (selectedService.value.isNotEmpty) {
      filteredData = filteredData.where((item) {
        return item['service'] == selectedService.value;
      }).toList();
    }

    if (isOnline.value) {
      filteredData = filteredData.where((item) {
        return item['isOnline'] == true;
      }).toList();
    }

    if (isVerified.value) {
      filteredData = filteredData.where((item) {
        return item['isVerified'] == true;
      }).toList();
    }

    if (selectedKategori.value.isNotEmpty) {
      filteredData = filteredData.where((item) {
        return item['kategori'] == selectedKategori.value;
      }).toList();
    }

    if (jenisJasa.value.isNotEmpty) {
      filteredData = filteredData.where((item) {
        return item['jenisJasa'] == jenisJasa.value;
      }).toList();
    }

    return filteredData;
  }
}
