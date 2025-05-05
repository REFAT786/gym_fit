import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

Widget customColorPickerDialog({required BuildContext context, required Color initialColor, required Function(Color) onColorChanged,}) {

  Color currentColor = initialColor;

  return AlertDialog(
    title: const Text('Pick a color'),
    content: SingleChildScrollView(
      child: ColorPicker(
        pickerColor: currentColor,
        onColorChanged: (color) {
          currentColor = color;
        },
        labelTypes: const [ColorLabelType.hsl, ColorLabelType.rgb],
        pickerAreaHeightPercent: 0.8,
      ),
    ),
    actions: <Widget>[
      TextButton(
        child: const Text('Cancel'),
        onPressed: () {
          Get.back();
        },
      ),
      TextButton(
        child: const Text('OK'),
        onPressed: () {
          onColorChanged(currentColor);
          Get.back();
        },
      ),
    ],
  );
}