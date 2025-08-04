import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mersal/core/constant/const_data.dart';
import 'package:mersal/view/authentication/verfication/view/verfication_phon_screen.dart';
import 'package:mersal/view/botttom%20nav%20bar/view/bottom_nav_bar_screen.dart';

import '../../authentication/authentication/view/authentication_screen.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController controllerAnimation;

  late Animation<double> imageScaleAnimation;
  late Animation<double> imageFadeAnimation;

  late Animation<double> textScaleAnimation;
  late Animation<double> textFadeAnimation;

  @override
  void onInit() {
    super.onInit();

    controllerAnimation = AnimationController(
      duration: const Duration(seconds: 4), // ⏱️ أطول من السابق
      vsync: this,
    );

    // الصورة: تبدأ من 0 ثانية وتنتهي عند 3 ثواني
    imageFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controllerAnimation,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInOut), // ✨ ظهور بطيء
      ),
    );

    imageScaleAnimation = Tween<double>(begin: 0.05, end: 1.0).animate(
      CurvedAnimation(
        parent: controllerAnimation,
        curve: const Interval(
          0.0,
          0.5,
          curve: Curves.easeInExpo,
        ), // تباطؤ قوي بالنهاية
      ),
    );

    // النص: يبدأ بعد انتهاء الصورة، من 3 إلى 6 ثوانٍ
    textFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controllerAnimation,
        curve: const Interval(0.6, 1.0, curve: Curves.easeInOut), // ✨ ظهور ناعم
      ),
    );

    textScaleAnimation = Tween<double>(begin: 0.05, end: 1.0).animate(
      CurvedAnimation(
        parent: controllerAnimation,
        curve: const Interval(
          0.6,
          1.0,
          curve: Curves.easeInExpo,
        ), // ⬅️ تكبير بطيء
      ),
    );

    controllerAnimation.forward();

    controllerAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(seconds: 2), () {
          var token = ConstData.token;
          var address = ConstData.addressUser;
          var name = ConstData.nameUser;
          var phone = ConstData.phoneUser;
          var userid = ConstData.userid;
          var user = ConstData.user;
          print(token);
          print('----------------------$address------------------');
          print('----------------------$user------------------');
          print('----------------------$userid------------------');
          print('----------------------$name------------------');
          print('----------------------$phone------------------');
          if (token == '') {
            Get.off(AuthenticationScreen());
          } else if (token != '' && ConstData.otp == '0') {
            Get.off(
              VerificationPhonScreen(
                isForgetpass: false,
                email: ConstData.user!.user.email!,
              ),
            );
          } else {
            Get.off(BottomNavBarScreen());
          }
        });
      }
    });
  }

  @override
  void dispose() {
    controllerAnimation.dispose();
    super.dispose();
  }
}
