import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


import '../../../../Common/widgets/custom_trainer_gradient_background_color.dart';
import '../../../../Helpers/prefs_helper.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Utils/app_string.dart';
import '../../../../Utils/styles.dart';
import '../../color/controller/color_controller.dart';

class WorkoutProgressScreen extends StatefulWidget {
  const WorkoutProgressScreen({super.key});

  @override
  State<WorkoutProgressScreen> createState() => _WorkoutProgressScreenState();
}

class _WorkoutProgressScreenState extends State<WorkoutProgressScreen> {
  bool showAvg = false; // Flag to toggle between the normal and average data

  @override
  Widget build(BuildContext context) {
    return CustomTrainerGradientBackgroundColor(
      child: Scaffold(
        appBar: null, // This explicitly removes the back button
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Center(
                child: Text(
                  AppString.workOutProgress,
                  style: styleForText.copyWith(fontSize: 24, color: ColorController.instance.getTextColor()),
                ),
              ),
              SizedBox(height: 50),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                decoration: BoxDecoration(
                    color: AppColors.traineeNavBArColor,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(AppString.workouts, style: styleForText.copyWith(fontSize: 20)),
                        Text("4", style: styleForText.copyWith(fontSize: 16)),
                      ],
                    ),
                    Column(
                      children: [
                        Text(AppString.time, style: styleForText.copyWith(fontSize: 20)),
                        Text("100", style: styleForText.copyWith(fontSize: 16)),
                      ],
                    ),
                    Column(
                      children: [
                        Text(AppString.weight, style: styleForText.copyWith(fontSize: 20)),
                        Text("100Kg", style: styleForText.copyWith(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),
              Text(AppString.workoutTimesPerWeek, style: styleForText.copyWith(fontSize: 20)),
              SizedBox(height: 50),

              // Custom Bar Chart Container
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  color:  AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(16),
                child: Stack(
                  children: <Widget>[
                    LineChart(
                       mainData(),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Generate Bar Chart Data
  List<LineChartBarData> getBarChartData() {
    final List<double> workoutData = [4, 6, 8, 3, 10, 5, 7]; // Example values
    // final List<String> days = ["Mon", "Tues", "Wed", "Thurs", "Fri", "Sat", "Sun"];
    // final double maxValue = 10; // Max Y Value

    return [
      LineChartBarData(
        spots: List.generate(workoutData.length, (index) {
          return FlSpot(index.toDouble(), workoutData[index]);
        }),
        isCurved: true,
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
        ),
        barWidth: 5,
        isStrokeCapRound: true,
        belowBarData: BarAreaData(show: true, gradient: LinearGradient(colors: [
          AppColors.primary.withOpacity(0.3),
          AppColors.secondary.withOpacity(0.3),
        ])),
      ),
    ];
  }

  // Main chart data (Normal view)
  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(show: true, drawVerticalLine: true, drawHorizontalLine: true),
      titlesData: FlTitlesData(
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false), // Hide right titles
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
              const days = ["Mon", "Tues", "Wed", "Thurs", "Fri", "Sat", "Sun"];
              return Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  days[value.toInt()],
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,  // Set interval to 1 so it shows 0 to 10
            reservedSize: 42,
            getTitlesWidget: (value, meta) {
              // Ensure the Y-axis shows values from 0 to 9
              if (value.toInt() <= 9) {
                return Text(
                  '${value.toInt()}',
                  style: TextStyle(fontSize: 10, color: Colors.white), // Smaller font size
                );
              }
              return Container();  // Return an empty container if the value is above 9
            },
          ),
        ),
      ),
      borderData: FlBorderData(show: true, border: Border.all(color: Colors.white.withOpacity(0.5), width: 0.3),),
      minX: 0,
      maxX: 6,
      minY: 0,
      maxY: 10,
      lineBarsData: getBarChartData(),
    );
  }


}
