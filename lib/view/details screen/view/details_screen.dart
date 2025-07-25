import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mersal/core/class/status_request.dart';
import 'package:mersal/core/constant/styles.dart';
import 'package:mersal/data/model/products_model.dart';
import 'package:mersal/view/details%20screen/controller/details_controller.dart';
import 'package:mersal/view/details%20screen/widgets/add%20rate%20doilog/enter_dialog.dart';
import 'package:mersal/view/order/view/order_screen.dart';
import 'package:mersal/view/widgets/custom_loading.dart';
import '../widgets/details/details_service.dart';
import '../widgets/order_button.dart';
import '../widgets/tap bar/custom_tab_bar.dart';
import '../widgets/top/service_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsScreen extends StatelessWidget {
  final ProductModel productModel;
  const DetailsScreen({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    DetailsController detailsController = Get.put(
      DetailsController(id: productModel.id, productModel: productModel),
    );
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: GetBuilder(
        init: DetailsController(
          id: productModel.id,
          productModel: productModel,
        ),
        builder: (controller) {
          return SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    ServiceImage(
                      screenWidth,
                      screenHeight,
                      productModel.providerableType ==
                              'App\\Models\\Provider_Product'
                          ? false
                          : true,
                      controller.productProviderModel?.vendor.user.id ?? 1,
                      controller.productProviderModel?.vendor.user.name ?? '',
                    ),
                    // details
                    Positioned(
                      top: screenHeight / 3.5,
                      child: Container(
                        width: screenWidth,
                        height: constraints.maxHeight - (screenHeight / 3.5),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    DetailsService(
                                      productModel: productModel,
                                      provider:
                                          controller
                                              .productProviderModel
                                              ?.vendor
                                              .user
                                              .name,
                                    ),

                                    //
                                    // tab bar
                                    controller.statusRequest ==
                                            StatusRequest.loading
                                        ? Center(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 130.w,
                                              vertical: 15.h,
                                            ),
                                            child: customLoadingIndictor(),
                                          ),
                                        )
                                        : controller.statusRequest ==
                                            StatusRequest.failure
                                        ? CustomTabBar(
                                          message: controller.message,
                                          ratings: controller.ratings,
                                          height: constraints.maxHeight / 2.5,
                                        )
                                        : controller.statusRequest ==
                                            StatusRequest.offlineFailure
                                        ? CustomTabBar(
                                          message: controller.message,
                                          ratings: controller.ratings,
                                          height: constraints.maxHeight / 2.5,
                                        )
                                        : CustomTabBar(
                                          ratings: controller.ratings,
                                          height: constraints.maxHeight / 2.5,
                                        ),
                                  ],
                                ),
                              ),
                            ),

                            //button
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 5,
                                right: 4,
                                left: 3,
                              ),
                              child: Row(
                                children: [
                                  OrderButton(
                                    isprimary: false,
                                    title: ' اضف تقييم',
                                    onPressed: () {
                                      showRateDialog(
                                        context,
                                        productModel.id.toString(),
                                      );
                                    },
                                  ),
                                  SizedBox(width: 20.w),
                                  Expanded(
                                    child: OrderButton(
                                      isprimary: true,
                                      title: 'اطلب الان',
                                      onPressed:
                                          () => Get.off(
                                            OrderScreen(
                                              productModel: productModel,
                                            ),
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
