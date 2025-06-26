import 'package:get/get.dart';
import 'package:mersal/core/class/crud.dart';
import 'package:mersal/core/class/status_request.dart';
import 'package:mersal/core/constant/api_links.dart';
import 'package:mersal/data/model/category_model.dart';

import 'package:flutter/material.dart';
import 'package:mersal/data/model/products_model.dart'; // assuming this is where ProductsModel is defined

import 'package:get/get.dart';
import 'package:mersal/core/class/crud.dart';
import 'package:mersal/core/class/status_request.dart';
import 'package:mersal/core/constant/api_links.dart';
import 'package:mersal/data/model/category_model.dart';
import 'package:mersal/data/model/products_model.dart';
import 'package:flutter/material.dart';

class MyServiceController extends GetxController {
  final int id;
  final bool isProductProv;

  MyServiceController({required this.id, required this.isProductProv});

  StatusRequest statusRequest = StatusRequest.loading;
  String message = '';
  bool isSearchActive = false;

  List<ProductModel> products = [];
  int currentPage = 1;
  int lastPage = 1;
  int activeIndex = 1;
  bool isLoadingMore = false;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    // activeIndex = select_category.id;
    getProduct(isInitialLoad: true);

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 100 &&
          !isLoadingMore &&
          currentPage < lastPage) {
        loadMore();
      }
    });
  }

  void setActiveIndex(int index) {
    activeIndex = index;
    update();
  }

  Future<void> getProduct({bool isInitialLoad = false}) async {
    if (isInitialLoad) {
      statusRequest = StatusRequest.loading;
      currentPage = 1;
      products.clear();
      update();
    }

    isLoadingMore = true;
    update();

    Crud crud = Crud();
    final url =
        isProductProv
            ? '${ApiLinks.productByProviderProduct}/$id?page=$currentPage'
            : '${ApiLinks.productByCategory}/$id?page=$currentPage';
    final response = await crud.post(url, {}, ApiLinks().getHeaderWithToken());

    response.fold(
      (failure) {
        isLoadingMore = false;
        statusRequest = StatusRequest.failure;
        message = 'فشل الاتصال بالخادم.';
        Get.snackbar('خطأ', message);
        update();
      },
      (data) {
        isLoadingMore = false;
        if (data != null && data is Map) {
          final parsed = ProductsModelModel.fromJson(
            Map<String, dynamic>.from(data),
          );
          products.addAll(parsed.data!);
          currentPage = parsed.currentPage;
          lastPage = parsed.lastPage; // ✅ يتم حسابه تلقائيًا
          statusRequest = StatusRequest.success;
        } else {
          statusRequest = StatusRequest.failure;
          message = 'استجابة غير صالحة من الخادم.';
          Get.snackbar('خطأ', message);
        }
        update();
      },
    );
  }

  void loadMore() {
    if (currentPage < lastPage) {
      currentPage++;
      getProduct();
    }
  }

  /*  void updateCategory(CategoryModel category) {
    select_category = category;
    activeIndex = category.id;
    getProduct(isInitialLoad: true);
    update();
  } */

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
