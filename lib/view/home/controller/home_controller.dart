import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mersal/core/class/crud.dart';
import 'package:mersal/core/class/status_request.dart';
import 'package:mersal/core/constant/api_links.dart';
import 'package:mersal/core/constant/const_data.dart';
import 'package:mersal/data/model/latest_products_model.dart';
import 'package:mersal/data/model/product_providers.dart';
import 'package:mersal/data/model/products_model.dart';
import '../../../data/model/category_model.dart';

class HomeController extends GetxController {
  // 🔹 متغيرات البيانات
  int activeIndex = 1;
  String? addressUser;
  StatusRequest statusRequest = StatusRequest.loading;
  String message = '';
  List<ProductModel> products = [];
  List<CategoryModel> categories = [];
  List<CategoryModel> filteredCategories = [];
  List<ProductProviderModel> productProviders = [];

  // 🔹 تحكم بالصفحات لمزودي الخدمة
  int currentPageProvider = 1;
  int lastPageProvider = 1;
  bool isLoadingMoreProvider = false;

  // 🔹 تحكم بالـ Scroll
  final ScrollController scrollController = ScrollController();
  final ScrollController categoryScrollController = ScrollController();

  // 🔹 بحث
  TextEditingController searchController = TextEditingController();
  bool isSearchActive = false;

  @override
  void onInit() {
    addressUser = ConstData.addressUser;

    getCategories();
    getProducts(perPage: 4);
    getProductProviders(isInitialLoad: true);

    // 🔁 ربط ScrollController الخاص بالقائمة الأفقية
    categoryScrollController.addListener(() {
      if (categoryScrollController.position.pixels >=
              categoryScrollController.position.maxScrollExtent - 100 &&
          !isLoadingMoreProvider &&
          currentPageProvider < lastPageProvider) {
        loadMoreProviders();
      }
    });

    super.onInit();
  }

  void setActiveIndex(int index) {
    activeIndex = index;
    update();
  }

  // 📦 جلب المزودين (مع ترقيم صفحات)
  Future<void> getProductProviders({bool isInitialLoad = false}) async {
    if (isInitialLoad) {
      statusRequest = StatusRequest.loading;
      currentPageProvider = 1;
      productProviders.clear();
      update();
    }

    isLoadingMoreProvider = true;
    update();

    final url = '${ApiLinks.getProductProviders}?page=$currentPageProvider';
    Crud crud = Crud();

    var response = await crud.getData(url, ApiLinks().getHeaderWithToken());

    response.fold(
      (failure) {
        statusRequest = StatusRequest.failure;
        message = failure == StatusRequest.offlineFailure
            ? 'تحقق من الاتصال بالإنترنت'
            : 'حدث خطأ أثناء تحميل المزودين';
        Get.snackbar('خطأ', message);
        isLoadingMoreProvider = false;
        update();
      },
      (data) {
        isLoadingMoreProvider = false;

        if (data != null && data is Map<String, dynamic>) {
          final parsed = ProductProvidersModel.fromJson(data);
          productProviders.addAll(parsed.data);
          currentPageProvider = parsed.pagination.currentPage;
          lastPageProvider = parsed.pagination.lastPage;
          statusRequest = StatusRequest.success;
        } else {
          message = 'استجابة غير صالحة من الخادم';
          statusRequest = StatusRequest.failure;
        }
        update();
      },
    );
  }

  // ⏭️ تحميل المزيد من المزودين
  void loadMoreProviders() {
    if (currentPageProvider < lastPageProvider) {
      currentPageProvider++;
      getProductProviders();
    }
  }

  // 🛍️ جلب المنتجات
  Future<void> getProducts({int perPage = 4}) async {
    statusRequest = StatusRequest.loading;
    update();

    Crud crud = Crud();
    final url = '${ApiLinks.latestProduct}?per_page=$perPage';

    var response = await crud.getData(url, ApiLinks().getHeaderWithToken());

    response.fold(
      (failure) {
        statusRequest = StatusRequest.failure;
        message = failure == StatusRequest.offlineFailure
            ? 'تحقق من الاتصال بالإنترنت'
            : 'حدث خطأ أثناء جلب المنتجات';
        Get.snackbar('خطأ', message);
        update();
      },
      (data) {
        if (data != null && data is List) {
          products = data.map((e) => ProductModel.fromJson(e)).toList();
          statusRequest = StatusRequest.success;
        } else {
          message = 'فشل في تحميل المنتجات';
          statusRequest = StatusRequest.failure;
        }
        update();
      },
    );
  }

  // 🗂️ جلب التصنيفات
  Future<void> getCategories() async {
    statusRequest = StatusRequest.loading;
    update();

    Crud crud = Crud();
    var response = await crud.post(
      '${ApiLinks.getCategories}?type=1',
      {},
      ApiLinks().getHeaderWithToken(),
    );

    response.fold(
      (failure) {
        statusRequest = StatusRequest.failure;
        message = failure == StatusRequest.offlineFailure
            ? 'تحقق من الاتصال بالإنترنت'
            : 'حدث خطأ أثناء تحميل التصنيفات';
        Get.snackbar('خطأ', message);
        update();
      },
      (data) {
        if (data != null && data is List) {
          categories = data.map((e) => CategoryModel.fromJson(e)).toList();
          filteredCategories = categories;
          statusRequest = StatusRequest.success;
        } else {
          message = 'فشل تحميل التصنيفات';
          categories.clear();
          filteredCategories.clear();
          statusRequest = StatusRequest.failure;
        }
        update();
      },
    );
  }

  @override
  void onClose() {
    scrollController.dispose();
    categoryScrollController.dispose();
    searchController.dispose();
    super.onClose();
  }
}
