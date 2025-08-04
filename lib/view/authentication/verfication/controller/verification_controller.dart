import 'package:get/get.dart';
import 'package:mersal/core/class/status_request.dart';
import 'package:mersal/core/constant/api_links.dart';
import 'package:mersal/core/sevices/key_shsred_perfences.dart';
import 'package:mersal/core/sevices/sevices.dart';
import 'package:mersal/data/data_source/remote/api_remote.dart';
import 'package:mersal/view/address/view/address.dart';
import 'package:mersal/view/authentication/login/screen/login.dart';

import '../../../notifications screen/controller/notification_controller.dart';


class VerificationController extends GetxController {
  // static VerificationController instance = Get.find();
  late String phoneNumber;
  String? verificationCode;
  final String email;
  StatusRequest statusRequest = StatusRequest.none;

  VerificationController({required this.email});

  // RxInt counter = 60.obs;
  // Timer? timer;
  // waiting() {
  //   timer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //     if (counter.value == 0) {
  //       counter.value = 60;
  //       timer.cancel();
  //       return;
  //     }
  //     counter--;
  //   });
  // }
  VerificationEmail() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await ApiRemote().verificationModel(
      {'otp': verificationCode},
      ApiLinks.verify_otp,
      true,
    );

    print("Response: $response");

    if (response == StatusRequest.success) {
      Get.snackbar('نجاح', ' تم التحقق من الحساب ..');

      statusRequest = StatusRequest.success;
      await MyServices.saveValue(SharedPreferencesKey.otp, '1');
      await MyServices().setConstOtp();
        final userId = await MyServices.getValue(
    SharedPreferencesKey.tokenkey,
  ); // أو أي طريقة تحفظ بها اليوزر

  if (userId != null) {
    var controller = Get.put(NotificationController());
    controller.loadNotifications(loadUnreadAlso: true);
  }
      Get.off(AddressScreen(isfromHome: false));
      //   Get.off(LoginScreen(provider: provider));
    } else if (response is String) {
      // ✅ عرض رسالة الخطأ بشكل مناسب
      Get.snackbar('Error', response);

      statusRequest = StatusRequest.failure;
    } else {
      Get.snackbar('خطأ', 'حدث خطأ');

      statusRequest = StatusRequest.failure;
    }

    update();
  }

  ResetPassEmail() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await ApiRemote().verificationModel(
      {'otp': verificationCode, 'email': email},
      ApiLinks.reset_pass,
      false,
    );

    print("Response: $response");

    if (response == StatusRequest.success) {
      Get.snackbar('نجاح', ' تم ارسال كلمة السر الجديدة الى الايميل..');

      statusRequest = StatusRequest.success;

      Get.off(LoginScreen());
      //   Get.off(LoginScreen(provider: provider));
    } else if (response is String) {
      // ✅ عرض رسالة الخطأ بشكل مناسب
      Get.snackbar('Error', response);

      statusRequest = StatusRequest.failure;
    } else {
      Get.snackbar('خطأ', 'حدث خطأ');

      statusRequest = StatusRequest.failure;
    }

    update();
  }

  ResendVerificationEmail() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await ApiRemote().verificationModel(
      {},
      ApiLinks.resend_otp,
      true,
    );

    print("Response: $response");

    if (response == StatusRequest.success) {
      Get.snackbar('نجاح', ' تم اعادة ارسال الكود الى الايميل   ..');

      statusRequest = StatusRequest.success;

      // Get.off(AddressScreen(isfromHome: false));
      //   Get.off(LoginScreen(provider: provider));
    } else if (response is String) {
      // ✅ عرض رسالة الخطأ بشكل مناسب
      Get.snackbar('Error', response);

      statusRequest = StatusRequest.failure;
    } else {
      Get.snackbar('خطأ', 'حدث خطأ');

      statusRequest = StatusRequest.failure;
    }

    update();
  }

  

  @override
  void onInit() {
    // waiting();
  //  phoneNumber = '0991615304';
    // TODO: implement onInit
    super.onInit();
  }
}
