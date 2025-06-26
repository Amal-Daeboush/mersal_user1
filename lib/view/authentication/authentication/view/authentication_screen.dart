import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mersal/view/authentication/login/screen/login.dart';
import 'package:mersal/view/authentication/register/view/register_screen.dart';
import '../../../../core/constant/app_sizes.dart';
import '../../widget/custom_container_button/custom_button_google.dart';
import '../../widget/custom_container_button/custom_button_login.dart';
import '../../widget/custom_or.dart';
import '../../widget/logo/custom_logo.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const   EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100.h,
            ),
            CustomLogo(),
            SizedBox(
              height: 70.h,
            ),
             CustomButtonLogin(
              onTap: () => Get.off(const LoginScreen()),
              isLogin: true, textn: false),
            SizedBox(
              height: 10.h,
            ),
             CustomButtonLogin(
                onTap: () => Get.off(const RegisterScreen()),
              isLogin: false, textn: false),
            SizedBox(
              height: 20.h,
            ),
            CustomOR(),
            SizedBox(
              height: 20.h,
            ),
            const CustomButtonGoogle(
              isGoogle: false,
            ),
            SizedBox(
              height: 10.h,
            ),
            const CustomButtonGoogle(
              isGoogle: true,
            ),
          ],
        ),
      ),
    ));
  }
}
