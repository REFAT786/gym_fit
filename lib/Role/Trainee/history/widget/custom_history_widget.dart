import 'package:flutter/material.dart';
import 'package:gym_fit/Utils/app_string.dart';
import '../../../../Model/history_model.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Utils/app_url.dart';
import '../../../../Utils/styles.dart';
import '../../../../Common/widgets/custom_common_image.dart';

class CustomHistoryWidget extends StatelessWidget {
  final HistoryAttribute history;
  final bool isButton;
  final VoidCallback? startWorkoutTap;

  const CustomHistoryWidget({
    Key? key,
    required this.history,
    this.startWorkoutTap,
    this.isButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.traineeNavBArColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  history.exercise.name.isNotEmpty
                      ? history.exercise.name
                      : AppString.unnamedExercise,
                  style: styleForText.copyWith(fontSize: 20),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                history.exercise.stations.isNotEmpty
                    ? "${AppString.station} ${history.exercise.stations[0].stationNumber}"
                    : AppString.noStation,
                style: styleForText.copyWith(fontSize: 20),
              ),
            ],
          ),
          Divider(color: AppColors.white),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomCommonImage(
                imageSrc: "${AppUrl.baseUrl}${history.exercise.exerciseImage}",
                imageType: ImageType.network,
                height: 170,
                width: 125,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppString.trainingGoals,
                      style: styleForText.copyWith(fontSize: 20),
                    ),
                    SizedBox(
                      height: 75,
                      child: history.exercise.muscleGroup.isEmpty
                          ?  Text(AppString.noMuscleGroups)
                          : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: history.exercise.muscleGroup.length,
                        itemBuilder: (context, index) {
                          final mg = history.exercise.muscleGroup[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Column(
                              children: [
                                Text(
                                  mg.mgName.isNotEmpty ? mg.mgName : 'Unknown',
                                  style: styleForText.copyWith(fontSize: 12),
                                ),
                                const SizedBox(height: 3),
                                CustomCommonImage(
                                  imageSrc: mg.mgImage.isNotEmpty
                                      ? "${AppUrl.baseUrl}${mg.mgImage}"
                                      : 'https://via.placeholder.com/50',
                                  imageType: ImageType.network,
                                  height: 50,
                                  width: 50,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      AppString.trainingType,
                      style: styleForText.copyWith(fontSize: 20),
                    ),
                    SizedBox(
                      height: 40,
                      child: history.exercise.workoutType.isEmpty
                          ?  Text(AppString.noWorkoutTypes)
                          : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: history.exercise.workoutType.length,
                        itemBuilder: (context, index) {
                          final wt = history.exercise.workoutType[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                CustomCommonImage(
                                  imageSrc: wt.image.isNotEmpty
                                      ? "${AppUrl.baseUrl}${wt.image}"
                                      : 'https://via.placeholder.com/44',
                                  imageType: ImageType.network,
                                  height: 44,
                                  width: 44,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  wt.name.isNotEmpty ? wt.name : 'Unknown',
                                  style: styleForText.copyWith(fontSize: 12),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
          if (isButton)
            InkWell(
              onTap: startWorkoutTap,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.blue,
                ),
                child: Text(
                  'Start Workout',
                  style: styleForText.copyWith(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
