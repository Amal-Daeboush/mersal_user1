import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mersal/core/class/crud.dart';
import 'package:mersal/core/class/status_request.dart';
import 'package:mersal/core/constant/api_links.dart';
import 'package:mersal/core/constant/const_data.dart';
import 'package:mersal/core/sevices/key_shsred_perfences.dart';
import 'package:mersal/core/sevices/sevices.dart';
import 'package:mersal/view/botttom%20nav%20bar/view/bottom_nav_bar_screen.dart';
import 'package:mersal/view/profile/controller/profile_controller.dart';
import 'package:mersal/view/widgets/snack%20bar/custom_snack_bar.dart';

class EditInfoProfileController extends GetxController {
  File? selectedImage;
  final ImagePicker picker = ImagePicker();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  StatusRequest statusRequest = StatusRequest.none;
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  String message = '';
  onInit() {
    super.onInit();
    name.text = ConstData.nameUser;
    phone.text = ConstData.phoneUser;
  }

  Crud crud = Crud();
  Future<void> pickImage() async {
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        selectedImage = File(image.path);

        // ✅ استدعاء دالة رفع الصورة
        await postImage(selectedImage!);

        //  CustomSnackBar('Image uploaded successfully', true);
      } else {
        Get.snackbar('Error', 'No image selected');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }

  Future<void> postImage(File imageFile) async {
    statusRequest = StatusRequest.loading;
    update();
    try {
      var uri = Uri.parse(ApiLinks.updateProfile);
      var request = http.MultipartRequest("POST", uri);
      request.headers.addAll(ApiLinks().getHeaderWithToken());
      var multipartFile = await http.MultipartFile.fromPath(
        'image',
        imageFile.path,
      );
      request.files.add(multipartFile);
      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      print("🔴 Response Data: $responseData");
      print("🔴 Status Code: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        //  var decodeResponse = json.decode(responseData);

        statusRequest = StatusRequest.success;
        CustomSnackBar('الصورة تم رفعها بنجاح!', true);
        print("✅ الصورة تم رفعها بنجاح!");
        update();
      } else {
        statusRequest = StatusRequest.failure;

        CustomSnackBar('لم يتم العثور على رابط الصورة في الاستجابة!', true);
        update();
        print("❌ لم يتم العثور على رابط الصورة في الاستجابة!");
      }
    } catch (e) {
      statusRequest = StatusRequest.failure;
      update();
      print("❌ خطأ أثناء رفع الصورة: $e");
    }
  }

  Future<dynamic> updateName() async {
    if (keyForm.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      Crud crud = Crud();
      var response = await crud.post(ApiLinks.postPass, {
        'name': name.text,
        '_method':'PUT'
        //    'phone': phone.text,
      }, ApiLinks().getHeaderWithToken());

      response.fold(
        (failure) {
          if (failure == StatusRequest.offlineFailure) {
            statusRequest = StatusRequest.offlineFailure;
            message = 'تحقق من الاتصال بالانترنت';
            Get.snackbar(
              'Error',
              message,
              snackPosition: SnackPosition.TOP,
            ); // عرض رسالة الخطأ
          } else {
            statusRequest = StatusRequest.failure;
            message = 'حدث خطأ';
            Get.snackbar(
              'Error',
              message,
              snackPosition: SnackPosition.TOP,
            ); // عرض رسالة الخطأ
          }
          update();
        },
        (data) async {
          print("🎯 Response Data: $data");

          if (data != null &&
              data is Map<dynamic, dynamic> &&
              data['user'] != null) {
            var name = data['user']['name'];
         //   var phone = data['user']['phone'];

            await MyServices.saveValue(SharedPreferencesKey.userName, name);
         //   await MyServices.saveValue(SharedPreferencesKey.userPhone, phone);

            ConstData.nameUser = name;
          //  ConstData.phoneUser = phone;

            Get.find<ProfileController>().name = name;
            Get.find<ProfileController>().update();

            statusRequest = StatusRequest.success;
            Get.snackbar('نجاح', 'تم تحديث معلوماتك');
            Get.offAll(BottomNavBarScreen());
          } else {
            statusRequest = StatusRequest.failure;
            message = 'الاستجابة غير متوقعة';
            Get.snackbar('خطأ', message);
            update();
          }

          {
            statusRequest = StatusRequest.failure;
            message = 'حدث خطأ';

            Get.snackbar(
              'خطأ',
              message,
              snackPosition: SnackPosition.BOTTOM,
            ); // عرض رسالة الخطأ
          }
          update();
        },
      );
    } else {
      Get.snackbar('خطأ', 'من فضلك ادخل معلوماتك ');
    }
  }
}
