import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mersal/core/class/status_request.dart';
import 'package:mersal/model/product_order_model.dart';
import 'package:mersal/view/my%20order/controller/details_order_conroller.dart';
import 'package:mersal/view/my%20order/widgets/details_order_app_bar.dart';
import 'package:mersal/view/my%20order/widgets/driver_info_card.dart';
import 'package:mersal/view/my%20order/widgets/product_info_card.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/styles.dart';

class DetailsOrderScreen extends StatelessWidget {
  final OrderProductModel orderProductModel;
  final String id;
  const DetailsOrderScreen({
    super.key,
    required this.id,
    required this.orderProductModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
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
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'رقم الطلب :  ',
                                  style: Styles.style6.copyWith(
                                    color: AppColors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: ' ${order.orderId}',
                                  style: Styles.style6.copyWith(
                                    color: AppColors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'الحالة :  ',
                                  style: Styles.style6.copyWith(
                                    color: AppColors.black,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      order.status == 'accepted'
                                          ? 'مقبولة'
                                          : order.status == 'pending'
                                          ? 'في  انتظار قبول مندوب التوصيل'
                                          : order.status == 'cancelled'
                                          ? 'ملفاه'
                                          : order.status == 'on_way'
                                          ? 'قيد التوصيل'
                                          : 'مكتملة',
                                  style: Styles.style6.copyWith(
                                    color:  order.status == 'pending'
                                      ? AppColors.primaryColor
                                      : order.status == 'cancelled'
                                      ? AppColors.red
                                      : Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (orderProductModel.coupons!.isNotEmpty)
                            ...orderProductModel.coupons!.map(
                              (coupon) => Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Column(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                                ' استخدمت كوبون ${coupon.code} ',
                                            style: Styles.style4.copyWith(
                                              color: AppColors.black,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                ' بقيمة ${coupon.discountPercent}% ',
                                            style: Styles.style5.copyWith(
                                              color: AppColors.red,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (order.deliveryFee != null)
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: ' قيمة التوصيل: ',
                                    style: Styles.style1.copyWith(
                                      color: AppColors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' ${order.deliveryFee}',
                                    style: Styles.style1.copyWith(
                                      color: AppColors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'سعر الطلب الاجمالي : ',
                                  style: Styles.style4.copyWith(
                                    color: AppColors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: ' ${order.totalPrice}',
                                  style: Styles.style6.copyWith(
                                    color: AppColors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),

                          orderProductModel.products!.isNotEmpty
                              ? Text("المنتجات المطلوبة:", style: Styles.style1)
                              : SizedBox(),
                          const SizedBox(height: 8),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                                  orderProductModel.products!
                                      .map(
                                        (product) =>
                                            ProductInfoCard(product: product),
                                      )
                                      .toList(),
                            ),
                          ),

                          const SizedBox(height: 10),
                          order.drivers!.isNotEmpty
                              ? Text("معلومات السائق", style: Styles.style1)
                              : SizedBox(),
                          order.drivers!.isNotEmpty
                              ? SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:
                                      order.drivers!
                                          .map(
                                            (driver) =>
                                                DriverInfoCard(driver: driver),
                                          )
                                          .toList(),
                                ),
                              )
                              : SizedBox(),
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
