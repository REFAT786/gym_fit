import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/styles.dart';
import 'custom_back_button.dart';

class CustomTitleBar extends StatelessWidget {
  const CustomTitleBar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
            onTap: () => Get.back(),
            child: CustomBackButton()),
        Expanded(  // This ensures the Text is centered
          child: Text(
            title,
            style: styleForText.copyWith(fontSize: 24),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
