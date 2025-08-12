import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_fit/Common/widgets/custom_common_image.dart';
import 'package:gym_fit/Model/history_model.dart';
import 'package:gym_fit/Utils/app_string.dart';
import 'package:gym_fit/Utils/app_url.dart';

import '../../../../Common/widgets/custom_back_button.dart';
import '../../../../Helpers/prefs_helper.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Utils/styles.dart';
import '../../color/controller/color_controller.dart';
import '../controller/history_controller.dart';

class HistoryDetailScreen extends StatelessWidget {
  HistoryDetailScreen({super.key});

  final HistoryController controller = Get.find<HistoryController>();

  @override
  Widget build(BuildContext context) {
    final HistoryAttribute data = Get.arguments['data'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const CustomBackButton(),
        ),
        title: Text(
          data.exerciseName ?? 'Workout Details',
          style: styleForText.copyWith(fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomCommonImage(
            imageSrc: "${AppUrl.baseUrl}${data.exerciseImage}" ?? '',
            height: 330,
            imageType: ImageType.network,
            width: double.infinity,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              AppString.completeSet,
              style: styleForText.copyWith(fontSize: 24),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: data.sets.length,
              itemBuilder: (context, index) {
                log(">>>>>>>>>>> Sets Length: ${data.sets.length}");
                final set = data.sets[index];
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: PrefsHelper.myRole == "trainee"
                          ? ColorController.instance.getButtonColor()
                          : AppColors.secondary,),
                      color:  PrefsHelper.myRole == 'trainee'
                          ? AppColors.traineeNavBArColor
                          : AppColors.primary,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          set.name ?? 'Set ${index + 1}',
                          style: styleForText.copyWith(fontSize: 24),
                        ),
                        const SizedBox(height: 10),
                        // Wrap the horizontal ListView in a SizedBox to constrain its height
                        SizedBox(
                          height: 60,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: set.measurements.length,
                            itemBuilder: (context, index2) {
                              final measurement = set.measurements[index2];
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Column(
                                  children: [
                                    Text(
                                      measurement.name ?? 'Metric',
                                      style: styleForText.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      measurement.value ?? 'N/A',
                                      style: styleForText.copyWith(fontSize: 20),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}