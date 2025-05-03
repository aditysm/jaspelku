import 'package:flutter/material.dart';
import 'package:jaspelku/all_material.dart';

// ignore: must_be_immutable
class RandomTopicContainer extends StatefulWidget {
  void Function()? onTap;
  String? label;
  IconData? icon;
  RandomTopicContainer({super.key, this.onTap, this.label, this.icon});

  @override
  State<RandomTopicContainer> createState() => _RandomTopicContainerState();
}

class _RandomTopicContainerState extends State<RandomTopicContainer> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color:
          AllMaterial.isDarkMode.value ? Color(0xffFFC75F) : Color(0xffFEEBC8),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 14,
                color: AllMaterial.isDarkMode.value
                    ? Color(0xff1d1d1d)
                    : Color(0xffDD6B20),
              ),
              SizedBox(width: 2),
              Text(
                "${widget.label}",
                style: TextStyle(
                  color: AllMaterial.isDarkMode.value
                      ? Color(0xff1d1d1d)
                      : Color(0xffDD6B20),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
