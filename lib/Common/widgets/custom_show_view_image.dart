import 'package:flutter/material.dart';

import 'custom_common_image.dart';

class CustomShowViewImage extends StatelessWidget {
  const CustomShowViewImage({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: CustomCommonImage(
            imageSrc: imageUrl,
            imageType: ImageType.network,
            height: double.infinity,
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
