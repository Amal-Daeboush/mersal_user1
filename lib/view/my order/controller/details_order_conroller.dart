import 'package:get/get.dart';
import 'package:mersal/core/class/status_request.dart';
import 'package:mersal/model/details_order.dart';
import '../../../core/class/crud.dart';
import '../../../core/constant/api_links.dart';

class DetailsOrderController extends GetxController {
  final String id;
  StatusRequest statusRequest = StatusRequest.none;
  bool isLoading = false;
  String message = '';

  DetailsOrderModel? detailsOrderModel;

  DetailsOrderController({required this.id});

  Future<void> trackOrder() async {
    statusRequest = StatusRequest.loading;
    update();

    Crud crud = Crud();
    var response = await crud.post(
      '${ApiLinks.track_order}/${id}',
      {},
      ApiLinks().getHeaderWithToken(),
    );

    response.fold(
      (failure) {
        statusRequest = failure;
        message =
            failure == StatusRequest.offlineFailure
                ? 'تحقق من الاتصال بالانترنت'
                : 'حدث خطأ أثناء الاتصال بالخادم';

        Get.snackbar('خطأ', message, snackPosition: SnackPosition.TOP);
        update();
      },
      (data) async {
        print("🎯 Response: $data");

        if (data is Map && data.containsKey('order')) {
          detailsOrderModel = DetailsOrderModel.fromJson(
            // ignore: unnecessary_cast
            (data as Map).cast<String, dynamic>(),
          );
          statusRequest = StatusRequest.success;
        } else if (data.containsKey('message')) {
          // حالة "No driver has accepted..."
          message = data['message'] ?? 'لم يتم قبول الطلب بعد';
          detailsOrderModel = DetailsOrderModel.fromJson(
            (data as Map).cast<String, dynamic>(),
          );
          statusRequest = StatusRequest.success;
        } else {
          statusRequest = StatusRequest.failure;
          message = 'فشل في تحميل بيانات الطلب';
          Get.snackbar('خطأ', message, snackPosition: SnackPosition.BOTTOM);
        }

        update();
      },
    );
  }
  @override
  void onInit() {
trackOrder();
    super.onInit();
  }
}
