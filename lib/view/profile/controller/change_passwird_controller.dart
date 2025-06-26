import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mersal/core/class/status_request.dart';
import 'package:mersal/data/data_source/remote/api_remote.dart';
import 'package:mersal/view/widgets/snack%20bar/custom_snack_bar.dart'
    show CustomSnackBar;

class ChangePasswordController extends GetxController {
  TextEditingController oldpass = TextEditingController();
  TextEditingController newpass = TextEditingController();
  TextEditingController confirmpass = TextEditingController();
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  StatusRequest statusRequest = StatusRequest.none;
  String message = '';

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'من فضلك املىء الحقل  ';
    }

    if (value.length < 8) {
      return 'يجب ان تكون كلمة السر لا تقل عن 8 محارف';
    }

    return null;
  }

  updatepassword() async {
    if (keyForm.currentState!.validate() && newpass.text == confirmpass.text) {
      statusRequest = StatusRequest.loading;
      update();

      var response = await ApiRemote().updateProfile({
        '_method': 'PUT',
        'current_password': oldpass.text,
        'password': newpass.text,
        'password_confirmation': confirmpass.text,
      });

      // تأجيل تحديث الحالة قبل عرض SnackBar
      if (response == StatusRequest.success) {
        statusRequest = StatusRequest.success;
        message = 'تم تغيير كلمة المرور بنجاح';
        update(); // تحديث الحالة قبل عرض SnackBar
        CustomSnackBar('تم تغيير كلمة المرور بنجاح', true);
        Get.back();
      } else if (response is String) {
        statusRequest = StatusRequest.failure;
        message = 'حدث خطأ';
        update(); // تحديث الحالة قبل عرض SnackBar
        Get.snackbar('خطأ', response);
      } else {
        statusRequest = StatusRequest.failure;
        message = 'حدث خطأ';
        update(); // تحديث الحالة قبل عرض SnackBar
        Get.snackbar('خطأ', 'حدث خطأ');
      }

      // مسح الحقول
      oldpass.clear();
      newpass.clear();
      confirmpass.clear();
    } else {
      Get.snackbar('خطأ', 'حدث خطأ ');
      message = 'حدث خطأ';
      oldpass.clear();
      newpass.clear();
      confirmpass.clear();
    }
    update();
    CustomSnackBar(message, true);
  }
}
