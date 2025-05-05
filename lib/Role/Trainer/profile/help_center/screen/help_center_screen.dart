import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

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

class _HelpCenterScreenState extends State<HelpCenterScreen> with SingleTickerProviderStateMixin{

  late TabController _tabController;

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
                onPressed: (){Get.back();},
                icon: CustomBackButton()
            ),
            title: Text(
              AppString.helpCenter,
              style: styleForText.copyWith(
                fontSize: 24

              ),
            ),
            centerTitle: true,
            bottom: TabBar(
              onTap: (value) {
                log("value======$value");
                // if (value == 0) {
                //   // controller.fetchFaq();
                // } else {
                //   // controller.fetchContact();
                // }
              },
              controller: _tabController,
              indicatorColor:PrefsHelper.myRole=="trainee"?ColorController.instance.selectedButtonColor.value=="default"?AppColors.traineePrimaryColor:ColorController.instance.getButtonColor():AppColors.secondary,
              labelColor: PrefsHelper.myRole=="trainee"?ColorController.instance.selectedButtonColor.value=="default"?AppColors.traineePrimaryColor:ColorController.instance.getButtonColor():AppColors.secondary,
              unselectedLabelColor: PrefsHelper.myRole=="trainee"?ColorController.instance.getTextColor():AppColors.white,
              labelStyle: styleForText.copyWith(fontSize: 16),
              tabs: [
                Tab(text: AppString.faq),
                Tab(text: AppString.contactUs),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  FAQ Tab
              Column(
                children: [
                  // Category Tabs
                  const SizedBox(height: 10),
                  // FAQ List
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: 5,//controller.faqList.length,
                      itemBuilder: (context, index) {
                        // FaqModel data = controller.faqList[];
                        //FaqModel faq = controller.faqList[index];
                        return Card(
                          color: PrefsHelper.myRole=="trainee"? AppColors.traineeNavBArColor:AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ExpansionTile(
                            iconColor: PrefsHelper.myRole=="trainee"?ColorController.instance.selectedButtonColor.value=="default"?AppColors.traineePrimaryColor:ColorController.instance.getButtonColor():AppColors.secondary, // Color for expanded state
                            collapsedIconColor: PrefsHelper.myRole=="trainee"?ColorController.instance.selectedButtonColor.value=="default"?AppColors.traineePrimaryColor:ColorController.instance.getButtonColor():AppColors.secondary, // Color for collapsed state
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                            title: Text(
                              "Qus",//faq.question,
                              style: styleForText.copyWith(
                                color: ColorController.instance.getTextColor(),
                                fontSize: 18
                              ),
                            ),

                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Ans", style: styleForText.copyWith(fontSize: 14),),//faq.answer
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  Contact Us Tab
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      // Facebook URL
                      _buildClickableTile(
                        icon: FontAwesomeIcons.facebook,
                        color: AppColors.secondary,
                        title: "Facebook",//data.facebookUrl,
                        url: "",//data.facebookUrl,
                      ),
                      SizedBox(height: 10),

                      // Customer Service
                      _buildClickableTile(
                        icon: FontAwesomeIcons.whatsapp,
                        color: Colors.green,
                        title: "Youtube",//data.facebookUrl,
                        url: "",//data.facebookUrl,
                      ),
                      SizedBox(height: 10),

                      // YouTube URL
                      _buildClickableTile(
                        icon: FontAwesomeIcons.youtube,
                        color: Colors.red,
                        title: "Instagram",//data.facebookUrl,
                        url: "",//data.facebookUrl,
                      ),
                      SizedBox(height: 10),

                      // LinkedIn URL
                      _buildClickableTile(
                        icon: FontAwesomeIcons.linkedin,
                        color: Colors.blueAccent,
                        title: "Linkedin",//data.facebookUrl,
                        url: "",//data.facebookUrl,
                      ),
                      SizedBox(height: 10),

                      // Twitter URL
                      _buildClickableTile(
                        icon: FontAwesomeIcons.twitter,
                        color: Colors.blue,
                        title: "Twitter",//data.facebookUrl,
                        url: "",//data.facebookUrl,
                      ),
                      SizedBox(height: 10),

                      // Instagram URL

                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }

  //====================================================launcher method
  void launcherMethod(String url) async {
    // Ensure the URL has a valid scheme (http or https)
    if (!url.startsWith("http") && !url.startsWith("https")) {
      url = "https://$url"; // Add the 'https://' scheme if missing
    }

    var launcherUrl = Uri.parse(url);
    try {
      if (await canLaunchUrl(launcherUrl)) {
        await launchUrl(launcherUrl); // Launch the valid URL
      } else {
        throw 'Could not launch $launcherUrl';
      }
    } catch (e) {
      log(e.toString()); // Log the error if URL can't be launched
    }
  }

  // A helper method to build clickable tiles
  Widget _buildClickableTile({
    required IconData icon,
    required String title,
    required Color color,
    required String url,
  }) {
    return GestureDetector(
      onTap: () async {
        launcherMethod(url);
      },
      child: ListTile(
        leading: FaIcon(
          icon,
          color: color,
        ),
        title: Text(
          title,
          style: styleForText.copyWith(fontSize: 16),
        ),
      ),
    );
  }

}
