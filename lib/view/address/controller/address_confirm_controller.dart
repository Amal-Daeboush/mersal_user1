/* import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/class/helper_functions.dart';
import '../../../core/class/status_request.dart';
import '../../../core/constant/app_routes.dart';
import '../../../core/sevices/sevices.dart';
import '../../../data/data_source/remote/address/add_city_data.dart';

class AddressConfirmController extends GetxController {
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  AddCityData addCityData = AddCityData(Get.find());
  bool isEditable = false;
  late String locality = '';
  // String street = 'Zahra';
  late double latitude;
  late double longitude;
  CameraPosition? kGooglePlex;
  Set<Marker> markers = {};
  final Completer<GoogleMapController> completerController =
      Completer<GoogleMapController>();

  showMarker() {
    markers.clear();
    markers.add(Marker(
        markerId: const MarkerId("1"), position: LatLng(latitude, longitude)));
  }

  getLocation() async {
    kGooglePlex = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 10.4746,
    );
    await showMarker();
    await getLocationInformation();
    update();
  }

  changeMarkerLocation(LatLng latLng) async {
    markers.clear();
    markers.add(Marker(markerId: const MarkerId("1"), position: latLng));
    latitude = latLng.latitude;
    longitude = latLng.longitude;
    await getLocationInformation();
    isEditable = false;

    update();
  }

  onPressedEdit() {
    isEditable = true;
    Get.snackbar("Alert", "Please choose from map");
    update();
  }

  getLocationInformation() async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      locality = placemarks[0].locality!;
      // street = placemarks[3].street!;
    } catch (e) {
      print('Error: $e');
    }
  }

  onPressedConfirmAddress() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await addCityData.putData(city: locality);
    print("========== Controller ========== $response");
    statusRequest = HelperFunctions.handlingData(response);
    if (statusRequest == StatusRequest.success) {
      myServices.sharedPreferences.setString('city', locality);
      myServices.sharedPreferences.setDouble('longitude', longitude);
      myServices.sharedPreferences.setDouble('latitude', latitude);
      print(
          "========== city ==========${myServices.sharedPreferences.getString('city')}");
     // Get.toNamed(AppRoutes.confirmOrder);
    } else if (statusRequest != StatusRequest.offlineFailure) {
      Get.snackbar("Alert", "Something went wrong");
    }
    update();

 //   Get.toNamed(AppRoutes.confirmOrder);
  }

  @override
  void onInit() {
    locality = myServices.sharedPreferences.getString('city') ?? "undefined";
    longitude =
        myServices.sharedPreferences.getDouble('longitude') ?? 36.758692;
    latitude = myServices.sharedPreferences.getDouble('latitude') ?? 34.728904;
    print("========== longitude=$longitude ========== latitude=$latitude ");

    getLocation();
    super.onInit();
  }
}
 */