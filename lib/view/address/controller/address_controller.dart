import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mersal/core/class/crud.dart';
import 'package:mersal/core/constant/api_links.dart';
import 'package:mersal/core/constant/const_data.dart';
import 'package:mersal/core/sevices/key_shsred_perfences.dart';
import 'package:mersal/core/sevices/sevices.dart';
import 'package:mersal/model/api_remote.dart';
import 'package:mersal/view/botttom%20nav%20bar/view/bottom_nav_bar_screen.dart';

import 'package:mersal/view/widgets/snack%20bar/custom_snack_bar.dart';
import '../../../core/class/status_request.dart';
import '../../../core/constant/app_routes.dart';


class AddressController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;

  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  // MyServices myServices = Get.find();
  String message = '';
  StatusRequest statusRequest1 = StatusRequest.loading;
  TextEditingController addressController = TextEditingController();
  bool isLoading = false;
  bool isfoundProfile = ConstData.user?.user.profile != null;
  // AddCityData addCityData = AddCityData(Get.find());
  late Position position;
  double? latitude;
  double? longitude;
  CameraPosition? kGooglePlex;
  Set<Marker> markers = {};
  final Completer<GoogleMapController> completerController =
      Completer<GoogleMapController>();
  String? currentCity;
  addMarkers(LatLng latLng) {
    markers.clear();
    markers.add(Marker(markerId: const MarkerId("1"), position: latLng));
    latitude = latLng.latitude;
    longitude = latLng.longitude;
    // update();
  }

  getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        isLoading = false;
        update();
        Get.snackbar("تنبيه", "يرجى السماح بالوصول إلى الموقع");
        return;
      }
    }

    try {
      position = await Geolocator.getCurrentPosition();
      print("========== latitude ==========${position.latitude}");
      print("========== longitude ==========${position.longitude}");
      kGooglePlex = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 14.4746,
      );
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      currentCity = placemarks[0].administrativeArea!;

      print("========== currentCity ==========$currentCity");
    } catch (e) {
      print('Error: $e');
      Get.snackbar("Alert", "The Map does not support your location");
      currentCity = "undefined";
    }
    await addMarkers(LatLng(position.latitude, position.longitude));
    update();
  }

  onPressedAddLocationFromMap() {
    if (latitude == null || longitude == null) {
      Get.defaultDialog(
        title: 'Warning',
        middleText: "Please wait until map loaded",
      );
    } else {
      /* Get.toNamed(AppRoutes.addressadd,
          arguments: {'latitude': latitude, 'longitude': longitude}); */
    }
  }

  onRefresh() {
    //  onPressedUseCurrentLocation();
    update();
  }

  onTapSkip() {
    Get.offNamed(AppRoutes.homepage);
  }

  @override
  void onInit() {
    print('--------------------------');
    print(isfoundProfile);
    //   print(kGooglePlex);
    getCurrentLocation();
    super.onInit();
  }

  validate(value) {
    if (value == null || value.isEmpty) {
      return "يجب ان تدخل عنوانك";
    }
    return null;
  }

  Future<dynamic> updateAddress() async {
    if (keyForm.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      Crud crud = Crud();
      var response = await crud.post(ApiLinks.updateProfile, {
        'address': addressController.text,
        // يمكنك هنا أيضاً إرسال الإحداثيات لو أردت
        // 'lang': '$longitude',
        // 'lat': '$latitude',
      }, ApiLinks().getHeaderWithToken());

      response.fold(
        (failure) {
          statusRequest = failure;
          message =
              (failure == StatusRequest.offlineFailure)
                  ? 'تحقق من الاتصال بالانترنت'
                  : 'حدث خطأ';

          Get.snackbar('Error', message, snackPosition: SnackPosition.TOP);
          update();
        },
        (data) async {
          if (data != null && data is Map<dynamic, dynamic>) {
            var address = data['profile']['address'];
            await MyServices.saveValue(SharedPreferencesKey.address, address);
            await MyServices().setConstAddress();

            // 🔄 ثم نحاول رفع الإحداثيات
            var mapStatus = await storemap();

            if (mapStatus == StatusRequest.success) {
              statusRequest = StatusRequest.success;
              CustomSnackBar('تم تحديث العنوان بنجاح', true);
              Get.offAll(BottomNavBarScreen());
            } else {
              statusRequest = StatusRequest.failure;
              Get.snackbar(
                'خطأ',
                'تم تحديث العنوان، لكن فشل رفع الموقع الجغرافي',
                backgroundColor: Colors.orange,
                colorText: Colors.white,
                snackPosition: SnackPosition.TOP,
              );
            }
          } else {
            statusRequest = StatusRequest.failure;
            message = 'حدث خطأ';
            Get.snackbar('خطأ', message, snackPosition: SnackPosition.BOTTOM);
          }
          update();
        },
      );
    } else {
      Get.snackbar('خطأ', 'من فضلك ادخل عنوانك ');
      addressController.clear();
    }
  }

  Future<StatusRequest> storemap() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await ApiRemote().updateInfo({
      '_method': 'PUT',
      'lang': '$longitude',
      'lat': '$latitude',
    });

    print("🚀 storemap response: $response");

    // إذا كان response خريطة تحتوي على مفتاح message يشير إلى النجاح
    if (response is Map &&
        response['message'] == "تم تحديث معلومات المستخدم بنجاح") {
      print("✅ تم رفع الموقع بنجاح");
      return StatusRequest.success;
    } else {
      print("❌ فشل رفع الموقع");
      return StatusRequest.failure;
    }
  }

  Future<void> storeProfile() async {
    if (!keyForm.currentState!.validate()) {
      Get.snackbar('تنبيه', 'يرجى ملء الحقول بشكل صحيح');
      return;
    }

    statusRequest = StatusRequest.loading;
    update();

    try {
      var uri = Uri.parse(ApiLinks.storeProfile);
      var request = http.MultipartRequest("POST", uri);

      // Headers
      request.headers.addAll(ApiLinks().getHeaderWithToken());

      // Fields
      request.fields['address'] = addressController.text;

      // Add default image
      final byteData = await rootBundle.load('assets/images/user.png');
      final imageBytes = byteData.buffer.asUint8List();

      final multipartFile = http.MultipartFile.fromBytes(
        'image',
        imageBytes,
        filename: 'user.png',
        contentType: MediaType('image', 'png'),
      );

      request.files.add(multipartFile);

      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        var decoded = json.decode(responseData);
        String address = decoded['profile']['address'];
        await MyServices.saveValue(SharedPreferencesKey.address, address);
        await MyServices().setConstAddress();

        // → تأجيل إظهار Snackbar حتى نجاح storemap()
        var mapStatus = await storemap();

        if (mapStatus == StatusRequest.success) {
          CustomSnackBar('تم رفع المعلومات بنجاح', true);
          statusRequest = StatusRequest.success;
          Get.offAll(BottomNavBarScreen());
        } else {
          // storemap فشلت
          Get.snackbar(
            'تنبيه',
            'تم رفع المعلومات، لكن فشل رفع الإحداثيات',
            backgroundColor: Colors.orange,
            colorText: Colors.white,
          );
          statusRequest = StatusRequest.failure;
        }
      } else {
        print(responseData);
        CustomSnackBar(
          'فشل في رفع المعلومات! رمز الحالة: ${response.statusCode}',
          false,
        );
        statusRequest = StatusRequest.failure;
      }
    } catch (e) {
      print("❌ خطأ: $e");
      statusRequest = StatusRequest.failure;
      Get.snackbar(
        'خطأ',
        'حدث خطأ أثناء رفع المعلومات',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    update();
  }

  @override
  void onClose() {
    addressController.clear();
    super.onClose();
  }
}
 /* onPressedUseCurrentLocation() async {
    if (latitude == null || longitude == null || currentCity == null) {
      Get.defaultDialog(
          title: 'Warning', middleText: "Please wait until map loaded");
    } else {
      statusRequest = StatusRequest.loading;
      update();
      var response = await addCityData.putData(city: currentCity!);
      print("========== Controller ========== $response");
      statusRequest = HelperFunctions.handlingData(response);
      if (statusRequest == StatusRequest.success) {
        user = UserModel.fromJson(response['data']['user']);
        myServices.sharedPreferences.setString('city', user!.city!);
        myServices.sharedPreferences.setDouble('longitude', longitude!);
        myServices.sharedPreferences.setDouble('latitude', latitude!);

        print(
            "========== city ==========${myServices.sharedPreferences.getString('city')}");
        Get.offNamed(AppRoutes.homepage, arguments: {'city': currentCity});
      } else if (statusRequest != StatusRequest.offlineFailure) {
        Get.snackbar("Alert", "Something went wrong");
      }
      update();
    }
  }
 */ 