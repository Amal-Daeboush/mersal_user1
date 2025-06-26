import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mersal/core/class/crud.dart';
import 'package:mersal/core/class/status_request.dart';
import 'package:mersal/core/constant/api_links.dart';
import 'package:mersal/data/model/product_providers.dart';
import 'package:mersal/data/model/products_model.dart';
import 'package:mersal/data/model/rating_model.dart';
import 'package:mersal/data/model/service_provider_model.dart';
import 'package:mersal/view/widgets/snack%20bar/custom_snack_bar.dart';

import '../../../data/data_source/remote/api_remote.dart';

class DetailsController extends GetxController {
  List<RatingsModel> ratings = [];
  StatusRequest statusRequest = StatusRequest.loading;
  ServiceProviderModel? productProviderModel;
  String message = '';
  TextEditingController comment = TextEditingController();
  TextEditingController numrate = TextEditingController();
  bool isSearchActive = false;
  RxBool isLoading = false.obs; // ✅
  final int id;
  final ProductModel productModel;
  DetailsController({required this.id, required this.productModel});

  @override
  void onInit() {
    if (productModel.providerableType != 'App\\Models\\Provider_Product') {
      getProvider();
    }
    getRatings();
    super.onInit();
  }

  Future<void> getRatings() async {
    statusRequest = StatusRequest.loading;
    update();

    Crud crud = Crud();
    var response = await crud.getData(
      '${ApiLinks.getRating}/$id',
      ApiLinks().getHeaderWithToken(),
    );

    response.fold(
      (failure) {
        statusRequest = StatusRequest.failure;

        // If you want to extract the error message from the failure,
        // you might need to change your getData method to pass it.
        // For now, fallback to generic messages:
        message =
            failure == StatusRequest.offlineFailure
                ? 'تحقق من الاتصال بالانترنت'
                : ' لا يوجد اراء';

        Get.snackbar('Error', message, snackPosition: SnackPosition.TOP);
        update();
      },
      (data) {
        if (data != null && data is Map<String, dynamic>) {
          if (data.containsKey('message') &&
              data['message'] == 'No rating found for this product') {
            // Handle the API message for no ratings found explicitly
            statusRequest = StatusRequest.failure;
            message = data['message'];
            ratings = [];
            Get.snackbar('تنبيه', message, snackPosition: SnackPosition.BOTTOM);
          } else {
            var dataList = data["data"];
            if (dataList is List && dataList.isNotEmpty) {
              ratings =
                  dataList.map((item) => RatingsModel.fromJson(item)).toList();
              statusRequest = StatusRequest.success;
            } else {
              statusRequest = StatusRequest.failure;
              message = 'لا توجد اراء.';
              ratings = [];
              Get.snackbar(
                'تنبيه',
                message,
                snackPosition: SnackPosition.BOTTOM,
              );
            }
          }
        } else {
          // data = null or not Map<String, dynamic>
          statusRequest = StatusRequest.failure;
          message = 'حدث خطأ في جلب البيانات.';
          ratings = [];
          Get.snackbar('خطأ', message, snackPosition: SnackPosition.BOTTOM);
        }
        update();
      },
    );
  }

  void addRate(BuildContext context) async {
    if (numrate.text.isNotEmpty && comment.text.isNotEmpty) {
      isLoading.value = true;

      var response = await ApiRemote().AddrateModel({
        'num': numrate.text,
        'comment': comment.text,
      }, id.toString());

      isLoading.value = false;

      if (response == StatusRequest.success) {
        Get.snackbar('نجاح', 'تمت إضافة التقييم');
        getRatings();
        Navigator.pop(context); // ✅ إغلاق الديالوغ
      } else {
        Get.snackbar('خطأ', response is String ? response : 'حدث خطأ');
        Navigator.pop(context); // ✅
      }
    } else {
      Get.snackbar('خطأ', 'من فضلك املىء الحقول');
    }
    comment.clear();
    numrate.clear();
    update();
  }

  Future<void> deleteRate(String replayId, String rateId) async {
    isLoading.value = true;
    var result = await ApiRemote().deleteReplay({}, replayId);
    if (result == StatusRequest.success) {
      Get.snackbar('تم', 'تم حذف التقييم');
      await getRatings();
    } else {
      Get.snackbar('خطأ', 'فشل الحذف');
    }
    isLoading.value = false;
  }

  Future<void> editRate(String replayId, String newComment) async {
    isLoading.value = true;
    var result = await ApiRemote().editReplay(replayId, {
      'comment': newComment,
      '_method': 'PUT',
    });
    if (result == StatusRequest.success) {
      Get.snackbar('تم', 'تم تعديل الرد');
      await getRatings();
    } else {
      Get.snackbar('خطأ', 'فشل التعديل');
    }
    isLoading.value = false;
  }

  getProvider() async {
    statusRequest = StatusRequest.loading;
    update();

    Crud crud = Crud();
    var response = await crud.getData(
      '${ApiLinks.getProviderforservice}/${productModel.providerableId}',
      ApiLinks().getHeaderWithToken(),
    );

    response.fold(
      (failure) {
        if (failure == StatusRequest.offlineFailure) {
          statusRequest = StatusRequest.offlineFailure;
          message = 'تحقق من الاتصال بالانترنت';
          CustomSnackBar(message, true);
        } else {
          statusRequest = StatusRequest.failure;
          message = ' جلب المزود حدث خطأ';
        }
        CustomSnackBar(message, true);

        update();
      },
      (data) {
        print("Response data: $data");

        if (data != null && data is Map<String, dynamic>) {
          productProviderModel = ServiceProviderModel.fromJson(data);

          print(productProviderModel);
          statusRequest = StatusRequest.success;
        } else {
          statusRequest = StatusRequest.failure;
          message = 'جلب مزود حدث خطأ';
          print("Invalid data structure or 'data' key is missing");
          productProviderModel = null;
        }

        update();
      },
    );
  }
}
