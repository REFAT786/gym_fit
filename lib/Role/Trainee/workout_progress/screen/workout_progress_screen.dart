import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Common/widgets/custom_trainer_gradient_background_color.dart';
import '../../../../Model/workout_progress.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Utils/app_string.dart';
import '../../../../Utils/styles.dart';
import '../../color/controller/color_controller.dart';
import '../controller/workout_progress_controller.dart';

class WorkoutProgressScreen extends StatelessWidget {
  WorkoutProgressScreen({super.key});

  final WorkoutProgressController controller = Get.put(WorkoutProgressController());

  final List<String> days = ["Mon", "Tues", "Wed", "Thurs", "Fri", "Sat", "Sun"];

  @override
  Widget build(BuildContext context) {
    controller.fetchProgress();

    return CustomTrainerGradientBackgroundColor(
      child: Scaffold(
        appBar: null,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Center(
                child: Obx(() {
                  return Text(
                    AppString.workOutProgress,
                    style: styleForText.copyWith(
                      fontSize: 24,
                      color: ColorController.instance.getTextColor(),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 50),

              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.errorMessage.isNotEmpty) {
                  return Center(
                    child: Text(
                      controller.errorMessage.value,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  );
                }

                final workout = controller.workoutProgress.value;

                if (workout == null) {
                  return const Center(child: Text("No workout data available"));
                }

                final totalWorkout = workout.data.attributes.totalWorkout;
                final result = workout.data.attributes.result;

                // Map days to counts
                final workoutData = List<double>.generate(days.length, (index) {
                  final day = days[index];
                  final match = result.firstWhere(
                        (element) => element.day.toLowerCase().startsWith(day.toLowerCase().substring(0, 3)),
                    orElse: () => WorkoutProgressResult(day: day, count: 0),
                  );
                  return match.count.toDouble();
                });

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.traineeNavBArColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Workouts", style: styleForText.copyWith(fontSize: 20)),
                          Text("$totalWorkout", style: styleForText.copyWith(fontSize: 16)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(AppString.workoutTimesPerWeek, style: styleForText.copyWith(fontSize: 20)),
                    const SizedBox(height: 10),

                    Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: LineChart(
                        mainData(workoutData),
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  List<LineChartBarData> getBarChartData(List<double> workoutData) {
    return [
      LineChartBarData(
        spots: List.generate(workoutData.length, (index) {
          return FlSpot(index.toDouble(), workoutData[index]);
        }),
        isCurved: true,
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
        ),
        barWidth: 5,
        isStrokeCapRound: true,
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(colors: [
            AppColors.primary.withOpacity(0.3),
            AppColors.secondary.withOpacity(0.3),
          ]),
        ),
      ),
    ];
  }

  LineChartData mainData(List<double> workoutData) {
    return LineChartData(
      gridData: const FlGridData(show: true, drawVerticalLine: true, drawHorizontalLine: true),
      titlesData: FlTitlesData(
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: (value, meta) {
              if (value.toInt() < 0 || value.toInt() > 6) return Container();
              return Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  days[value.toInt()],
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                ),
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            reservedSize: 42,
            getTitlesWidget: (value, meta) {
              if (value.toInt() <= 9) {
                return Text(
                  '${value.toInt()}',
                  style: const TextStyle(fontSize: 10, color: Colors.white),
                );
              }
              return Container();
            },
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.white.withOpacity(0.5), width: 0.3),
      ),
      minX: 0,
      maxX: 6,
      minY: 0,
      maxY: 10,
      lineBarsData: getBarChartData(workoutData),
    );
  }
}
