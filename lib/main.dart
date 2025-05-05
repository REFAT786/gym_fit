import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'Core/dependency/dependency.dart';
import 'Core/routes/routes.dart';
import 'Core/routes/routes_name.dart';
import 'Helpers/prefs_helper.dart';
import 'Utils/app_colors.dart';
import 'Utils/app_string.dart';
import 'Utils/app_translations.dart';

void main() async{
  await action();
  runApp(const MyApp());
}

//=================================================================action
action() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection dI = DependencyInjection();
  dI.dependencies();

  await PrefsHelper.getAllPrefData();
  // if (PrefsHelper.token.isNotEmpty) {
  //   SocketServices.connectToSocket();+
  // }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(440, 960),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: Get.key,
        translations: AppTranslations(),
        defaultTransition: Transition.noTransition,
        locale:  Locale(PrefsHelper.localizationLanguageCode, PrefsHelper.localizationCountryCode),
        fallbackLocale: Locale('en', 'US'),

        title: AppString.appTitleText,
        theme: ThemeData(
          primaryColor: Color(0xff056aa6),
          scaffoldBackgroundColor: Colors.transparent, // Important for using the gradient
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
        ),
        // themeMode: themeController.themeMode.value,  // Set the theme mode
        // theme: ThemeData.light(),  // Light Theme
        // darkTheme: ThemeData.dark(), // Dark Theme
        initialRoute: RoutesName.getSignInScreen(),
        getPages: AppRoutes.appRoutes(),
      ),
    );
  }
}
