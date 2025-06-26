import 'package:get/get.dart';
import 'package:mersal/view/address/view/address.dart';
import 'package:mersal/view/authentication/login/screen/login.dart';

class VerificationController extends GetxController {
  // static VerificationController instance = Get.find();
  late String phoneNumber;
  String? verificationCode;
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

  void checkVerificationCode() {
    if (verificationCode == '123456') {
 //     Get.off(AddressScreen(isfromHome: false));
       Get.off(LoginScreen());
    } else {
      Get.snackbar("Alert", "Please enter valid email");
    }
  }

  @override
  void onInit() {
    // waiting();
    phoneNumber = '0991615304';
    // TODO: implement onInit
    super.onInit();
  }
}
