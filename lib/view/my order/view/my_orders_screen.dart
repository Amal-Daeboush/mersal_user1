// ignore_for_file: unused_local_variable

import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mersal/core/class/helper_functions.dart';
import 'package:mersal/core/class/status_request.dart';
import 'package:mersal/view/my%20order/controller/my_orders_controller.dart';
import 'package:mersal/view/my%20order/widgets/cancel_order_dialog.dart';
import 'package:mersal/view/my%20order/widgets/my_order_card.dart';
import 'package:mersal/view/my%20order/widgets/services_card.dart';
import 'package:mersal/view/widgets/custom_loading.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/styles.dart';

import '../widgets/my_orders_app_bar.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MyOrdersController myOrdersController = Get.put(MyOrdersController());
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              SizedBox(
                height: HelperFunctions.screenHeight(),
                width: HelperFunctions.screenWidth(),
                child: Stack(
                  children: [
                    Container(color: AppColors.primaryColor),
                    MyOrdersAppBar(),
                  ],
                ),
              ),

              GetBuilder<MyOrdersController>(
                //  init: MyOrdersController(),
                builder: (controller) {
                  return Positioned(
                    top: HelperFunctions.screenHeight() / 4.5,
                    child: Container(
                      height:
                          constraints.maxHeight -
                          (HelperFunctions.screenHeight() / 7),
                      width: HelperFunctions.screenWidth(),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            controller.statusRequest == StatusRequest.loading
                                ? Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 150,
                                    vertical: 100,
                                  ),
                                  child: Center(child: customLoadingIndictor()),
                                )
                                : SizedBox(
                                  height:
                                      constraints.maxHeight -
                                      (HelperFunctions.screenHeight() / 3.5),
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: ContainedTabBarView(
                                      tabBarProperties: TabBarProperties(
                                        height: 40,
                                        padding: EdgeInsets.only(bottom: 10),
                                        indicatorWeight: 1,
                                        labelStyle: Styles.style5.copyWith(
                                          color: AppColors.black,
                                        ),
                                        unselectedLabelStyle: Styles.style5
                                            .copyWith(color: AppColors.black),
                                        indicatorColor: AppColors.primaryColor,
                                      ),
                                      tabs: const [
                                        Text('جميع الطلبات'),
                                        Text('جميع الحجوزات'),
                                        Text('النشطه'),
                                        Text('المكتمله'),
                                        Text('الملغاه'),
                                      ],
                                      views: [
                                        controller.productOrders.isEmpty &&
                                                controller
                                                    .servicesOrders
                                                    .isEmpty
                                            ? Center(
                                              child: Text('لا يوجد طلبات'),
                                            )
                                            : ListView(
                                              children: [
                                                ...controller.productOrders
                                                    .map(
                                                      (e) => MyOrderCard(
                                                          cancel: () {
                                                          CancelOrderDialog(
                                                            context,
                                                            e.id.toString(),
                                                          );
                                                        },
                                                        myOrdersModel: e,
                                                      ),
                                                    )
                                                    .toList(),
                                              ],

                                              //   itemCount: controller.productOrders.length+controller.servicesOrders.length,
                                            ),
                                        //حجوزانت
                                        controller.productOrders.isEmpty &&
                                                controller
                                                    .servicesOrders
                                                    .isEmpty
                                            ? Center(
                                              child: Text('لا يوجد حجوزات'),
                                            )
                                            : ListView(
                                              children: [
                                                ...controller.servicesOrders
                                                    .map(
                                                      (e) => ServiceOrderCard(
                                                        serviceModel: e,
                                                      ),
                                                    )
                                                    .toList(),
                                              ],

                                              //   itemCount: controller.productOrders.length+controller.servicesOrders.length,
                                            ),
                                        // الطلبات النشطة
                                        controller.activeOrders.isEmpty &&
                                                controller
                                                    .servicesactiveOrders
                                                    .isEmpty
                                            ? Center(
                                              child: Text(
                                                ' لا يوجد طلبات نشطة',
                                              ),
                                            )
                                            : ListView(
                                              children: [
                                                ...controller.activeOrders
                                                    .map(
                                                      (e) => MyOrderCard(
                                                        cancel: () {
                                                          CancelOrderDialog(
                                                            context,
                                                            e.id.toString(),
                                                          );
                                                        },
                                                        myOrdersModel: e,
                                                      ),
                                                    )
                                                    .toList(),
                                                ...controller
                                                    .servicesactiveOrders
                                                    .map(
                                                      (e) => ServiceOrderCard(
                                                        serviceModel: e,
                                                      ),
                                                    )
                                                    .toList(),
                                              ],
                                            ),

                                        // الطلبات المكتملة
                                        controller.coupletOrders.isEmpty &&
                                                controller
                                                    .servicescoupletOrders
                                                    .isEmpty
                                            ? Center(
                                              child: Text(
                                                ' لا يوجد طلبات مكتملة',
                                              ),
                                            )
                                            : ListView(
                                              children: [
                                                ...controller.coupletOrders
                                                    .map(
                                                      (e) => MyOrderCard(
                                                        myOrdersModel: e,
                                                      ),
                                                    )
                                                    .toList(),
                                                ...controller
                                                    .servicescoupletOrders
                                                    .map(
                                                      (e) => ServiceOrderCard(
                                                        serviceModel: e,
                                                      ),
                                                    )
                                                    .toList(),
                                              ],
                                            ),

                                        // الطلبات الملغاة
                                        controller.cancelOrders.isEmpty &&
                                                controller
                                                    .servicescancelOrders
                                                    .isEmpty
                                            ? Center(
                                              child: Text(
                                                ' لا يوجد طلبات ملغاة',
                                              ),
                                            )
                                            : ListView(
                                              children: [
                                                ...controller.cancelOrders
                                                    .map(
                                                      (e) => MyOrderCard(
                                                        myOrdersModel: e,
                                                      ),
                                                    )
                                                    .toList(),
                                                ...controller
                                                    .servicescancelOrders
                                                    .map(
                                                      (e) => ServiceOrderCard(
                                                        serviceModel: e,
                                                      ),
                                                    )
                                                    .toList(),
                                              ],
                                            ),
                                      ],
                                    ),
                                  ),
                                ),

                            //  SizedBox(height: 200,)
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
