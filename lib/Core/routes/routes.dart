import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:gym_fit/Core/routes/routes_name.dart';
import '../../Role/Trainee/color/screen/color_screen.dart';
import '../../Role/Trainee/history/screen/history_screen.dart';
import '../../Role/Trainee/home/screen/trainee_home_screen.dart';
import '../../Role/Trainee/nav/screen/trainee_nav_bar_screen.dart';
import '../../Role/Trainee/onboarding/screen/on_boarding_screen.dart';
import '../../Role/Trainee/trainee_complete_successfully/screen/trainee_complete_successfully_screen.dart';
import '../../Role/Trainee/workout_plan/screen/rest_screen.dart';
import '../../Role/Trainee/workout_plan/screen/specific_workout_plan_screen.dart';
import '../../Role/Trainee/workout_plan/screen/training_page_one.dart';
import '../../Role/Trainee/workout_plan/screen/workout_plan_detail_screen.dart';
import '../../Role/Trainee/workout_plan/screen/workout_plan_screen.dart';
import '../../Role/Trainee/workout_progress/screen/workout_progress_screen.dart';
import '../../Role/Trainer/auth/sign_in/screen/sign_in_screen.dart';
import '../../Role/Trainer/home/screen/trainer_home_screen.dart';
import '../../Role/Trainer/management/screen/management_profile_details_screen.dart';
import '../../Role/Trainer/management/screen/trainer_management_screen.dart';
import '../../Role/Trainer/nav/screen/nav_bar_screen.dart';
import '../../Role/Trainer/notification/screen/notification_screen.dart';
import '../../Role/Trainer/profile/change_password/screen/change_password_screen.dart';
import '../../Role/Trainer/profile/edir_profile/screen/edit_profile_screen.dart';
import '../../Role/Trainer/profile/help_center/screen/help_center_screen.dart';
import '../../Role/Trainer/profile/language/screen/language_screen.dart';
import '../../Role/Trainer/profile/privacy_policy/screen/privacy_policy_screen.dart';
import '../../Role/Trainer/profile/profile/screen/trainer_profile_details_screen.dart';
import '../../Role/Trainer/profile/profile/screen/profile_screen.dart';
import '../../Role/Trainer/profile/terms_of_service/screen/terms_of_service_screen.dart';
import '../../Role/Trainer/workout/screen/add_workout_screen.dart';
import '../../Role/Trainer/workout/screen/workout_details_screen.dart';

class AppRoutes {
  static appRoutes() =>
      [
        GetPage(
          name: RoutesName.getNavBarScreen(),
          page: () => NavBarScreen(),
        ),
        GetPage(
          name: RoutesName.getSignInScreen(),
          page: () => SignInScreen(),
        ),GetPage(
          name: RoutesName.getTrainerHomeScreen(),
          page: () => TrainerHomeScreen(),
        ),GetPage(
          name: RoutesName.getTrainerProfileDetailScreen(),
          page: () => TrainerProfileDetailsScreen(),
        ),GetPage(
          name: RoutesName.getProfileScreen(),
          page: () => ProfileScreen(),
        ),GetPage(
          name: RoutesName.getTrainerManagementScreen(),
          page: () => TrainerManagementScreen(),
        ),GetPage(
          name: RoutesName.getTrainerManagementDetailScreen(),
          page: () => ManagementProfileDetailsScreen(),
        ),GetPage(
          name: RoutesName.getWorkoutDetailsScreen(),
          page: () => WorkoutDetailsScreen(),
        ),GetPage(
          name: RoutesName.getAddWorkoutScreen(),
          page: () => AddWorkoutScreen(),
        ),GetPage(
          name: RoutesName.getEditProfileScreen(),
          page: () => EditProfileScreen(),
        ),GetPage(
          name: RoutesName.getHelpCenterScreen(),
          page: () => HelpCenterScreen(),
        ),GetPage(
          name: RoutesName.getPrivacyPolicyScreen(),
          page: () => PrivacyPolicyScreen(),
        ),GetPage(
          name: RoutesName.getTermsOfServiceScreen(),
          page: () => TermsOfServiceScreen(),
        ),GetPage(
          name: RoutesName.getLanguageScreen(),
          page: () => LanguageScreen()
        ),GetPage(
          name: RoutesName.getChangePasswordScreen(),
          page: () => ChangePasswordScreen()
        ),GetPage(
          name: RoutesName.getNotificationScreen(),
          page: () => NotificationScreen()
        ),GetPage(
          name: RoutesName.getOnBoardingScreen(),
          page: () => OnBoardingScreen()
        ),GetPage(
          name: RoutesName.getTraineeNavBarScreen(),
          page: () => TraineeNavBarScreen()
        ),GetPage(
          name: RoutesName.getTrainingPageOneScreen(),
          page: () => TrainingPageOne()
        ),GetPage(
          name: RoutesName.getRestScreen(),
          page: () => RestScreen()
        ),GetPage(
          name: RoutesName.getHistoryScreen(),
          page: () => HistoryScreen()
        ),

        //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        GetPage(
            name: RoutesName.getTraineeHomeScreen(),
            page: () => TraineeHomeScreen()
        ), GetPage(
            name: RoutesName.getWorkoutProgressScreen(),
            page: () => WorkoutProgressScreen()
        ),GetPage(
            name: RoutesName.getColorScreen(),
            page: () => ColorScreen()
        ),GetPage(
            name: RoutesName.getTraineeCompleteSuccessfullyScreen(),
            page: () => TraineeCompleteSuccessfullyScreen()
        ),GetPage(
            name: RoutesName.getWorkoutPlanScreen(),
            page: () => WorkoutPlanScreen()
        ),GetPage(
            name: RoutesName.getSpecificWorkoutPlanScreen(),
            page: () => SpecificWorkoutPlanScreen()
        ),GetPage(
            name: RoutesName.getWorkoutPlanDetailScreen(),
            page: () => WorkoutPlanDetailScreen()
        ),

      ];
}
