import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constant/app_colors.dart';
import '../../verfication/view/verfication_phon_screen.dart';

class LoginPhoneController extends GetxController {
  bool isValidatePhone = false;
  final GlobalKey<FormState> keyFormphone = GlobalKey<FormState>();

  TextEditingController phoneController = TextEditingController();
  void checkNumberValidate(String value) {
    isValidatePhone = value.length == 11 && value.startsWith('01');

    update();
  }

 String? validator(value) {
    if (value == null || value.isEmpty) {
      return 'ادخل رقم الهاتف';
    }
    if (!RegExp(r'^01\d{9}$').hasMatch(value)) {
      return 'يجب ان يبدأالرقم 01 ويكون مؤاف من 11 رقم';
    }
    return null;
  }

 /*  void loginWithPhone() {
    if (keyFormphone.currentState?.validate() ?? false) {
      Get.off(VerificationPhonScreen());
    } else {
      Get.snackbar(
        'Error',
        'Please correct the errors in the form',
        backgroundColor: AppColors.whiteColor2,
      );
    }
  } */
}
