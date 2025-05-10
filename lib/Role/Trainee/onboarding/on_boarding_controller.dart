import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  var selectedGender = 'male'.obs;
  var selectedAge = 18.obs;
  var isCmSelected = true.obs;
  var selectedHeightCm = 170.obs;
  var selectedHeightInches = 67.obs;
  var isKgSelected = true.obs;
  var selectedWeightKg = 70.obs;
  var selectedWeightLbs = 154.obs;

  double get calculateBMI {
    double heightM = isCmSelected.value
        ? selectedHeightCm.value / 100.0
        : selectedHeightInches.value * 0.0254;
    double weightKg = isKgSelected.value
        ? selectedWeightKg.value.toDouble()
        : selectedWeightLbs.value * 0.453592;
    return weightKg / (heightM * heightM);
  }
}
