import 'dart:developer';

import 'package:get/get.dart';
import '../../../../../Model/trainee_detail_model.dart';
import '../../../../../Repository/user_repository.dart';

class TrainerProfileDetailsController extends GetxController {

  static TrainerProfileDetailsController get instance => Get.find<TrainerProfileDetailsController>();
  final UserRepository userRepository = UserRepository();



  late String traineeId;

  var isLoading = false.obs;
  var traineeDetail = Rxn<TraineeDetailModel>();
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    traineeId = Get.arguments['id'] ?? '';
    log("Trainee Id : $traineeId");
    fetchTraineeDetail();
  }

  Future<void> fetchTraineeDetail() async {
    if (traineeId.isEmpty) {
      errorMessage.value = 'Trainee ID not provided';
      return;
    }
    isLoading.value = true;
    final response = await userRepository.getTraineeProfileById(traineeId, showMessage: true);

    if (response?.statusCode == 200) {
      try {
        traineeDetail.value = TraineeDetailModel.fromJson(response!.data['attributes']);
        errorMessage.value = '';
        log("Trainee Detail fetched successfully");
      } catch (e, s) {
        errorMessage.value = 'Failed to parse trainee data';
        log('Parse error: $e');
        log('error: $s');
      }
    } else {
      errorMessage.value = response?.message ?? 'Failed to load trainee data';
      log('Error: ${response?.message}');
    }
    isLoading.value = false;
  }


  Future<void> changeStatusEnable() async {
    isLoading.value = true;

    final response = await userRepository.getChangeEnableStatusId(traineeId, showMessage: true);

    if (response?.statusCode == 200) {
      try {
        errorMessage.value = '';
        log("Status change successfully === Enable === true");
        // Reload the trainee detail to get updated data
        await fetchTraineeDetail();
      } catch (e, s) {
        errorMessage.value = 'Failed to parse trainee Status change';
        log('Parse error: $e');
        log('error: $s');
        isLoading.value = false;
      }
    } else {
      errorMessage.value = response?.message ?? 'Failed to load trainee Status change';
      log('Error: ${response?.message}');
      isLoading.value = false;
    }
  }

  Future<void> changeStatusDisable() async {
    isLoading.value = true;

    final response = await userRepository.getChangeDisableStatusId(traineeId, showMessage: true);

    if (response?.statusCode == 200) {
      try {
        errorMessage.value = '';
        log("Status change successfully === Disable === false");
        // Reload the trainee detail to get updated data
        await fetchTraineeDetail();
      } catch (e, s) {
        errorMessage.value = 'Failed to parse trainee Status change';
        log('Parse error: $e');
        log('error: $s');
        isLoading.value = false;
      }
    } else {
      errorMessage.value = response?.message ?? 'Failed to load trainee Status change';
      log('Error: ${response?.message}');
      isLoading.value = false;
    }
  }

}