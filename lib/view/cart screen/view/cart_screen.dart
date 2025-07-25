import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mersal/core/class/status_request.dart';
import 'package:mersal/core/constant/styles.dart';
import 'package:mersal/view/cart%20screen/controller/cart_controller.dart';
import 'package:mersal/view/cart%20screen/widgets/cart_app_bar.dart';
import 'package:mersal/view/cart%20screen/widgets/cart_card.dart';
import 'package:mersal/view/cart%20screen/widgets/cart_dialog.dart';
import 'package:mersal/view/widgets/custom_button_service.dart/service_button.dart';
import 'package:mersal/view/widgets/custom_loading.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<CartController>(
          init: CartController(),
          builder: (controller) {
            Widget content;

            if (controller.statusRequest == StatusRequest.loading) {
              content = Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 130.w,
                    vertical: 15.h,
                  ),
                  child: customLoadingIndictor(),
                ),
              );
            } else if (controller.carts.isEmpty) {
              content = Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: Text(
                    'السلة فارغة حالياً 🛒',
                    style: Styles.style1.copyWith(color: Colors.grey),
                  ),
                ),
              );
            } else {
              content = Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.carts.length,
                      itemBuilder: (context, index) {
                        final cartItem = controller.carts[index];
                        return CartCard(
                          cartModel: cartItem,
                          onAdd: () => controller.increaseQuantity(index),
                          onRemove: () => controller.decreaseQuantity(index),
                          onDelete: () => controller.removeItem(index),
                        );
                      },
                    ),
                  ),
                ),
              );
            }

            return Column(
              children: [
                CartAppBar(
                  controller: controller.searchController,
                  onChanged: (value) {
                    // يمكنك تفعيل البحث لاحقاً هنا
                  },
                ),
                SizedBox(height: 10.h),
                content,
                if (controller.carts.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Center(
                      child: ServiceButton(
                        title: 'اطلب الآن',
                        onPressed: () {
                          showOrderDialogWithCoupon(
                            context: context,
                            controller: controller,
                          );
                        },
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
