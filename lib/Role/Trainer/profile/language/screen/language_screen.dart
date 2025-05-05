import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../../../Common/widgets/custom_back_button.dart';
import '../../../../../Common/widgets/custom_trainer_gradient_background_color.dart';
import '../../../../../Helpers/prefs_helper.dart';
import '../../../../../Utils/app_colors.dart';
import '../../../../../Utils/app_string.dart';
import '../../../../../Utils/styles.dart';
import '../../../../Trainee/color/controller/color_controller.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String selectedLanguage = "English"; // Default selected language

  @override
  void initState() {
    super.initState();
    _loadLanguagePreference();
  }

  Future<void> _loadLanguagePreference() async {
    String savedLanguageCode = PrefsHelper.localizationLanguageCode;
    log("Saved Language Code: $savedLanguageCode");
    log("Saved Country Code: ${PrefsHelper.localizationCountryCode}");

    setState(() {
      selectedLanguage = _getLanguageNameFromCode(savedLanguageCode);
    });
  }

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
              icon: CustomBackButton()
          ),
          title: Text(
            AppString.language,
            style: styleForText.copyWith(fontSize: 24),
          ),
          centerTitle: true,
        ),
        body: Column(children: [
          _buildLanguageTile("English", "en", "US"),
          Divider(indent: 10, endIndent: 10),
          _buildLanguageTile("Hebrew", "he", "IL"),
          Divider(indent: 10, endIndent: 10),
          _buildLanguageTile("Arabic", "ar", "AE"),
          Divider(indent: 10, endIndent: 10),
          _buildLanguageTile("Russian", "ru", "RU"),
        ]),
      ),
    );
  }

  Widget _buildLanguageTile(String language, String languageCode, String countryCode) {
    return InkWell(
      onTap: () async {
        _changeLanguage(language, languageCode, countryCode);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Text(
              language,
              style:  TextStyle(
                fontSize: 18,
                color: ColorController.instance.getTextColor(),
              ),
            ),
            const Spacer(),
            Radio<String>(
              value: language,
              groupValue: selectedLanguage,
              onChanged: (String? value) {
                _changeLanguage(value!, languageCode, countryCode);
              },
              activeColor:PrefsHelper.myRole=="trainee"?ColorController.instance.selectedButtonColor.value=="default"?AppColors.traineePrimaryColor:ColorController.instance.getButtonColor():AppColors.secondary, // Matches the design
              fillColor: WidgetStatePropertyAll(PrefsHelper.myRole=="trainee"?ColorController.instance.selectedButtonColor.value=="default"?AppColors.traineePrimaryColor:ColorController.instance.getButtonColor():AppColors.secondary,),

            ),
          ],
        ),
      ),
    );
  }

  void _changeLanguage(String language, String languageCode, String countryCode) async {
    log("Changing language to: $language ($languageCode-$countryCode)");

    setState(() {
      selectedLanguage = language;
    });

    // Update GetX locale
    Get.updateLocale(Locale(languageCode, countryCode));

    // Save the new language selection to shared preferences
    await PrefsHelper.setString("localizationLanguageCode", languageCode);
    await PrefsHelper.setString("localizationCountryCode", countryCode);

    // Update PrefsHelper static values
    PrefsHelper.localizationLanguageCode = languageCode;
    PrefsHelper.localizationCountryCode = countryCode;
  }

  String _getLanguageNameFromCode(String code) {
    switch (code) {
      case "he":
        return "Hebrew";
      case "en":
        return "English";
      case "ar":
        return "Arabic";
      case "ru":
        return "Russian";
      default:
        return ""; // Default fallback
    }
  }
}
