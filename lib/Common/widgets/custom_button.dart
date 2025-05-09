import 'package:flutter/material.dart';

import '../../Utils/styles.dart';
class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.backgroundColor, required this.textColor, required this.buttonText, this.isLoading});
  final String buttonText;
  final bool? isLoading;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(100)
      ),
      child: Center(
          child:isLoading == true
              ? SizedBox(height: 20, width: 20,child: CircularProgressIndicator(color: Colors.white,))
              : Text(buttonText, style: styleForText.copyWith(color: textColor)),
      ),
    );
  }
}
