import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mersal/core/class/crud.dart';
import 'package:mersal/core/class/status_request.dart';
import 'package:mersal/core/constant/api_links.dart';
import 'package:mersal/model/api_remote.dart';
import 'package:mersal/model/favourite_model.dart';

class FavouriteController extends GetxController {
  List<FavouriteModel> favourite = [];
  List<FavouriteModel> filteredFavourite = [];
  StatusRequest statusRequest = StatusRequest.loading;
  RxBool isLoadingcFavourie = false.obs;
  TextEditingController searchController = TextEditingController();
  String message = '';

  @override
  void onInit() {
    getFavorites();
    super.onInit();
  }

  Future<void> getFavorites() async {
    statusRequest = StatusRequest.loading;
    update();

    Crud crud = Crud();
    var response = await crud.getData(
      ApiLinks.getFavoriteProduct,
      ApiLinks().getHeaderWithToken(),
    );

    response.fold(
      (failure) {
        statusRequest = StatusRequest.failure;
        message =
            failure == StatusRequest.offlineFailure
                ? 'تحقق من الاتصال بالانترنت'
                : 'حدث خطأ';
        Get.snackbar('Error', message, snackPosition: SnackPosition.TOP);
        update();
        filteredFavourite = [];
      },
      (data) {
        if (data != null && data is List) {
          favourite =
              data.map((item) => FavouriteModel.fromJson(item)).toList();
          filteredFavourite = List.from(favourite);
          statusRequest = StatusRequest.success;
        } else {
          message = 'حدث خطأ';
          favourite = [];
          filteredFavourite = [];
          statusRequest = StatusRequest.failure;
          Get.snackbar('خطأ', message, snackPosition: SnackPosition.BOTTOM);
        }
        update();
      },
    );
  }

  void filterMFavourites(String query) {
    if (query.isEmpty) {
      filteredFavourite = List.from(favourite);
    } else {
      filteredFavourite =
          favourite
              .where(
                (msg) => msg.name.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    }
    update();
  }

  addFavorite(String id) async {
    isLoadingcFavourie.value = true;

    var response = await ApiRemote().AddFavouriteModel({
      "favoritable_type": "0",
    }, id);

    isLoadingcFavourie.value = false;

    if (response == StatusRequest.success) {
      Get.snackbar('نجاح', 'تمت إضافة ');
      // getRatings();
      //  Navigator.pop(context); // ✅ إغلاق الديالوغ
    } else {
      Get.snackbar('خطأ', response is String ? response : 'حدث خطأ');
      //  Navigator.pop(context); // ✅ إغلاق الديالوغ حتى في حال الخطأ
    }
  }

  deleteFavorite(String id) async {
    isLoadingcFavourie.value = true;

    var response = await ApiRemote().deleteFavouriteModel({}, id);

    isLoadingcFavourie.value = false;

    if (response == StatusRequest.success) {
      Get.snackbar('نجاح', 'تم حذف المنتج من المفضلة ');
      getFavorites();
      // getRatings();
      //  Navigator.pop(context); // ✅ إغلاق الديالوغ
    } else {
      Get.snackbar('خطأ', response is String ? response : 'حدث خطأ');
      //  Navigator.pop(context); // ✅ إغلاق الديالوغ حتى في حال الخطأ
    }
  }
}
