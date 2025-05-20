import 'dart:developer';

import 'package:get/get.dart';
import '../../../../../Model/trainee_detail_model.dart';
import '../../../../../Repository/user_repository.dart';

class ManagementProfileDetailsController extends GetxController {
  final UserRepository userRepository = UserRepository();

  late String managementId;

  var isLoading = false.obs;
  var managementDetail = Rxn<TraineeDetailModel>();
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    managementId = Get.arguments['id'] ?? '';
    log(">>>>>>>>>>>>>>>>>>>>>>>>> Trainee Id : $managementId");
    fetchManagementDetail();
  }

  Future<void> fetchManagementDetail() async {
    if (managementId.isEmpty) {
      errorMessage.value = 'Trainee ID not provided';
      return;
    }
    isLoading(true);
    var response = await userRepository.getTraineeProfileById(managementId, showMessage: true);

    if (response?.statusCode == 200 && response?.data != null) {
      try {
        managementDetail.value = TraineeDetailModel.fromJson(response!.data['attributes']);
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
