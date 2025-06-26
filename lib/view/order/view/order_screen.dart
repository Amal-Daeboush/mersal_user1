import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mersal/core/class/status_request.dart';
import 'package:mersal/data/model/products_model.dart';
import 'package:mersal/view/order/controller/order_controller.dart';
import 'package:mersal/view/widgets/app%20bar/container_app_bar.dart';
import 'package:mersal/view/widgets/custom_loading.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/styles.dart';
import '../../widgets/custom_button_service.dart/service_button.dart';
import '../widget/card_four.dart';
import '../widget/card_one.dart';
import '../widget/card_three.dart';
import '../widget/card_two.dart';

class OrderScreen extends StatelessWidget {
  final ProductModel productModel;
  const OrderScreen({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor2,
      body: GetBuilder(
        init: OrderController(productModel: productModel),
        builder: (controller) {
          return Stack(
            children: [
              Opacity(
                opacity:
                    controller.statusRequest == StatusRequest.loading ? 0.5 : 1,
                child: Form(
                  //  key: controller.keyForm,
                  child: Column(
                    children: [
                      ContainerAppBar(
                        isSearch: false,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.shopping_cart_outlined,
                                size: 20,
                                color: AppColors.whiteColor,
                              ),
                              Text(
                                productModel.name,
                                style: Styles.style1.copyWith(
                                  color: AppColors.whiteColor,
                                ),
                              ),
                              IconButton(
                                onPressed: () => Get.back(),

                                icon: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CardOne(
                                  name: productModel.name,
                                  des: productModel.description,
                                  price: productModel.price,
                                ),
                                CardTwo(textEditingController: controller.note),
                                CardThree(
                                  price: productModel.price,
                                  productModel: productModel,
                                ),
                                productModel.providerableType ==
                                        'App\\Models\\Provider_Product'
                                    ? SizedBox()
                                    : CardFour(
                                      coupon: controller.coupoun,
                                      onCheckCoupon: controller.checkCoupon,
                                    ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Center(
                                    child: ServiceButton(
                                      title:
                                          productModel.providerableType ==
                                                  'App\\Models\\Provider_Product'
                                              ? 'اضف الى السلة'
                                              : 'الدفع عند الاستلام',
                                      onPressed: () async {
                                        productModel.providerableType ==
                                                'App\\Models\\Provider_Product'
                                            ? controller.addToCart(
                                              productModel,

                                              1,
                                            )
                                            : controller.orderService(
                                              productModel.id.toString(),
                                            );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (controller.statusRequest == StatusRequest.loading)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 150, vertical: 100),
                  child: Center(child: customLoadingIndictor()),
                ),
            ],
          );
        },
      ),
    );
  }
}
