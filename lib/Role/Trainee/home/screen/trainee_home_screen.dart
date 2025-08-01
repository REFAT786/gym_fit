import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gym_fit/Common/widgets/custom_button.dart';
import 'package:gym_fit/Core/routes/routes.dart';
import 'package:gym_fit/Core/routes/routes_name.dart';
import 'package:gym_fit/Helpers/other_helper.dart';
import 'package:gym_fit/Role/Trainer/auth/sign_in/controller/sign_in_controller.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import '../../../../Common/widgets/custom_common_image.dart';
import '../../../../Common/widgets/custom_search_field.dart';
import '../../../../Common/widgets/custom_trainer_gradient_background_color.dart';
import '../../../../Helpers/date_time_formator.dart';
import '../../../../Helpers/prefs_helper.dart';
import '../../../../Utils/app_url.dart';
import '../../../Trainer/workout/screen/add_workout_screen.dart';
import '../../../Trainer/workout/screen/workout_details_screen.dart';
import '../../color/controller/color_controller.dart';
import '../widget/custom_workout_plan_container.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Utils/app_string.dart';
import '../../../../Utils/styles.dart';
import '../../../Trainer/notification/screen/notification_screen.dart';
import '../controller/trainee_home_controller.dart';

class TraineeHomeScreen extends StatefulWidget {
  const TraineeHomeScreen({super.key});

  @override
  State<TraineeHomeScreen> createState() => _TraineeHomeScreenState();
}

class _TraineeHomeScreenState extends State<TraineeHomeScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? qrController;

  final TraineeHomeController controller = Get.put(TraineeHomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfileData();
  }

  getProfileData(){

    controller.profileImage.value = PrefsHelper.myImage;
    log("image====${controller.profileImage.value}");

  }


  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      qrController?.pauseCamera();
    }
    qrController?.resumeCamera();
  }

  @override
  void dispose() {
    qrController?.dispose();
    super.dispose();
  }

  Future<void> _showDatePickerAndNavigate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.red,
              onPrimary: Colors.white,
              surface: AppColors.traineeNavBArColor,
              onSurface: Colors.white,
            ),
            dialogTheme: DialogThemeData(backgroundColor: Colors.black),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      // Format pickedDate as yyyy-MM-dd
      final selectedDateStr = DateFormat('yyyy-MM-dd').format(pickedDate);
      Get.toNamed(
        RoutesName.historyScreen,
        arguments: {'date': selectedDateStr},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    log(">>>>>>>>>>>>> ================ ${SignInController.instance.enabled.value}");
    log(">>>>>>>>>>>>> ================ ${SignInController.instance.enabledqq.value}");
    return CustomTrainerGradientBackgroundColor(
      child: Scaffold(
        backgroundColor: Colors.transparent,

        floatingActionButton: PrefsHelper.enabled == true? InkWell(
          onTap: (){
            Get.toNamed(RoutesName.addWorkout);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 0, right: 90),
            child: Container(
              width: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: ColorController.instance.getButtonColor(),
              ),
              child: ListTile(
                leading: Icon(
                  Icons.add,
                  color: AppColors.white,
                ),
                title: Text(
                  AppString.addWorkout,
                  style: styleForText.copyWith(
                    fontSize: 16,
                    color:
                    PrefsHelper.myRole == 'trainee'
                        ? ColorController.instance.getTextColor()
                        : AppColors.white,
                  ),
                ),
              ),
            ),
          ),
        ): SizedBox(),

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Row(
                children: [
                  Obx(
                    () => CustomCommonImage(
                      imageSrc: controller.profileImage.value,
                      imageType: ImageType.network,
                      borderRadius: 55,
                      height: 55,
                      width: 55,

                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: 220,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Text(
                            controller.profileName.value,
                            style: styleForText.copyWith(
                              fontSize: 18,
                              color:
                                  PrefsHelper.myRole == 'trainee'
                                      ? ColorController.instance.getTextColor()
                                      : AppColors.white,
                            ),
                          ),
                        ),
                        Text(
                          AppString.readyToWorkout,
                          style: styleForText.copyWith(
                            fontSize: 25,
                            color:
                                PrefsHelper.myRole == 'trainee'
                                    ? ColorController.instance.getTextColor()
                                    : AppColors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  // const Spacer(),
                  // CircleAvatar(
                  //   radius: 27,
                  //   backgroundColor: AppColors.traineeNavBArColor,
                  //   child: Obx(() {
                  //     return IconButton(
                  //       onPressed: () {
                  //         Get.to(() => NotificationScreen());
                  //       },
                  //       icon: const Icon(
                  //         Icons.notifications,
                  //         size: 35,
                  //       ),
                  //       color: PrefsHelper.myRole=="trainee"?ColorController.instance.getButtonColor():AppColors.secondary,
                  //     );
                  //   },),
                  // )
                ],
              ),
              const SizedBox(height: 20),
              Obx(() {
                return CustomSearchField(
                  searchController: controller.searchController,
                  qrPressed: openQRScanner,
                  onChanged: (value){
                    controller.fetchWorkoutPlan(query: value);
                  },
                  color:
                      PrefsHelper.myRole == "trainee"
                          ? ColorController.instance.getButtonColor()
                          : AppColors.secondary,
                );
              }),
              const SizedBox(height: 10),
              Text(
                AppString.createYourOwnWorkout,
                style: styleForText.copyWith(
                  fontSize: 24,
                  color:
                      PrefsHelper.myRole == 'trainee'
                          ? ColorController.instance.getTextColor()
                          : AppColors.white,
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () async {
                  await _showDatePickerAndNavigate();
                },
                child: Obx(() {
                  return Container(
                    width: 217,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: ColorController.instance.getButtonColor(),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.calendar_month_outlined,
                        color: AppColors.white,
                      ),
                      title: Text(
                        AppString.viewCalender,
                        style: styleForText.copyWith(
                          fontSize: 20,
                          color:
                              PrefsHelper.myRole == 'trainee'
                                  ? ColorController.instance.getTextColor()
                                  : AppColors.white,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  AppString.workOutPlan,
                  style: styleForText.copyWith(
                    fontSize: 24,
                    color:
                        PrefsHelper.myRole == 'trainee'
                            ? ColorController.instance.getTextColor()
                            : AppColors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.errorMessage.isNotEmpty) {
                  return Text(
                    controller.errorMessage.value,
                    style: const TextStyle(color: Colors.red),
                  );
                }

                if (controller.workoutList.isEmpty) {
                  return Text(
                    AppString.noWorkoutsAvailable,
                    style: styleForText.copyWith(
                      color: Colors.white,
                      fontSize: 14.sp,
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: controller.workoutList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final workout = controller.workoutList[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: CustomWorkoutPlanContainer(
                        workout: workout,
                        startWorkoutTap: () {
                          Get.to(
                            () => WorkoutDetailsScreen(),
                            arguments: {'id': workout.id},
                          );
                        },
                      ),
                    );
                  },
                );
              }),

              ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
            ],
          ),
        ),
      ),
    );
  }

  void openQRScanner() {
    Get.dialog(
      Dialog(
        child: SizedBox(
          height: 300,
          width: 300,
          child: QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: AppColors.traineePrimaryColor,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: 250,
            ),
          ),
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      qrController = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      if (result != null && result!.code != null) {
        Get.back();
        Get.snackbar(
          'QR Code Result',
          result!.code!,
          backgroundColor: AppColors.primary,
          colorText: AppColors.white,
        );
        qrController?.stopCamera();
      }
    });
  }
}
