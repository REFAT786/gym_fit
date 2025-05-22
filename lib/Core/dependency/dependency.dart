import 'package:get/get.dart';
import '../../Role/Trainee/color/controller/color_controller.dart';
import '../../Role/Trainee/home/controller/trainee_home_controller.dart';
import '../../Role/Trainee/nav/controller/trainee_nav_bar_controller.dart';
import '../../Role/Trainee/onboarding/on_boarding_controller.dart';
import '../../Role/Trainer/Nav/controller/nav_controller.dart';
import '../../Role/Trainer/auth/sign_in/controller/sign_in_controller.dart';
import '../../Role/Trainer/home/controller/trainer_home_controller.dart';
import '../../Role/Trainer/management/controller/management_profile_details_controller.dart';
import '../../Role/Trainer/management/controller/trainer_management_controller.dart';
import '../../Role/Trainer/profile/help_center/controller/help_center_controller.dart';
import '../../Role/Trainer/profile/privacy_policy/controller/policy_controller.dart';
import '../../Role/Trainer/profile/profile/controller/profile_controller.dart';
import '../../Role/Trainer/profile/profile/controller/trainer_profile_details_controller.dart';
import '../../Role/Trainer/profile/terms_of_service/controller/terms_of_service_controller.dart';
import '../../Role/Trainer/workout/controller/workout_details_controller.dart';
import '../../Services/api_service.dart';

class DependencyInjection extends Bindings {
  @override
  void dependencies() {

    //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Services
    Get.lazyPut(() => ApiService(), fenix: true);

    //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Repository
    //Get.lazyPut(() => AuthRepository(), fenix: true);

    //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Controllers
    Get.lazyPut(() => SignInController(), fenix: true);
    Get.lazyPut(() => OnBoardingController(), fenix: true);
    Get.lazyPut(() => PolicyController(), fenix: true);
    Get.lazyPut(() => TermsOfServiceController(), fenix: true);
    Get.lazyPut(() => TrainerHomeController(), fenix: true);
    Get.lazyPut(() => TraineeNavBarController(), fenix: true);
    Get.lazyPut(() => TrainerManagementController(), fenix: true);
    Get.lazyPut(() => NavController(), fenix: true);
    Get.lazyPut(() => WorkoutDetailsController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => HelpCenterController(), fenix: true);
    Get.lazyPut(() => TrainerProfileDetailsController(), fenix: true);
    Get.lazyPut(() => ManagementProfileDetailsController(), fenix: true);
    //>>>>>>>>>>>>>>>>>
    Get.lazyPut(() => TraineeHomeController(), fenix: true);
    //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    Get.lazyPut(()=> ColorController(), fenix: true);


  }
}
