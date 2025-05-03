import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPageController extends GetxController {
  bool isSearching = false;
  final TextEditingController searchController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final FocusNode searchNode = FocusNode();
  final FocusNode messageNode = FocusNode();
  // var unreadCount = 0.obs;
  var currentIndex = 0.obs;
}
