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
import 'package:mersal/view/botttom%20nav%20bar/view/bottom_nav_bar_screen.dart';
import 'package:mersal/view/home/controller/home_controller.dart';
import 'package:mersal/view/widgets/snack%20bar/custom_snack_bar.dart';
import '../../../core/class/status_request.dart';
import '../../../core/constant/app_routes.dart';
import '../../../model/user_model.dart';

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
  User1Model? user;
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
        'lang': '$longitude',
        'lat': '$latitude',
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
          if (data != null && data is Map<dynamic, dynamic>) {
            var address = data['profile']['address'];

            await MyServices.saveValue(SharedPreferencesKey.address, address);

            await MyServices().setConstAddress();
            //  HomeController homeController = Get.find<HomeController>();
            //  homeController.addressUser = ConstData.addressUser;
            //    homeController.addressUser.value = addressController.text;
            statusRequest = StatusRequest.success;
            Get.offAll(BottomNavBarScreen());
          } else {
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
      Get.snackbar('خطأ', 'من فضلك ادخل عنوانك ');
      addressController.clear();
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

      // Headers with token
      request.headers.addAll(ApiLinks().getHeaderWithToken());

      // Fields
      request.fields['address'] = addressController.text;
      request.fields['lang'] = '$longitude';
      request.fields['lat'] = '$latitude';

      // Attach all selected images

      final byteData = await rootBundle.load('assets/images/user.png');
      final Uint8List imageBytes = byteData.buffer.asUint8List();

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
        var decodeResponse = json.decode(responseData);
        String address = decodeResponse['profile']['address'];

        await MyServices.saveValue(SharedPreferencesKey.address, address);

        await MyServices().setConstAddress();

        //  HomeController homeController = Get.find<HomeController>();
        CustomSnackBar('تم رفع المعلومات بنجاح', true);

        statusRequest = StatusRequest.success;
        Get.offAll(BottomNavBarScreen());
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
        'حدث خطأ أثناء رفع المعومات',
        snackPosition: SnackPosition.TOP,
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