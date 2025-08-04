import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mersal/core/class/crud.dart';
import 'package:mersal/core/class/status_request.dart';
import 'package:mersal/core/constant/api_links.dart';
import 'package:mersal/model/food_provider_model.dart';
import 'package:mersal/model/food_type_model.dart';
import 'package:mersal/model/products_model.dart';

class RestaurantsController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest statusRequestProviders = StatusRequest.none;
  TextEditingController searchController=TextEditingController();
  FoodTypeModel? selectedType;
  List<FoodTypeModel> foodtypes = [];
  List<FoodProviderModel> foodProviders = [];
  List<ProductModel> allProducts = []; // كل المنتجات

  String message = '';
  final int id;
  @override
  void onInit() {
    // أولاً: استدعاء super
    super.onInit();

    // ثانياً: جلب أنواع الطعام
    getFoodTypes(); // بداخلها يتم جلب المنتجات

    // ثالثاً: إعداد الـ scroll listener للتحميل عند الوصول للأسفل
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 100 &&
          !isLoadingMore &&
          currentPage < lastPage) {
        loadMore();
      }
    });
  }

void updateCategory(FoodTypeModel type) {
  selectedType = type;
  applyFilter(); // ← فلترة فورية عند التغيير
}


  Future<void> getFoodTypes() async {
    statusRequest = StatusRequest.loading;
    update();

    Crud crud = Crud();
    var response = await crud.getData(
      '${ApiLinks.foodTypes}',
      ApiLinks().getHeaderWithToken(),
    );

    response.fold(
      (failure) {
        statusRequest = StatusRequest.failure;
        message =
            failure == StatusRequest.offlineFailure
                ? 'تحقق من الاتصال بالانترنت'
                : 'حدث خطأ';
        Get.snackbar('خطأ', message, snackPosition: SnackPosition.TOP);
        foodtypes = [];
        update();
      },
      (data) async {
        if (data != null && data["data"] is List) {
          List list = data["data"];
          if (list.isNotEmpty) {
            foodtypes = [
              FoodTypeModel(
                id: -1,
                title: 'الكل',
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              ),
              ...list.map((e) => FoodTypeModel.fromJson(e)),
            ];
            selectedType = foodtypes[0];
            await getProduct(); // تحميل كل المنتجات
            statusRequest = StatusRequest.success;
          } else {
            foodtypes = [];
            statusRequest = StatusRequest.failure;
          }
        } else {
          foodtypes = [];
          statusRequest = StatusRequest.failure;
        }
        update();
      },
    );
  }

  StatusRequest statusRequestfood = StatusRequest.loading;
  bool isSearchActive = false;

  List<ProductModel> products = [];
  int currentPage = 1;
  int lastPage = 1;
  int activeIndex = 1;
  bool isLoadingMore = false;

  final ScrollController scrollController = ScrollController();

  RestaurantsController({required this.id});

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
 // طباعة الاستجابة
  print('Response: $response'); 
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

 void applyFilter() {
  if (selectedType == null || selectedType!.title == 'الكل') {
    products = [...allProducts];
  } else {
    products = allProducts
        .where((p) => p.foodType == selectedType!.title)
        .toList();
  }
  update(); // ← ضروري لتحديث الواجهة بعد الفلترة
}


  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  List<FoodProviderModel> get filteredRestaurants {
    if (selectedType == null || selectedType!.title == "الكل") {
      return foodProviders;
    }
    return foodProviders.where((r) => r.user == selectedType!.title).toList();
  }
}
