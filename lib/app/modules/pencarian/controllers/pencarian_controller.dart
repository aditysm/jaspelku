import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PencarianController extends GetxController {
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
    super.onInit();
  }

  void toggleSearch() {
    isSearching.value = !isSearching.value;
    searchNode.requestFocus();
  }

  void updateSearchText(String text) {
    searchText.text = text;
  }

  void submitSearch() {
    if (searchText.text.isNotEmpty) {
      print("Pencarian untuk: ${searchText.value}");
    }
  }
}
