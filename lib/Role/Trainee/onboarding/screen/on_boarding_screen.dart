import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_ruler_picker/simple_ruler_picker.dart';

import '../../../../Helpers/prefs_helper.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Utils/styles.dart';
import '../../nav/screen/trainee_nav_bar_screen.dart';
import '../on_boarding_controller.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  final OnBoardingController controller = Get.find<OnBoardingController>();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    log("?>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ${PrefsHelper.myRole}");
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            // Top Navigation and Progress Bar
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        5, // Total steps
                            (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 30,
                          height: 4,
                          decoration: BoxDecoration(
                            color: index == currentPage ? Colors.red : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                children: [
                  genderPage(),
                  agePage(),
                  heightPage(),
                  weightPage(),
                  bmiResult(),
                ],
              ),
            ),

            // Bottom Next Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                ),
                onPressed: () {
                  if (currentPage < 4) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  } else {
                    controller.bmiResult();
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      currentPage < 4 ? "Next" : "Finish",
                      style: styleForText.copyWith(fontSize: 18, color: Colors.white),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
                    const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
                    const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Gender Page
  Widget genderPage() {
    return Obx(
          () => Column(
        children: [
          const SizedBox(height: 40),
          const Text(
            "What’s Your Gender?",
            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          // Male Selection
          GestureDetector(
            onTap: () {
              controller.selectedGender.value = "male";
            },
            child: CircleAvatar(
              radius: controller.selectedGender.value == "male" ? 62 : 60,
              backgroundColor: controller.selectedGender.value == "male" ? Colors.red : Colors.white,
              child: Icon(
                Icons.male,
                color: controller.selectedGender.value == "male" ? Colors.white : Colors.red,
                size: 50,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Female Selection
          GestureDetector(
            onTap: () {
              controller.selectedGender.value = "female";
            },
            child: CircleAvatar(
              radius: controller.selectedGender.value == "female" ? 62 : 60,
              backgroundColor: controller.selectedGender.value == "female" ? Colors.red : Colors.white,
              child: Icon(
                Icons.female,
                color: controller.selectedGender.value == "female" ? Colors.white : Colors.red,
                size: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Age Page
  Widget agePage() {
    return Obx(
          () => Column(
        children: [
          const SizedBox(height: 40),
          Text(
            "What's Your Age?",
            style: styleForText.copyWith(fontSize: 24, color: AppColors.textColor),
          ),
          const SizedBox(height: 30),
          Container(
            height: 170,
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(20),
            ),
            child: CupertinoPicker(
              backgroundColor: Colors.transparent,
              itemExtent: 50,
              scrollController: FixedExtentScrollController(
                initialItem: controller.selectedAge.value - 18,
              ),
              onSelectedItemChanged: (index) {
                controller.selectedAge.value = index + 18;
              },
              children: List.generate(60, (index) {
                int age = index + 18;
                return Center(
                  child: Text(
                    "$age",
                    style: TextStyle(
                      color: age == controller.selectedAge.value ? Colors.white : Colors.grey,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  /// Height Page
  Widget heightPage() {
    return Obx(
          () => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "What's Your Height?",
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          const SizedBox(height: 30),
          ToggleButtons(
            borderRadius: BorderRadius.circular(20),
            selectedColor: Colors.white,
            color: Colors.white,
            fillColor: Colors.red,
            isSelected: [!controller.isCmSelected.value, controller.isCmSelected.value],
            onPressed: (index) {
              controller.isCmSelected.value = index == 1;
            },
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('inches'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('cm'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  controller.isCmSelected.value
                      ? '${controller.selectedHeightCm.value} cm'
                      : '${controller.selectedHeightInches.value} inches',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                SimpleRulerPicker(
                  minValue: controller.isCmSelected.value ? 140 : 55,
                  maxValue: controller.isCmSelected.value ? 200 : 85,
                  initialValue: controller.isCmSelected.value
                      ? controller.selectedHeightCm.value
                      : controller.selectedHeightInches.value,
                  onValueChanged: (value) {
                    if (controller.isCmSelected.value) {
                      controller.selectedHeightCm.value = value;
                    } else {
                      controller.selectedHeightInches.value = value;
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Weight Page
  Widget weightPage() {
    return Obx(
          () => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "What's Your Weight?",
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          const SizedBox(height: 30),
          ToggleButtons(
            borderRadius: BorderRadius.circular(20),
            selectedColor: Colors.white,
            color: Colors.white,
            fillColor: Colors.red,
            isSelected: [!controller.isKgSelected.value, controller.isKgSelected.value],
            onPressed: (index) {
              controller.isKgSelected.value = index == 1;
            },
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('lb'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('kg'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  controller.isKgSelected.value
                      ? '${controller.selectedWeightKg.value} kg'
                      : '${controller.selectedWeightLbs.value} lb',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                SimpleRulerPicker(
                  minValue: controller.isKgSelected.value ? 30 : 66,
                  maxValue: controller.isKgSelected.value ? 130 : 300,
                  initialValue: controller.isKgSelected.value
                      ? controller.selectedWeightKg.value
                      : controller.selectedWeightLbs.value,
                  onValueChanged: (value) {
                    if (controller.isKgSelected.value) {
                      controller.selectedWeightKg.value = value;
                    } else {
                      controller.selectedWeightLbs.value = value;
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// BMI Result Page
  Widget bmiResult() {
    return Obx(
          () => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Your BMI Summary",
            style: styleForText.copyWith(color: AppColors.textColor, fontSize: 24),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Gender: ${controller.selectedGender.value.capitalizeFirst}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Age: ${controller.selectedAge.value} years",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Height: ${controller.isCmSelected.value ? '${controller.selectedHeightCm.value} cm' : '${controller.selectedHeightInches.value} inches'}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Weight: ${controller.isKgSelected.value ? '${controller.selectedWeightKg.value} kg' : '${controller.selectedWeightLbs.value} lb'}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "BMI: ${controller.calculateBMI.toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}