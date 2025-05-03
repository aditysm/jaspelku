import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaspelku/all_material.dart';

// ignore: must_be_immutable
class RandomTagContainer extends StatefulWidget {
  final String label;

  const RandomTagContainer({
    super.key,
    required this.label,
  });

  @override
  State<RandomTagContainer> createState() => _RandomTagContainerState();
}

class _RandomTagContainerState extends State<RandomTagContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = AllMaterial.isDarkMode.value;

      final bgColor =
          isDark ? const Color(0xffFFC75F) : const Color(0xffFEEBC8);
      final textColor =
          isDark ? const Color(0xff1d1d1d) : const Color(0xffDD6B20);

      return Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 17,
        ),
        child: Text(
          widget.label,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    });
  }
}
