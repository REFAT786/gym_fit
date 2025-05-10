import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import '../../../../../Common/widgets/custom_back_button.dart';
import '../../../../../Common/widgets/custom_trainer_gradient_background_color.dart';
import '../../../../../Helpers/prefs_helper.dart';
import '../../../../../Utils/app_colors.dart';
import '../../../../../Utils/app_string.dart';
import '../../../../../Utils/styles.dart';
import '../../../../Trainee/color/controller/color_controller.dart';
import '../controller/policy_controller.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  PrivacyPolicyScreen({super.key});
  final PolicyController controller = Get.find<PolicyController>();
  final ColorController colorController = Get.find<ColorController>();

  @override
  Widget build(BuildContext context) {
    return CustomTrainerGradientBackgroundColor(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const CustomBackButton(),
          ),
          title: Text(
            AppString.privacyPolicy,
            style: styleForText.copyWith(fontSize: 24),
          ),
          centerTitle: true,
        ),
        body: Obx(() {
          return controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : controller.privacyPolicy.value.isEmpty
              ? Center(
            child: Text(
              "Privacy Policy is not available.",
              style: styleForText.copyWith(
                color: PrefsHelper.myRole == "trainee"
                    ? colorController.getTextColor()
                    : AppColors.white,
                fontSize: 16,
              ),
            ),
          )
              : SingleChildScrollView(
            padding: const EdgeInsets.all(11.0),
            child: Html(
              data: controller.privacyPolicy.value,
              style: {
                // Apply the text style to all HTML elements that contain text
                "body": Style(
                  color: PrefsHelper.myRole == "trainee"
                      ? colorController.getTextColor()
                      : AppColors.white,
                  fontSize: FontSize(16),
                  fontFamily: styleForText.fontFamily,
                  fontWeight: styleForText.fontWeight,
                ),
                "p": Style(
                  color: PrefsHelper.myRole == "trainee"
                      ? colorController.getTextColor()
                      : AppColors.white,
                  fontSize: FontSize(16),
                  fontFamily: styleForText.fontFamily,
                  fontWeight: styleForText.fontWeight,
                ),
                "h1": Style(
                  color: PrefsHelper.myRole == "trainee"
                      ? colorController.getTextColor()
                      : AppColors.white,
                  fontSize: FontSize(16),
                  fontFamily: styleForText.fontFamily,
                  fontWeight: styleForText.fontWeight,
                ),
                "h2": Style(
                  color: PrefsHelper.myRole == "trainee"
                      ? colorController.getTextColor()
                      : AppColors.white,
                  fontSize: FontSize(16),
                  fontFamily: styleForText.fontFamily,
                  fontWeight: styleForText.fontWeight,
                ),
                "h3": Style(
                  color: PrefsHelper.myRole == "trainee"
                      ? colorController.getTextColor()
                      : AppColors.white,
                  fontSize: FontSize(16),
                  fontFamily: styleForText.fontFamily,
                  fontWeight: styleForText.fontWeight,
                ),
                "li": Style(
                  color: PrefsHelper.myRole == "trainee"
                      ? colorController.getTextColor()
                      : AppColors.white,
                  fontSize: FontSize(16),
                  fontFamily: styleForText.fontFamily,
                  fontWeight: styleForText.fontWeight,
                ),
                "span": Style(
                  color: PrefsHelper.myRole == "trainee"
                      ? colorController.getTextColor()
                      : AppColors.white,
                  fontSize: FontSize(16),
                  fontFamily: styleForText.fontFamily,
                  fontWeight: styleForText.fontWeight,
                ),
                // Add more HTML tags as needed
              },
            ),
          );
        }),
      ),
    );
  }
}