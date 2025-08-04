import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mersal/core/class/helper_functions.dart';
import 'package:mersal/core/class/status_request.dart';
import 'package:mersal/view/my%20order/controller/details_order_conroller.dart';
import 'package:mersal/view/my%20order/widgets/details_order_app_bar.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/styles.dart';

class DetailsOrderScreen extends StatelessWidget {
  final String id;
  const DetailsOrderScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const DetailsOrderAppBar(),
            SizedBox(height: 10.h),
            GetBuilder<DetailsOrderController>(
              init: DetailsOrderController(id: id),
              builder: (controller) {
                if (controller.statusRequest == StatusRequest.loading) {
                  return const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (controller.statusRequest == StatusRequest.success) {
                  final order = controller.detailsOrderModel?.order;
                  if (order == null) {
                    return const Expanded(
                      child: Center(child: Text("لا توجد معلومات طلب.")),
                    );
                  }

                  return Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(16.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "رقم الطلب: ${order.orderId}",
                            style: Styles.style6,
                          ),
                          Text("الحالة: ${order.status}", style: Styles.style1),
                          Text(
                            "الإجمالي: ${order.totalPrice}",
                            style: Styles.style1,
                          ),
                          const SizedBox(height: 10),

                          order.products!.isNotEmpty
                              ? Text("المنتجات:", style: Styles.style1)
                              : SizedBox(),
                          const SizedBox(height: 8),

                          ...order.products!.map(
                            (product) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Container(
                                width: HelperFunctions.screenWidth(),
                               decoration:  BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                child: Text(
                                  "${product.name} - الكمية: ${product.quantity} - السعر: ${product.price ?? ''}",
                                  style: Styles.style5,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),
                          order.drivers!.isNotEmpty
                              ? Text("معلومات السائق", style: Styles.style1)
                              : SizedBox(),
                          const SizedBox(height: 8),
                          if (order.drivers != null)
                            ...order.drivers!.map(
                              (driver) => Container(
                                width: HelperFunctions.screenWidth(),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "الاسم: ${driver.driverName}",
                                        style: Styles.style5,
                                      ),
                                      Text(
                                        "الهاتف: ${driver.phone}",
                                        style: Styles.style5,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Center(child: Text(controller.message)),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
