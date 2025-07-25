
import 'package:get/get.dart';
import 'package:mersal/view/authentication/login/screen/login.dart';
import 'package:mersal/view/authentication/onboarding/screen/on_boarding.dart';
import 'core/constant/app_routes.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(name: AppRoutes.onboarding, page: () => const OnboardingScreen(),),
  GetPage(name: AppRoutes.login, page: () => const LoginScreen(),),
];
