import 'package:flutter/material.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/styles.dart';

class CustomProfileListTile extends StatelessWidget {
  CustomProfileListTile({super.key, required this.title, required this.rightTitle, required this.icon});
  String title;
  String rightTitle;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.iconColor,),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: styleForText.copyWith(fontSize: 18),overflow: TextOverflow.ellipsis,),
          Text(rightTitle, style: styleForText.copyWith(fontSize: 15)),
        ],
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: AppColors.white,),
    );
  }
}
