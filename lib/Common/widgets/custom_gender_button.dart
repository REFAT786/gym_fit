import 'package:flutter/material.dart';

class CustomGenderButton extends StatelessWidget {
  const CustomGenderButton({super.key, required this.genderIcon, required this.isSelected});

  final IconData genderIcon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? Colors.red : Color(0xfffef2f3),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(genderIcon, size: 80, color: isSelected ? Colors.white : Colors.red,),
        ],
      ),
    );
  }
}
