import 'package:flutter/material.dart';

import '../../Helpers/prefs_helper.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/styles.dart';

class CustomHistoryContainer extends StatelessWidget {
  CustomHistoryContainer({super.key});

  final List<Map<String, dynamic>> history = [
    {'value': '12', 'label': 'Reps'},
    {'value': '3', 'label': 'Sets'},
    {'value': '30 Kg', 'label': 'Weights'},
    {'value': '30 Kg', 'label': 'Weight'},
    {'value': '00.59', 'label': 'Rest'},

  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
          color: PrefsHelper.myRole=='trainer'
              ?AppColors.primary:AppColors.traineeNavBArColor,
              borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("01-05-2025 | 12.30 pm", style: styleForText.copyWith(fontSize: 20)),
          SizedBox(
            height: 90,
            width: double.infinity,
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: history.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var detail = history[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        detail['value'],
                        style: styleForText.copyWith(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Text(
                        detail['label'],
                        style: styleForText.copyWith(fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                    ],
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
