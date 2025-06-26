import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mersal/core/class/crud.dart';
import 'package:mersal/core/class/status_request.dart';
import 'package:mersal/core/constant/api_links.dart';
import 'package:mersal/core/constant/styles.dart';
import 'package:mersal/core/sevices/sevices.dart';
import 'package:mersal/data/data_source/remote/api_remote.dart';
import 'package:mersal/data/model/cart_model.dart';
import 'package:mersal/data/model/products_model.dart';
import 'package:mersal/view/order/widget/coupon%20doilog/error_dialog.dart';
import 'package:mersal/view/order/widget/coupon%20doilog/succesful_dialog.dart';

class OrderController extends GetxController {
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  StatusRequest statusRequest = StatusRequest.none;
  final ProductModel productModel;
  TextEditingController note = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController coupoun = TextEditingController();
  OrderController({required this.productModel});

  //add to cart
  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  List<CartModel> carts = [];
  Future<void> loadCart() async {
    carts = await MyServices().loadCartFromStorage();
    update();
  }

  Future<void> addToCart(ProductModel product, int quantity) async {
    try {
      int existingIndex = carts.indexWhere(
        (item) => item.productModel.id == product.id,
      );

      if (existingIndex != -1) {
        carts[existingIndex] = CartModel(
          productModel: product,
          quantityInCart: carts[existingIndex].quantityInCart + quantity,
        );
      } else {
        carts.add(CartModel(productModel: product, quantityInCart: quantity));
      }

      // تحديث SharedPreferences
      await MyServices().saveCartToStorage(carts);
      await Get.defaultDialog(
        middleText: 'تم الاضافة الى السلة بنجاح',
        titleStyle: Styles.style1,
        title: 'نجاح',
        confirm: ElevatedButton(
          onPressed: () {
            Get.back();
            Get.back();
          },
          child: Text('حسناً'),
        ),
      );
      update(); // تحديث الواجهة
    } catch (e) {
      print('Error adding to cart: $e');
    }
  }

  orderService(String id) async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await ApiRemote().orderServiceModel({
      if (coupoun.text.trim().isNotEmpty) "coupon_code": coupoun.text.trim(),
      if (note.text.trim().isNotEmpty) "note": note.text.trim(),
      if (note.text.trim().isEmpty) "note": 'no notes',
      'product_id': id,
    }, id);

    print("Response: $response");

    if (response is Map<String, dynamic>) {
      final bool success = response['success'] == true;

      if (success && response.containsKey('reservation')) {
        // ✅ الحجز ناجح – عرض الديالوج
        final reservation = response['reservation'];

        // استخراج المعلومات
        final total = reservation['total_price'];
        final original = reservation['original_price'];
        final couponCode = reservation['coupon_code'];
        final couponValue = reservation['coupon_discount'];

        String details = '''
تمت العملية بنجاح ✅
السعر الأصلي: $original
السعر بعد الخصم: $total
''';

        if (couponCode != null) {
          details += 'كوبون "$couponCode" تم استخدامه، الخصم: $couponValue';
        }

        await Get.defaultDialog(
          title: 'تم الحجز بنجاح',
          middleText: details,
          confirm: ElevatedButton(
            onPressed: () {
              Get.back(); // يغلق الديالوج
              Get.back(); // يرجع صفحة واحدة
            },
            child: Text('حسناً'),
          ),
        );

        statusRequest = StatusRequest.success;
      } else {
        // ❌ فشل منطقي: success = false
        String errorMessage = '';

        // 1. خطأ موجود في key `errors`
        if (response.containsKey('errors')) {
          final errors = response['errors'] as Map<String, dynamic>;
          for (var value in errors.values) {
            if (value is List) {
              errorMessage += value.join('\n') + '\n';
            } else {
              errorMessage += value.toString() + '\n';
            }
          }
        }
        // 2. أو خطأ في `message`
        else if (response.containsKey('message')) {
          errorMessage = response['message'];
        }

        // عرض الخطأ برسالة مفصلة
        Get.snackbar(
          'فشل الحجز',
          errorMessage.trim().isEmpty
              ? 'حدث خطأ غير متوقع'
              : errorMessage.trim(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );

        statusRequest = StatusRequest.failure;
      }
    } else {
      // ❌ لم يتم استلام Map أصلاً
      Get.snackbar(
        'خطأ',
        'فشل الاتصال بالخادم أو استجابة غير متوقعة',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );

      statusRequest = StatusRequest.failure;
    }

    quantity.clear();
    update();
  }

  String message = '';
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
