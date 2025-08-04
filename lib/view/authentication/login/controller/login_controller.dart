import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mersal/core/class/status_request.dart';
import 'package:mersal/core/constant/api_links.dart';
import 'package:mersal/core/constant/const_data.dart';
import 'package:mersal/core/sevices/key_shsred_perfences.dart';
import 'package:mersal/core/sevices/sevices.dart';
import 'package:mersal/model/api_remote.dart';

import 'package:mersal/view/address/view/address.dart';
import 'package:mersal/view/authentication/verfication/view/verfication_phon_screen.dart';
import 'package:mersal/view/botttom%20nav%20bar/view/bottom_nav_bar_screen.dart';
import 'package:mersal/view/notifications%20screen/controller/notification_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../chat screen/controller/global_chat_pusher_controller.dart';
import '../../../favourite/controller/favourite_controller.dart';

class LoginController extends GetxController {
  bool obscureText = false;
  changeObscureText() {
    obscureText = !obscureText;
    update();
  }

  StatusRequest statusRequest = StatusRequest.loading;
  bool isLoading = false;
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> keyFormphone = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  Login() async {
    if (keyForm.currentState!.validate()) {
      isLoading = true;
      statusRequest = StatusRequest.loading;
      update();

      var response = await ApiRemote().loginModel({
        'email': emailController.text,
        'password': passwordController.text,
      });

      print("Response: $response"); // ✅ طباعة الاستجابة للتحقق منها

      if (response == StatusRequest.success) {
        statusRequest = StatusRequest.success;
        isLoading = false;
        if (ConstData.user!.user.type != '0') {
          Get.snackbar(
            'خطأ',
            'الحساب المدخل ليس حساب مستخدم قد يكون حساب سائق او تاجر حاول بحساب اخر',
          );
        } else {
          Get.snackbar('نجاح', 'تم تسجيل الدخول');
          if (ConstData.user!.user.otp == '1') {
           Get.put(GlobalPusherController());
  Get.put(FavouriteController());

            var controller = Get.put(NotificationController());
            controller.loadNotifications(loadUnreadAlso: true);
            Get.off(AddressScreen(isfromHome: false));
          } else {
            Get.off(
              VerificationPhonScreen(
                email: emailController.text,
                isForgetpass: false,
              ),
            );
          }
        }
      } else if (response is String) {
        // ✅ عرض رسالة الخطأ بشكل مناسب
        Get.snackbar('Error', response);
        isLoading = false;
        statusRequest = StatusRequest.failure;
      } else {
        Get.snackbar('خطأ', 'حدث خطأ');
        isLoading = false;
        statusRequest = StatusRequest.failure;
      }

      emailController.clear();
      passwordController.clear();
      update();
    } else {
      Get.snackbar('خطأ', 'من فضلك املىء الحقول');
      emailController.clear();
      passwordController.clear();
    }
  }

  Future<void> loginGoogle() async {
    try {
      // 1. افتح رابط Google OAuth
      final Uri googleUri = Uri.parse(ApiLinks.google);
      if (await canLaunchUrl(googleUri)) {
        await launchUrl(googleUri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch ${ApiLinks.google}';
      }

      // 2. بعد تسجيل الدخول وإعادة التوجيه، يجب أن تستقبل التوكن من الخادم
      // مثال لاستدعاء API لاسترجاع التوكن
      final response = await http.get(Uri.parse(ApiLinks.google));

      if (response.statusCode == 200) {
        final decodeResponse = jsonDecode(response.body);
        final token = decodeResponse['access_token'];

        // 3. حفظ التوكن محليًا
        await MyServices.saveValue(SharedPreferencesKey.tokenkey, token);
        await MyServices().setConstToken();

        // 4. الانتقال إلى الشاشة التالية
        Get.off(BottomNavBarScreen()); // أو الشاشة التي تريدها
      } else {
        throw 'Failed to login with Google';
      }
    } catch (e) {
      print('Google login error: $e');
      Get.snackbar('Error', 'Google login failed');
    }
  }
}
