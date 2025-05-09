import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

enum ImageType { png, svg, network, file }

class CustomCommonImage extends StatelessWidget {
  final String imageSrc;
  final String defaultImage;
  final Color? imageColor;
  final double height;
  final double width;
  final double borderRadius;
  final double? size;
  final ImageType imageType;
  final BoxFit fill;

  CustomCommonImage({
    required this.imageSrc,
    this.imageColor,
    this.height = 100,
    this.borderRadius = 10,
    this.width = 200,
    this.size,
    this.imageType = ImageType.svg,
    this.fill = BoxFit.fill,
    this.defaultImage = "assets/images/noImage.png",
    super.key,
  });

  late Widget imageWidget;

  @override
  Widget build(BuildContext context) {
    if (imageType == ImageType.svg) {
      imageWidget = SvgPicture.asset(
        imageSrc,
        // ignore: deprecated_member_use
        color: imageColor,
        height: size ?? height,
        width: size ?? width,
        fit: fill,
      );
    }

    if (imageType == ImageType.png) {
      imageWidget = ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image.asset(
          imageSrc,
          color: imageColor,
          height: size ?? height,
          width: size ?? width,
          fit: fill,
          errorBuilder: (context, error, stackTrace) {
            if (kDebugMode) {
              print("imageError : $error");
            }
            return Image.asset(defaultImage);
          },
        ),
      );
    }

    //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

    if (imageType == ImageType.network) {
      imageWidget = CachedNetworkImage(
        height: size ?? height,
        width: size?? width,
        // imageUrl: "${AppUrls.imageUrl}/$imageSrc"
        imageUrl: imageSrc,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.fill,
            ),
          ),
        ),
        progressIndicatorBuilder: (context, url, downloadProgress) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: size ?? height,
              width: size ?? width,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
          );
        },
        errorWidget: (context, url, error) {
          if (kDebugMode) {
            print("============>>>error: $error");
            print("============>>>error: $defaultImage");
          }
          return Container(
            height: size ?? height,
            width: size?? width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                image: DecorationImage(image: AssetImage(defaultImage))
            ),
            // child: Image.asset(
            //   defaultImage,
            // ),
          );
        },
      );
    }

    //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

    if (imageType == ImageType.file) {
      imageWidget = ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image.file(
          File(imageSrc),
          color: imageColor,
          height: size ?? height,
          width: size ?? width,
          fit: fill,
          errorBuilder: (context, error, stackTrace) {
            if (kDebugMode) {
              print("============>>>error: $error");
            }
            return Image.asset(
              defaultImage,
              height: size ?? height,
              width: size ?? width,
              fit: fill,
            );
          },
        ),
      );
    }

    return SizedBox(
        height: size ?? height,
        width: size ?? width,
        child: imageWidget);
  }
}