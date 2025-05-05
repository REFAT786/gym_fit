import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import '../../../../Common/widgets/custom_common_image.dart';
import '../../../../Common/widgets/custom_search_field.dart';
import '../../../../Common/widgets/custom_trainer_gradient_background_color.dart';
import '../../../../Helpers/prefs_helper.dart';
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

  @override
  Widget build(BuildContext context) {
    return CustomTrainerGradientBackgroundColor(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Row(
                children: [
                  Obx(() => CustomCommonImage(
                    imageSrc: controller.profileImage.value,
                    imageType: ImageType.network,
                    borderRadius: 55,
                    height: 55,
                    width: 55,
                  )),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: 220,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => Text(
                          controller.profileName.value,
                          style: styleForText.copyWith(
                            fontSize: 18,
                          ),
                        )),
                        Text(
                          AppString.readyToWorkout,
                          style: styleForText.copyWith(
                            fontSize: 25,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  CircleAvatar(
                    radius: 27,
                    backgroundColor: AppColors.traineeNavBArColor,
                    child: Obx(() {
                      return IconButton(
                        onPressed: () {
                          Get.to(() => NotificationScreen());
                        },
                        icon: const Icon(
                          Icons.notifications,
                          size: 35,
                        ),
                        color: PrefsHelper.myRole=="trainee"?ColorController.instance.getButtonColor():AppColors.secondary,
                      );
                    },),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Obx(() {
                return CustomSearchField(
                  searchController: controller.searchController,
                  qrPressed: openQRScanner,
                  color: PrefsHelper.myRole=="trainee"?ColorController.instance.getButtonColor():AppColors.secondary,
                );
              },),
              const SizedBox(height: 10),
              Text(
                AppString.createYourOwnWorkout,
                style: styleForText.copyWith(fontSize: 24),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Get.to(() => AddWorkoutScreen());
                },
                child: Obx(() {
                  return Container(
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: ColorController.instance.getButtonColor(),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.add, color: AppColors.white),
                      title: Text(
                        AppString.addWorkout,
                        style: styleForText.copyWith(fontSize: 20),
                      ),
                    ),
                  );
                },)
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppString.workOutPlan,
                      style: styleForText.copyWith(fontSize: 24)),
                  Text(AppString.clearAll,
                      style: styleForText.copyWith(fontSize: 14)),
                ],
              ),
              const SizedBox(height: 10),
              ListView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: 7,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: CustomWorkoutPlanContainer(
                      startWorkoutTap: () {
                        Get.to(() => WorkoutDetailsScreen());
                      },
                    ),
                  );
                },
              ),
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
        Get.snackbar('QR Code Result', result!.code!,
            backgroundColor: AppColors.primary, colorText: AppColors.white);
        qrController?.stopCamera();
      }
    });
  }
}
