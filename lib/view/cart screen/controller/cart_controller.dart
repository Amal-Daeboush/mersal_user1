import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mersal/core/class/crud.dart';
import 'package:mersal/core/class/status_request.dart';
import 'package:mersal/core/constant/api_links.dart';
import 'package:mersal/core/sevices/sevices.dart';
import 'package:mersal/data/data_source/remote/api_remote.dart';
import 'package:mersal/data/model/cart_model.dart';
import 'package:mersal/view/my%20order/controller/my_orders_controller.dart';
import 'package:mersal/view/order/widget/coupon%20doilog/error_dialog.dart';
import 'package:mersal/view/order/widget/coupon%20doilog/succesful_dialog.dart';

class CartController extends GetxController {
  TextEditingController searchController = TextEditingController();
  StatusRequest statusRequest = StatusRequest.none;
  String message = '';
  List<CartModel> carts = [];
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  TextEditingController noteController = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController coupoun = TextEditingController();

  Future<void> orderCartProducts() async {
    if (carts.isEmpty) {
      Get.snackbar(
        'تنبيه',
        'السلة فارغة',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    statusRequest = StatusRequest.loading;
    update();

    Map<String, dynamic> body = {
      if (coupoun.text.trim().isNotEmpty) "coupon_code": coupoun.text.trim(),
      if (noteController.text.trim().isNotEmpty)
        "note": noteController.text.trim(),
      if (noteController.text.trim().isEmpty) "note": 'no notes',
      'products':
          carts.map((item) {
            return {
              "product_id": item.productModel.id.toString(),
              "quantity": item.quantityInCart,
            };
          }).toList(),
    };

    var response = await ApiRemote().orderProductModel(
      body,
      carts.first.productModel.id.toString(),
    );

    print("Response: $response");

    if (response is Map<String, dynamic>) {
      if (response['success'] == true && response.containsKey('order')) {
        final order = response['order'];
        final originalTotal = order['original_total_price'];
        final total = order['total_price'];
        final couponCode = order['coupon_code'];
        final couponDiscount = order['coupon_discount'];
        final products = order['products'] as List;

        String details = '✅ تم إنشاء الطلب بنجاح\n\n';
        details += '📦 المنتجات:\n';

        for (var product in products) {
          final name = product['product_name'];
          final qty = product['quantity'];
          final price = product['final_unit_price'];
          final totalItemPrice =
              (int.tryParse(qty.toString()) ?? 1) *
              (int.tryParse(price.toString()) ?? 0);
          details += '- $name × $qty = $totalItemPrice\n';
        }

        details += '\n💰 السعر الأصلي: $originalTotal';
        details += '\n🎯 السعر بعد الخصم: $total';

        if (couponCode != null && couponCode.toString().isNotEmpty) {
          details +=
              '\n🏷️ كوبون "$couponCode" تم استخدامه (خصم $couponDiscount)';
        }

        await Get.defaultDialog(
          title: 'تم الطلب بنجاح',
          middleText: details,
          confirm: ElevatedButton(
            onPressed: () {
              Get.back(); // يغلق الديالوج
              Get.back(); // يرجع للصفحة السابقة
            },
            child: Text('موافق'),
          ),
        );

        carts.clear();
        await MyServices().saveCartToStorage(carts);
        coupoun.clear();
        MyOrdersController myOrdersController = Get.find();
        myOrdersController.getOrderProduct();
        myOrdersController.getOrderServices();
        statusRequest = StatusRequest.success;
      } else {
        _handleOrderError(response);
      }
    } else if (response is String) {
      _showErrorSnackBar('خطأ', response);
      statusRequest = StatusRequest.failure;
    } else {
      _showErrorSnackBar('خطأ', 'فشل الاتصال بالخادم أو استجابة غير متوقعة');
      statusRequest = StatusRequest.failure;
    }

    update();
  }

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  Future<void> loadCart() async {
    statusRequest = StatusRequest.loading;
    update();
    try {
      carts = await MyServices().loadCartFromStorage();
      statusRequest = StatusRequest.success;
    } catch (e) {
      message = "حدث خطأ أثناء تحميل السلة";
      statusRequest = StatusRequest.failure;
    }
    update();
  }

  void increaseQuantity(int index) async {
    carts[index] = CartModel(
      productModel: carts[index].productModel,
      quantityInCart: carts[index].quantityInCart + 1,
    );
    await MyServices().saveCartToStorage(carts);
    update();
  }

  void decreaseQuantity(int index) async {
    final currentQty = carts[index].quantityInCart;
    if (currentQty <= 1) {
      carts.removeAt(index);
    } else {
      carts[index] = CartModel(
        productModel: carts[index].productModel,
        quantityInCart: currentQty - 1,
      );
    }
    await MyServices().saveCartToStorage(carts);
    update();
  }

  void removeItem(int index) async {
    carts.removeAt(index);
    await MyServices().saveCartToStorage(carts);
    update();
  }

  void _handleOrderError(Map<String, dynamic> response) {
    String errorMessages = '';

    if (response.containsKey('errors')) {
      final errors = response['errors'] as Map<String, dynamic>;
      for (var value in errors.values) {
        if (value is List) {
          errorMessages += value.join('\n') + '\n';
        } else {
          errorMessages += value.toString() + '\n';
        }
      }
    } else if (response.containsKey('message')) {
      errorMessages = response['message'];
    }

    _showErrorSnackBar(
      'خطأ',
      errorMessages.trim().isEmpty ? 'حدث خطأ غير متوقع' : errorMessages.trim(),
    );

    statusRequest = StatusRequest.failure;
  }

  void _showErrorSnackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
  }
   Future<void> checkCoupon(BuildContext context) async {
    statusRequest = StatusRequest.loading;
    update();

    Crud crud = Crud();
    final url = ApiLinks.checkCoupon;

    final response = await crud.post(url, {
      "code": coupoun.text,
    }, ApiLinks().getHeaderWithToken());

    response.fold(
      (failure) {
        statusRequest = StatusRequest.failure;
        message = 'فشل الاتصال بالخادم.';
        errorDialog(context);

        coupoun.clear();
        update();
      },
      (data) {
        if (data != null && data is Map) {
          if (data['success'] == true &&
              data['data'] != null &&
              data['data']['is_active'] == true) {
            statusRequest = StatusRequest.success;
            message = 'تم تفعيل الكوبون بنجاح!';
            successfulDialog(context); // ✅ نجاح
          } else {
            statusRequest = StatusRequest.failure;
            message = 'هذا الكوبون غير مفعل أو غير صالح.';

            errorDialog(context); // ⚠️ خطأ
            coupoun.clear();
          }
        } else {
          statusRequest = StatusRequest.failure;
          message = 'استجابة غير صالحة من الخادم.';
          errorDialog(context);
          coupoun.clear(); // ⚠️ خطأ
        }
        update();
      },
    );
  }
}
