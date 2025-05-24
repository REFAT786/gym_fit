// history_controller.dart
import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../Model/history_model.dart';
import '../../../../Repository/user_repository.dart';

class HistoryController extends GetxController {
  static HistoryController get instance => Get.find();

  final UserRepository userRepository = UserRepository();

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxList<HistoryAttribute> historyList = <HistoryAttribute>[].obs;

  late String date;

  @override
  void onInit() {
    super.onInit();
    date = (Get.arguments != null &&
        Get.arguments is Map &&
        Get.arguments['date'] != null)
        ? Get.arguments['date']
        : DateFormat('yyyy-MM-dd').format(DateTime.now());
    log(">>>>>>>>>>>>>>>>>>>>>>>>>>>> date : $date");
    fetchHistory();
  }

  Future<void> fetchHistory() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      log("Starting fetchHistory for date: $date");

      final DateTime parsedDate = DateTime.parse(date);
      final response = await userRepository.getHistory(parsedDate, showMessage: true);
      log("Response received: success=${response?.success}, statusCode=${response?.statusCode}, data=${response?.data}");

      if (response?.statusCode == 200 ) {
        final jsonData = response!.data;
        log("jsonData type: ${jsonData.runtimeType}");
        if (jsonData is Map<String, dynamic>) {
          final historyModel = HistoryData.fromJson(jsonData);
          log("Parsed HistoryModel: type=${historyModel.type}, attributes count=${historyModel.attributes.length}");
          historyList.value = historyModel.attributes;
          log("Loaded workouts count: ${historyList.length}");
          if (historyList.isEmpty) {
            log("Warning: historyList is empty despite successful parsing");
          } else {
            log("History items: ${historyList.map((h) => h.exercise.name).toList()}");
          }
        } else {
          errorMessage.value =
          "Invalid data structure from API: expected Map<String, dynamic>, got ${jsonData.runtimeType}";
          historyList.clear();
          log("Error: $errorMessage.value");
        }
      } else {
        errorMessage.value =
            response?.message ?? "Error fetching workout history.";
        historyList.clear();
        log("Error: $errorMessage.value, statusCode=${response?.statusCode}");
      }
    } catch (e, st) {
      errorMessage.value = "Unexpected error: $e";
      historyList.clear();
      log("Exception in fetchHistory: $e\n$st");
    } finally {
      isLoading.value = false;
      log("fetchHistory completed, isLoading=${isLoading.value}");
    }
  }
}