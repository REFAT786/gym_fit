import 'package:flutter/material.dart';

import '../../Helpers/prefs_helper.dart';
import '../../Role/Trainee/color/controller/color_controller.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/styles.dart';
import 'custom_common_image.dart';

class CustomListTile extends StatelessWidget {
  final String? leadingImage;
  final double leadingImageHeight;
  final double leadingImageWeight;
  final double leadingImageBorderRadius;
  final String? title;
  final String? subTitle;
  final String? subTitleNext;
  final double? titleFontSize;
  final double? subTitleFontSize;
  final double? subTitleNextFontSize;
  final double? trailingIconSize;
  final IconData? trailingIcon;

  const CustomListTile({
    super.key,
    this.leadingImage,
    this.leadingImageHeight = 50,
    this.leadingImageWeight = 50,
    this.leadingImageBorderRadius = 100,
    this.title,
    this.subTitle = '',
    this.subTitleNext = '',
    this.titleFontSize = 24,
    this.subTitleFontSize =18,
    this.subTitleNextFontSize = 16,
    this.trailingIconSize = 24,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: PrefsHelper.myRole=="trainee"?AppColors.traineeNavBArColor:AppColors.primary,
      ),
      child: ListTile(
        leading: CustomCommonImage(
                imageSrc: leadingImage!,
                imageType: ImageType.network,
                borderRadius: leadingImageBorderRadius,
                height: leadingImageHeight,
                width: leadingImageWeight,
              ),
        title: Text(
          "$title",
          style: styleForText.copyWith(fontSize: titleFontSize),
        ),
        subtitle: (subTitle != '' || subTitleNext != '')
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (subTitle!.isNotEmpty)
                    Text(
                      "$subTitle",
                      style: styleForText.copyWith(fontSize: subTitleFontSize),
                    ),
                  if (subTitleNext!.isNotEmpty)
                    Text(
                      "$subTitleNext",
                      style: styleForText.copyWith(fontSize: subTitleNextFontSize),
                    ),
                ],
              )
            : null,
        trailing: trailingIcon != null
            ? Icon(trailingIcon, color: PrefsHelper.myRole=="trainee"?ColorController.instance.selectedButtonColor.value=="default"?AppColors.traineePrimaryColor:ColorController.instance.getButtonColor():AppColors.secondary, size: trailingIconSize,)
            : null,
      ),
    );
  }
}
