import 'dart:developer';

import 'package:get/get.dart';
import '../../../../../Model/trainee_detail_model.dart';
import '../../../../../Repository/user_repository.dart';

class TrainerProfileDetailsController extends GetxController {
  final UserRepository userRepository = UserRepository();

  late String traineeId;

  var isLoading = false.obs;
  var traineeDetail = Rxn<TraineeDetailModel>();
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    traineeId = Get.arguments['id'] ?? '';
    log(">>>>>>>>>>>>>>>>>>>>>>>>> Trainee Id : $traineeId");
    fetchTraineeDetail();
  }

  Future<void> fetchTraineeDetail() async {
    if (traineeId.isEmpty) {
      errorMessage.value = 'Trainee ID not provided';
      return;
    }
    isLoading(true);
    var response = await userRepository.getTraineeProfileById(traineeId, showMessage: true);

    if (response?.statusCode == 200 && response?.data != null) {
      try {
        traineeDetail.value = TraineeDetailModel.fromJson(response!.data['attributes']);
        errorMessage.value = '';
      } catch (e) {
        errorMessage.value = 'Failed to parse trainee data';
      }
    } else {
      errorMessage.value = response?.message ?? 'Failed to load trainee data';
    }
    isLoading(false);
  }
}
