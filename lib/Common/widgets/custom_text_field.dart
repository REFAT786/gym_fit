import 'package:flutter/material.dart';
import '../../Helpers/prefs_helper.dart';
import '../../Role/Trainee/color/controller/color_controller.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/styles.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.isSuffix,
      this.prefixIcon,
      required this.backgroundColor,
      required this.controller});

  final String hintText;
  final bool isSuffix;
  final IconData? prefixIcon;
  final TextEditingController controller;
  final Color backgroundColor;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        //padding: EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(100),
          // border: Border.all(color: AppColors.secondary,width: 0.3)
        ),
        child: TextField(
          style: styleForText.copyWith(color: AppColors.textColor, fontSize: 16),
          controller: widget.controller,
          obscureText: widget.isSuffix ? !passwordVisible : passwordVisible,
          cursorColor: Colors.white,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              prefixIcon: widget.prefixIcon != null
                  ? Icon(
                      widget.prefixIcon,
                      color: Colors.white,
                      size: 22,
                    )
                  : null,
              suffixIcon: widget.isSuffix
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                      icon: !passwordVisible
                          ? const Icon(Icons.visibility_off,
                              color: Colors.white, size: 22)
                          : const Icon(Icons.visibility,
                              color: Colors.white, size: 22),
                    )
                  : null,
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: styleForText.copyWith(
                  color: PrefsHelper.myRole=="trainee"?ColorController.instance.getTextColor():AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.normal)),
        ));
  }
}
