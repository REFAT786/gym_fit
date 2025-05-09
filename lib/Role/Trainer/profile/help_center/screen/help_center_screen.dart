import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gym_fit/Model/faq_model.dart';
import 'package:gym_fit/Role/Trainer/profile/help_center/controller/help_center_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../Common/widgets/custom_back_button.dart';
import '../../../../../Common/widgets/custom_trainer_gradient_background_color.dart';
import '../../../../../Helpers/prefs_helper.dart';
import '../../../../../Utils/app_colors.dart';
import '../../../../../Utils/app_string.dart';
import '../../../../../Utils/styles.dart';
import '../../../../Trainee/color/controller/color_controller.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final controller = Get.find<HelpCenterController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTrainerGradientBackgroundColor(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const CustomBackButton(),
          ),
          title: Text(
            AppString.helpCenter,
            style: styleForText.copyWith(fontSize: 24),
          ),
          centerTitle: true,
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: PrefsHelper.myRole == "trainee"
                ? ColorController.instance.selectedButtonColor.value == "default"
                ? AppColors.traineePrimaryColor
                : ColorController.instance.getButtonColor()
                : AppColors.secondary,
            labelColor: PrefsHelper.myRole == "trainee"
                ? ColorController.instance.selectedButtonColor.value == "default"
                ? AppColors.traineePrimaryColor
                : ColorController.instance.getButtonColor()
                : AppColors.secondary,
            unselectedLabelColor: PrefsHelper.myRole == "trainee"
                ? ColorController.instance.getTextColor()
                : AppColors.white,
            labelStyle: styleForText.copyWith(fontSize: 16),
            tabs:  [
              Tab(text: AppString.faq),
              Tab(text: AppString.contactUs),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            // FAQ Tab
            Obx(
                  () => controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : controller.faqList.isNotEmpty
                  ? ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                itemCount: controller.faqList.length,
                itemBuilder: (context, index) {
                  FAQModel faq = controller.faqList[index];
                  return Card(
                    color: PrefsHelper.myRole == "trainee"
                        ? AppColors.traineeNavBArColor
                        : AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ExpansionTile(
                      iconColor: PrefsHelper.myRole == "trainee"
                          ? ColorController.instance.selectedButtonColor.value == "default"
                          ? AppColors.traineePrimaryColor
                          : ColorController.instance.getButtonColor()
                          : AppColors.secondary,
                      collapsedIconColor: PrefsHelper.myRole == "trainee"
                          ? ColorController.instance.selectedButtonColor.value == "default"
                          ? AppColors.traineePrimaryColor
                          : ColorController.instance.getButtonColor()
                          : AppColors.secondary,
                      title: Text(
                        faq.question,
                        style: styleForText.copyWith(
                          color: ColorController.instance.getTextColor(),
                          fontSize: 18,
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            faq.answer,
                            style: styleForText.copyWith(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
                  : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controller.errorMessage.value.isNotEmpty
                          ? controller.errorMessage.value
                          : "No FAQs available",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    if (controller.errorMessage.value.isNotEmpty)
                      TextButton(
                        onPressed: () => controller.fetchFaq(),
                        child: const Text("Retry"),
                      ),
                  ],
                ),
              ),
            ),
            // Contact Us Tab
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    _buildClickableTile(
                      icon: FontAwesomeIcons.facebook,
                      color: AppColors.secondary,
                      title: "Facebook",
                      url: "https://facebook.com", // Replace with actual URL
                    ),
                    const SizedBox(height: 10),
                    _buildClickableTile(
                      icon: FontAwesomeIcons.whatsapp,
                      color: Colors.green,
                      title: "WhatsApp",
                      url: "https://whatsapp.com", // Replace with actual URL
                    ),
                    const SizedBox(height: 10),
                    _buildClickableTile(
                      icon: FontAwesomeIcons.youtube,
                      color: Colors.red,
                      title: "YouTube",
                      url: "https://youtube.com", // Replace with actual URL
                    ),
                    const SizedBox(height: 10),
                    _buildClickableTile(
                      icon: FontAwesomeIcons.linkedin,
                      color: Colors.blueAccent,
                      title: "LinkedIn",
                      url: "https://linkedin.com", // Replace with actual URL
                    ),
                    const SizedBox(height: 10),
                    _buildClickableTile(
                      icon: FontAwesomeIcons.twitter,
                      color: Colors.blue,
                      title: "Twitter",
                      url: "https://twitter.com", // Replace with actual URL
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Launcher method
  void launcherMethod(String url) async {
    if (url.isEmpty) {
      log("URL is empty");
      return;
    }
    if (!url.startsWith("http") && !url.startsWith("https")) {
      url = "https://$url";
    }
    var launcherUrl = Uri.parse(url);
    try {
      if (await canLaunchUrl(launcherUrl)) {
        await launchUrl(launcherUrl);
      } else {
        throw 'Could not launch $launcherUrl';
      }
    } catch (e) {
      log("Error launching URL: $e");
    }
  }

  // Helper method to build clickable tiles
  Widget _buildClickableTile({
    required IconData icon,
    required String title,
    required Color color,
    required String url,
  }) {
    return GestureDetector(
      onTap: () => launcherMethod(url),
      child: ListTile(
        leading: FaIcon(icon, color: color),
        title: Text(
          title,
          style: styleForText.copyWith(fontSize: 16),
        ),
      ),
    );
  }
}