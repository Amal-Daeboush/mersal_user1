
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mersal/core/class/status_request.dart';
import 'package:mersal/core/constant/const_data.dart';

import 'package:mersal/model/api_remote.dart';

import 'package:mersal/view/address/view/address.dart';
import 'package:mersal/view/authentication/verfication/view/verfication_phon_screen.dart';

import 'package:mersal/view/notifications%20screen/controller/notification_controller.dart';


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

//  StreamSubscription? _linkSub;

/*   Future<void> loginWithGoogle(bool isgoogle) async {
    try {
      // 1. افتح رابط تسجيل الدخول
      final Uri loginUri = Uri.parse(isgoogle?"https://mersal.site/Ms/api/auth/google/redirect":ApiLinks.facebook);
      if (!await launchUrl(loginUri, mode: LaunchMode.externalApplication)) {
        throw 'لا يمكن فتح الرابط';
      }

      // 2. استمع لرابط العودة (callback)
      _linkSub = linkStream.listen((String? link) async {
        if (link != null && link.contains('token=')) {
          // استخرج التوكن من الرابط
          final uri = Uri.parse(link);
          final token = uri.queryParameters['token'];

          if (token != null) {
            print("🔐 Token: $token");

            // احفظ التوكن
            await MyServices.saveValue(SharedPreferencesKey.tokenkey, token);
            await MyServices().setConstToken();

            Get.offAll(() => BottomNavBarScreen()); // أو أي شاشة رئيسية
          }
        }
      }, onError: (err) {
        print("❌ Error listening to links: $err");
      });
    } catch (e) {
      print("Google Login Error: $e");
      Get.snackbar('خطأ', 'فشل تسجيل الدخول باستخدام Google');
    }
  } */
}
