import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../Common/widgets/custom_trainer_gradient_background_color.dart';
import '../../../../Helpers/prefs_helper.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Utils/app_icons.dart';
import '../../Nav/controller/nav_controller.dart';
import '../../home/screen/trainer_home_screen.dart';
import '../../management/screen/trainer_management_screen.dart';
import '../../profile/profile/screen/profile_screen.dart';

class NavBarScreen extends StatelessWidget {
  NavBarScreen({super.key});

  final NavController navController = Get.find<NavController>();

  // Function to get the active screen
  Widget _getActiveScreen() {
    if (navController.isHomeActive.value) {
      return  TrainerHomeScreen();
    } else if (navController.isGymActive.value) {
      return  TrainerManagementScreen();
    } else if (navController.isProfileActive.value) {
      return ProfileScreen();
    }
    return const SizedBox();
  }

  // Function to build navigation items
  Widget _buildNavItem(String tab, dynamic icon, bool isActive) {
    return InkWell(
      onTap: () {
        navController.updateActiveTab(tab);
      },
      child: CircleAvatar(
        radius: 28,
        backgroundColor: isActive ? AppColors.secondary : AppColors.grey,
        child: icon is IconData
            ? Icon(
                icon,
                size: 34,
                color: isActive ? AppColors.primary : AppColors.white,
              )
            : SvgPicture.asset(
                icon,
                colorFilter: ColorFilter.mode(
                  isActive ? AppColors.primary : AppColors.white,
                  BlendMode.srcIn,
                ),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    log(">>>>>>>>>>>>>>>>>>>>>>>>> my role ${PrefsHelper.myRole}");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomTrainerGradientBackgroundColor(
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                return AnimatedSwitcher(
                  duration:
                      const Duration(milliseconds: 300), // Animation duration
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(
                        opacity: animation,
                        child: child); // Smooth fade transition
                  },
                  child: _getActiveScreen(), // Function to return active screen
                );
              }),
            ),
            KeyboardVisibilityBuilder(builder: (p0, isKeyboardVisible) {
              return isKeyboardVisible
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10),
                      child: Obx(() {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.bottomNavColor,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildNavItem('home', Icons.home,
                                  navController.isHomeActive.value),
                              _buildNavItem('gym', AppIcons.gymBarIcon,
                                  navController.isGymActive.value),
                              _buildNavItem('profile', Icons.person,
                                  navController.isProfileActive.value),
                            ],
                          ),
                        );
                      }),
                    );
            })
          ],
        ),
      ),
    );
  }
}
