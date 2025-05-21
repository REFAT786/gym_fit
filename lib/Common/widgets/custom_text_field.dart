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
      this.validator,
       this.backgroundColor = AppColors.primary,
       this.onChanged,
      required this.controller});

  final String hintText;
  final bool isSuffix;
  final IconData? prefixIcon;
  final TextEditingController controller;
  final Color backgroundColor;
  final FormFieldValidator? validator;
  final Function(String)? onChanged;

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
        child: TextFormField(
          onChanged: widget.onChanged,
          validator: widget.validator,
          style: styleForText.copyWith(color: AppColors.textColor, fontSize: 16),
          controller: widget.controller,
          obscureText: widget.isSuffix ? !passwordVisible : passwordVisible,
          cursorColor: Colors.white,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(18),
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
                          ?  Icon(Icons.visibility_off,
                              color: AppColors.hintGrey, size: 22)
                          :  Icon(Icons.visibility,
                              color: AppColors.hintGrey, size: 22),
                    )
                  : null,
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: styleForText.copyWith(
                  fontWeight: FontWeight.w500,
                  color: PrefsHelper.myRole=="trainee"?ColorController.instance.getHintTextColor():AppColors.hintGrey,
                  fontSize: 16,
                  )),
        ));
  }
}
