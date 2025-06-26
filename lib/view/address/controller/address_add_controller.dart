/* import 'dart:async';
import 'package:mersal/core/class/helper_functions.dart';
import 'package:mersal/core/class/status_request.dart';
import 'package:mersal/core/constant/app_routes.dart';
import 'package:mersal/core/sevices/sevices.dart';
import 'package:mersal/data/data_source/remote/address/add_city_data.dart';

import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../model/user_model.dart';

class AddressAddController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  AddCityData addCityData = AddCityData(Get.find());
  late double latitude;
  late double longitude;
  String city = '';
  String street = '';
  UserModel? user;

  CameraPosition? kGooglePlex;
  Set<Marker> markers = {};
  final Completer<GoogleMapController> completerController =
      Completer<GoogleMapController>();
  loadedMap() async {
    latitude = Get.arguments['latitude'];
    longitude = Get.arguments['longitude'];
    kGooglePlex = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 14.4746,
    );
    await getCurrentLocationMarker();
    await getLocationInformationLocalityAndStreet();
    update();
  }

  getCurrentLocationMarker() {
    markers.add(Marker(
        markerId: const MarkerId("1"), position: LatLng(latitude, longitude)));
  }

  getLocationInformationLocalityAndStreet() async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      city = placemarks[0].administrativeArea!;
      street = placemarks[3].street!;
      print("========== locality ========== $city");
      print("========== street ========== $street");
    } catch (e) {
      print('Error: $e');
      Get.snackbar("Alert", "The Map does not support your location");
      city = "undefined";
      street = "undefined";
    }
  }

  changeMarkerLocation(LatLng latLng) async {
    markers.clear();
    markers.add(Marker(markerId: const MarkerId("1"), position: latLng));
    latitude = latLng.latitude;
    longitude = latLng.longitude;
    await getLocationInformationLocalityAndStreet();
    update();
  }

  onPressedSaveLocation() async {
    if (city == "") {
      Get.defaultDialog(
          title: 'Warning', middleText: "Please wait until map loaded");
    } else {
      statusRequest = StatusRequest.loading;
      update();
      var response = await addCityData.putData(city: city);
      print("========== Controller ========== $response");
      statusRequest = HelperFunctions.handlingData(response);
      if (statusRequest == StatusRequest.success) {
        user = UserModel.fromJson(response['data']['user']);
        myServices.sharedPreferences.setString('city', user!.city!);
        myServices.sharedPreferences.setDouble('longitude', longitude);
        myServices.sharedPreferences.setDouble('latitude', latitude);

        print(
            "========== city ==========${myServices.sharedPreferences.getString('city')}");
        Get.offNamed(AppRoutes.homepage, arguments: {'city': city});
      } else if (statusRequest != StatusRequest.offlineFailure) {
        Get.snackbar("Alert", "Something went wrong");
      }
      update();
    }

    Get.offAllNamed(AppRoutes.homepage);
  }

  @override
  void onInit() {
    loadedMap();
    super.onInit();
  }
}
 */