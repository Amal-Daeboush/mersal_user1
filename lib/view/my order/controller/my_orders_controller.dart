import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mersal/core/class/crud.dart';
import 'package:mersal/core/class/status_request.dart';
import 'package:mersal/core/constant/api_links.dart';
import 'package:mersal/data/data_source/remote/api_remote.dart';
import 'package:mersal/data/model/product_order_model.dart';
import 'package:mersal/data/model/service_revestion_model.dart';

class MyOrdersController extends GetxController {
  List<OrderProductModel> productOrders = [];
  List<OrderProductModel> activeOrders = [];
  List<OrderProductModel> cancelOrders = [];
  List<OrderProductModel> onWayOrders = [];
  List<OrderProductModel> coupletOrders = [];
   List<OrderProductModel> acceptedOrders = [];
  List<ServiceReservationModel> servicesOrders = [];
  List<ServiceReservationModel> servicesactiveOrders = [];
  List<ServiceReservationModel> servicescancelOrders = [];
  List<ServiceReservationModel> servicescoupletOrders = [];
  StatusRequest statusRequest = StatusRequest.loading;
  RxBool isLoadingcFavourie = false.obs;
  //TextEditingController searchController = TextEditingController();
  String message = '';

  @override
  void onInit() {
    getOrderProduct();
    getOrderServices();
    super.onInit();
  }

  Future<void> getOrderProduct() async {
    statusRequest = StatusRequest.loading;
    update();

    Crud crud = Crud();
    var response = await crud.getData(
      '${ApiLinks.getOrdersByStatus}?status=all',
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
        productOrders = [];
      },
      (data) {
        if (data != null && data is Map<String, dynamic>) {
          // نجيب قائمة الطلبات من المفتاح "orders"
          var ordersList = data["orders"];
          if (ordersList is List && ordersList.isNotEmpty) {
            productOrders =
                ordersList
                    .map<OrderProductModel>(
                      (item) => OrderProductModel.fromJson(item),
                    )
                    .toList();
            statusRequest = StatusRequest.success;
            activeOrders =
                productOrders
                    .where((item) => item.status == 'pending')
                    .toList();
            onWayOrders =
                productOrders.where((item) => item.status == 'on_way').toList();
            cancelOrders =
                productOrders
                    .where((item) => item.status == 'cancelled')
                    .toList();
  acceptedOrders =
                productOrders
                    .where((item) => item.status == 'accepted')
                    .toList();
            coupletOrders =
                productOrders
                    .where((item) => item.status == 'complete')
                    .toList();
          } else {
            message = 'لا توجد طلبات';
            productOrders = [];
            statusRequest = StatusRequest.failure;
            Get.snackbar('تنبيه', message, snackPosition: SnackPosition.BOTTOM);
          }
        } else {
          message = 'حدث خطأ في جلب البيانات';
          productOrders = [];
          statusRequest = StatusRequest.failure;
          Get.snackbar('خطأ', message, snackPosition: SnackPosition.BOTTOM);
        }
        update();
      },
    );
  }

  Future<void> getOrderServices() async {
    statusRequest = StatusRequest.loading;
    update();

    Crud crud = Crud();
    var response = await crud.getData(
      '${ApiLinks.getreservation}?status=all',
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
        servicesOrders = [];
      },
      (data) {
        if (data != null && data is Map<String, dynamic>) {
          // نجيب قائمة الطلبات من المفتاح "orders"
          var ordersList = data["reservations"];
          if (ordersList is List && ordersList.isNotEmpty) {
            servicesOrders =
                ordersList
                    .map<ServiceReservationModel>(
                      (item) => ServiceReservationModel.fromJson(item),
                    )
                    .toList();
            statusRequest = StatusRequest.success;
            servicesactiveOrders =
                servicesOrders
                    .where((item) => item.status == 'pending')
                    .toList();

            servicescancelOrders =
                servicesOrders
                    .where((item) => item.status == 'cancelled')
                    .toList();

            servicescoupletOrders =
                servicesOrders
                    .where((item) => item.status == 'complete')
                    .toList();
          } else {
            message = 'لا توجد طلبات';
            servicesOrders = [];
            statusRequest = StatusRequest.failure;
            Get.snackbar('تنبيه', message, snackPosition: SnackPosition.BOTTOM);
          }
        } else {
          message = 'حدث خطأ في جلب البيانات';
          servicesOrders = [];
          statusRequest = StatusRequest.failure;
          Get.snackbar('خطأ', message, snackPosition: SnackPosition.BOTTOM);
        }
        update();
      },
    );
  }

  RxBool isLoading = false.obs; // ✅
  void CancelOrder(BuildContext context, String id) async {
    isLoading.value = true;

    var response = await ApiRemote().CancelOrderModel({}, id.toString());

    isLoading.value = false;

    if (response == StatusRequest.success) {
      Get.snackbar('نجاح', 'تم الغاء الطلب  ');
      getOrderProduct();
      getOrderServices();
      //  getRatings();
      Navigator.pop(context); // ✅ إغلاق الديالوغ
    } else {
      Get.snackbar('خطأ', response is String ? response : 'حدث خطأ');
      Navigator.pop(context); // ✅
    }

    update();
  }


  /*   void filterMFavourites(String query) {
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
  } */

}
