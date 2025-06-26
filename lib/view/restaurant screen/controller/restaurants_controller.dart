import 'package:get/get.dart';
import 'package:mersal/core/class/crud.dart';
import 'package:mersal/core/class/status_request.dart';
import 'package:mersal/core/constant/api_links.dart';
import 'package:mersal/data/model/food_provider_model.dart';
import 'package:mersal/data/model/food_type_model.dart';

class RestaurantsController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest statusRequestProviders = StatusRequest.none;
  FoodTypeModel? selectedType;
  List<FoodTypeModel> foodtypes = [];
  List<FoodProviderModel> foodProviders = [];
  String message = '';
  @override
  void onInit() {
    getFoodTypes();
    super.onInit();
  }

   updateCategory(FoodTypeModel type) {
    selectedType = type;
    update();
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
      message = failure == StatusRequest.offlineFailure
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
          foodtypes = list.map((e) => FoodTypeModel.fromJson(e)).toList();
          selectedType = foodtypes[0];
          await getFoodProviders(); // ✅ تحميل المطاعم مباشرة
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


  Future<void> getFoodProviders() async {
    statusRequestProviders = StatusRequest.loading;
    update();

    Crud crud = Crud();
    var response = await crud.getData(
      '${ApiLinks.getProvidersByFoodType}/${selectedType!.id}',
      ApiLinks().getHeaderWithToken(),
    );

    response.fold(
      (failure) {
        statusRequestProviders = StatusRequest.failure;
        message =
            failure == StatusRequest.offlineFailure
                ? 'تحقق من الاتصال بالانترنت'
                : 'حدث خطأ';
        Get.snackbar('Error', message, snackPosition: SnackPosition.TOP);
        update();
        foodProviders = [];
      },
      (data) {
        if (data != null && data is Map<String, dynamic>) {
          var foodtypesList = data["providers"];
          if (foodtypesList is List && foodtypesList.isNotEmpty) {
            foodProviders =
                foodtypesList
                    .map<FoodProviderModel>(
                      (item) => FoodProviderModel.fromJson(item),
                    )
                    .toList();
            statusRequestProviders = StatusRequest.success;
          } else {
            message = 'لا توجد اصناف طعام';
            foodProviders = [];
            statusRequestProviders = StatusRequest.failure;
            Get.snackbar('تنبيه', message, snackPosition: SnackPosition.BOTTOM);
          }
        } else {
          message = 'حدث خطأ في جلب البيانات';
          foodProviders = [];
          statusRequestProviders = StatusRequest.failure;
          Get.snackbar('خطأ', message, snackPosition: SnackPosition.BOTTOM);
        }
        update();
      },
    );
  }


  List<FoodProviderModel> get filteredRestaurants {
  if (selectedType == null || selectedType!.title == "الكل") {
    return foodProviders;
  }
  return foodProviders
      .where((r) => r.user == selectedType!.title)
      .toList();
}

}

