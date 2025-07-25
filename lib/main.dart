import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mersal/routes.dart';
import 'package:mersal/theme/app_themes.dart';
import 'package:mersal/view/restaurant%20screen/view/restaurants_screen.dart';
import 'package:mersal/view/splash%20screen/view/splash_screen.dart';
import 'bindings/initial_bindings.dart';
import 'core/sevices/sevices.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await MyServices();
  await MyServices().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return GetMaterialApp(
          locale: const Locale('ar'),
          initialBinding: InitialBindings(),
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          getPages: routes,
          home: SplashScreen(),
        );
      },
    );
  }
}
