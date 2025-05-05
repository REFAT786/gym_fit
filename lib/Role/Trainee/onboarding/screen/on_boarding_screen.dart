import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_ruler_picker/simple_ruler_picker.dart';

import '../../../../Helpers/prefs_helper.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Utils/styles.dart';
import '../../nav/screen/trainee_nav_bar_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;
  String selectedGender = 'male'; // Track selected gender
  int selectedAge = 18;
  bool isCmSelected = true;
  int selectedHeightCm = 170;
  int selectedHeightInches = 67;
  bool isKgSelected = true;
  int selectedWeightKg = 70;
  int selectedWeightLbs = 154;

  double calculateBMI() {
    double heightM = isCmSelected ? selectedHeightCm / 100.0 : selectedHeightInches * 0.0254;
    double weightKg = isKgSelected ? selectedWeightKg.toDouble() : selectedWeightLbs * 0.453592;
    return weightKg / (heightM * heightM);
  }

  @override
  Widget build(BuildContext context) {
    log("?>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ${PrefsHelper.myRole}");
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 40),
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
                          margin: EdgeInsets.symmetric(horizontal: 4),
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
                  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>// Calls the gender selection function
                  genderPage(),
                  agePage(),
                  heightPage(),
                  weightPage(),
                  bmiResult(),

                  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
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
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                ),
                onPressed: () {
                  if (currentPage < 4) {
                    _pageController.nextPage(
                        duration: Duration(milliseconds: 300), curve: Curves.ease);
                  }else{
                    Get.off(TraineeNavBarScreen());
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(currentPage < 4 ? "Next" : "Finish", style: styleForText.copyWith(fontSize: 18, color: Colors.white)),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
                    Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
                    Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> gender Page >>>>>>>>>>>>>>>>>>>>>>>>

  Widget genderPage() {
    return Column(
      children: [
        SizedBox(height: 40,),
        Text("What’s Your Gender?",
            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
        SizedBox(height: 30),

        // Male Selection
        GestureDetector(
          onTap: () {
            setState(() {
              selectedGender = "male";
            });
          },
          child: CircleAvatar(
            radius: selectedGender == "male" ? 62 : 60,
            backgroundColor: selectedGender == "male" ? Colors.red : Colors.white,
            child: Icon(Icons.male, color: selectedGender == "male" ? Colors.white : Colors.red, size: 50),
          ),
        ),
        SizedBox(height: 16),

        // Female Selection
        GestureDetector(
          onTap: () {
            setState(() {
              selectedGender = "female";
            });
          },
          child: CircleAvatar(
            radius: selectedGender == "female" ? 62 : 60,
            backgroundColor: selectedGender == "female" ? Colors.red : Colors.white,
            child: Icon(Icons.female, color: selectedGender == "female" ? Colors.white : Colors.red, size: 50),
          ),
        ),
      ],
    );
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Age Page >>>>>>>>>>>>>>>>>>>>>>>>

  Widget agePage(){
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Text("Page Age", style: styleForText,)
        SizedBox(height: 40,),

         Text(
          "What's Your Age?",
          style: styleForText.copyWith(fontSize: 24, color: AppColors.textColor),
        ),
        const SizedBox(height: 30),
        Container(
          height: 170,
          // width: 300,
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(20),
          ),
          child: CupertinoPicker(
            backgroundColor: Colors.transparent,
            itemExtent: 50,
            scrollController:
            FixedExtentScrollController(initialItem: selectedAge - 26),
            onSelectedItemChanged: (index) {
              setState(() {
                selectedAge = index + 18;
              });
            },
            children:

            List.generate(60, (index) {
              int age = index + 18;
              return Center(
                child: Text(
                  "$age",
                  style: TextStyle(
                    color: age == selectedAge ? Colors.white : Colors.grey,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }

            ),
          ),
        ),

      ],
    );
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Height Page >>>>>>>>>>>>>>>>>>>>>>>>

  Widget heightPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("What's Your Height?", style: TextStyle(color: Colors.white, fontSize: 24)),
        const SizedBox(height: 30),
        ToggleButtons(
          borderRadius: BorderRadius.circular(20),
          selectedColor: Colors.white,
          color: Colors.white,
          fillColor: Colors.red,
          isSelected: [!isCmSelected, isCmSelected],
          onPressed: (index) {
            setState(() {
              isCmSelected = index == 1;
            });
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
                isCmSelected ? '$selectedHeightCm cm' : '$selectedHeightInches inches',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              SimpleRulerPicker(
                minValue: isCmSelected ? 140 : 55,
                maxValue: isCmSelected ? 200 : 85,
                initialValue: isCmSelected ? selectedHeightCm : selectedHeightInches,
                onValueChanged: (value) {
                  setState(() {
                    if (isCmSelected) {
                      selectedHeightCm = value;
                    } else {
                      selectedHeightInches = value;
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Weight Page >>>>>>>>>>>>>>>>>>>>>>>>

  Widget weightPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("What's Your Weight?", style: TextStyle(color: Colors.white, fontSize: 24)),
        const SizedBox(height: 30),
        ToggleButtons(
          borderRadius: BorderRadius.circular(20),
          selectedColor: Colors.white,
          color: Colors.white,
          fillColor: Colors.red,
          isSelected: [!isKgSelected, isKgSelected],
          onPressed: (index) {
            setState(() {
              isKgSelected = index == 1;
            });
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
                isKgSelected ? '$selectedWeightKg kg' : '$selectedWeightLbs lb',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              SimpleRulerPicker(
                minValue: isKgSelected ? 30 : 66,
                maxValue: isKgSelected ? 130 : 300,
                initialValue: isKgSelected ? selectedWeightKg : selectedWeightLbs,
                onValueChanged: (value) {
                  setState(() {
                    if (isKgSelected) {
                      selectedWeightKg = value;
                    } else {
                      selectedWeightLbs = value;
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> BMI result >>>>>>>>>>>>>>>>>>>>>>>>

  Widget bmiResult(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Your Current BMI", style: styleForText.copyWith(color: AppColors.textColor),),

        SizedBox(height: 20,),

        Text(calculateBMI().toStringAsFixed(2), style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
      ],
    );
  }


}
