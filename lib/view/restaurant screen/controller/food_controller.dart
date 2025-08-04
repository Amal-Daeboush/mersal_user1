/* import 'package:get/get.dart';
import 'package:mersal/core/class/crud.dart';
import 'package:mersal/core/class/status_request.dart';
import 'package:mersal/core/constant/api_links.dart';

import 'package:flutter/material.dart';
import 'package:mersal/data/model/food_type_model.dart';
import 'package:mersal/data/model/products_model.dart'; // assuming this is where ProductsModel is defined

class FoodController extends GetxController {
  final int id;
  final String type;
  List<ProductModel> allProducts = []; // كل المنتجات

  FoodController({required this.id, required this.type});

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
    allProducts.clear(); // ✅ امسحها كل مرة تحميل جديد
    update();
  }

  isLoadingMore = true;
  update();

  Crud crud = Crud();
  final url = '${ApiLinks.productByCategory}/$id?page=$currentPage';
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
        final parsed = ProductsModelModel.fromJson(Map<String, dynamic>.from(data));
        final fetched = parsed.data;

        allProducts.addAll(fetched); // ✅ خزّن الكل هنا
        applyFilter(); // ✅ فلترة حسب النوع المحدد

        currentPage = parsed.currentPage;
        lastPage = parsed.lastPage;
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

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
 */