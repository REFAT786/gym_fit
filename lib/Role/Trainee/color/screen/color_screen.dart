import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Common/widgets/custom_back_button.dart';
import '../../../../Common/widgets/custom_color_picker_dialog.dart';
import '../../../../Helpers/prefs_helper.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Utils/styles.dart';
import '../controller/color_controller.dart';

class ColorScreen extends StatelessWidget {
  ColorScreen({super.key});

  final ColorController colorController = Get.put(ColorController());

  void openColorPicker(BuildContext context, Function(Color) onColorChanged) {
    showDialog(
      context: context,
      builder: (context) => customColorPickerDialog(
        context: context,
        initialColor: colorController.customBgColor.value,
        onColorChanged: onColorChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        color: colorController.getBgColor(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const CustomBackButton(),
            ),
            title: Text(
              "Appearance",
              style: styleForText.copyWith(fontSize: 24, color: PrefsHelper.myRole == 'trainee'?ColorController.instance.getTextColor():AppColors.white),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text("Background Color", style: styleForText.copyWith(color: PrefsHelper.myRole == 'trainee'?ColorController.instance.getTextColor():AppColors.white)),
                  const SizedBox(height: 10),
                  buildColorSection(
                    selectedColor: colorController.selectedBgColor,
                    colorMap: colorController.bgColorMap,
                    customColor: colorController.customBgColor,
                    onColorChange: (colorName) {
                      colorController.changeBgColor(colorName);
                    },
                    onCustomColorChange: (color) {
                      colorController.setCustomBgColor(color);
                      colorController.changeBgColor("custom");
                    },
                    context: context,
                  ),
                  const SizedBox(height: 20),
                  Text("Button Color", style: styleForText.copyWith(color: PrefsHelper.myRole == 'trainee'?ColorController.instance.getTextColor():AppColors.white)),
                  const SizedBox(height: 10),
                  buildColorSection(
                    selectedColor: colorController.selectedButtonColor,
                    colorMap: colorController.buttonColorMap,
                    customColor: colorController.customButtonColor,
                    onColorChange: (colorName) {
                      colorController.changeButtonColor(colorName);
                    },
                    onCustomColorChange: (color) {
                      colorController.setCustomButtonColor(color);
                      colorController.changeButtonColor("custom");
                    },
                    context: context,
                  ),
                  const SizedBox(height: 20),
                  Text("Text Color", style: styleForText.copyWith(color: PrefsHelper.myRole == 'trainee'?ColorController.instance.getTextColor():AppColors.white)),
                  const SizedBox(height: 10),
                  buildColorSection(
                    selectedColor: colorController.selectedTextColor,
                    colorMap: colorController.textColorMap,
                    customColor: colorController.customTextColor,
                    onColorChange: (colorName) {
                      colorController.changeTextColor(colorName);
                    },
                    onCustomColorChange: (color) {
                      colorController.setCustomTextColor(color);
                      colorController.changeTextColor("custom");
                    },
                    context: context,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget buildColorSection({
    required RxString selectedColor,
    required Map<String, Color> colorMap,
    required Rx<Color> customColor,
    required Function(String) onColorChange,
    required Function(Color) onCustomColorChange,
    required BuildContext context,
  }) {
    final standardColors = Map.fromEntries(
        colorMap.entries.where((entry) => entry.key != "custom"));
    standardColors.remove("default");
    final defaultColor = colorMap["default"] ?? Colors.grey;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Colors",
                style: TextStyle(
                  color: colorController.getTextColor(),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  ...standardColors.keys.map((colorName) {
                    return GestureDetector(
                      onTap: () => onColorChange(colorName),
                      child: Obx(() {
                        return Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: selectedColor.value == colorName
                                  ? Colors.deepOrangeAccent
                                  : Colors.grey,
                              width: 2,
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: colorMap[colorName],
                              ),
                              if (selectedColor.value == colorName)
                                Icon(
                                  Icons.check,
                                  color: (colorMap[colorName]
                                                  ?.computeLuminance() ??
                                              0) >
                                          0.5
                                      ? Colors.black
                                      : Colors.white,
                                  size: 24,
                                ),
                            ],
                          ),
                        );
                      }),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Custom",
                style: TextStyle(
                  color: colorController.getTextColor(),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  openColorPicker(context, onCustomColorChange);
                },
                child: Obx(() {
                  return Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selectedColor.value == "custom"
                            ? Colors.deepOrangeAccent
                            : Colors.grey,
                        width: 2,
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: customColor.value,
                        ),
                        if (selectedColor.value == "custom")
                          Icon(
                            Icons.check,
                            color: customColor.value.computeLuminance() > 0.5
                                ? Colors.black
                                : Colors.white,
                            size: 24,
                          ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Default",
                style: TextStyle(
                  color: colorController.getTextColor(),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => onColorChange("default"),
                child: Obx(() {
                  return Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selectedColor.value == "default"
                            ? Colors.deepOrangeAccent
                            : Colors.grey,
                        width: 2,
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: defaultColor,
                        ),
                        if (selectedColor.value == "default")
                          Icon(
                            Icons.check,
                            color: defaultColor.computeLuminance() > 0.5
                                ? Colors.black
                                : Colors.white,
                            size: 24,
                          ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
