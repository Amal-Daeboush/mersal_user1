import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mersal/model/product_order_model.dart';
import 'package:mersal/view/my%20order/view/details_order_screen.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/styles.dart';

class MyOrderCard extends StatelessWidget {
  /*   final String name;
  final String desc;
  final String image;
  final double price;
  final OrderStatus orderStatus; */
  final void Function()? cancel;
  final OrderProductModel myOrdersModel;
  const MyOrderCard({
    super.key,
    required this.myOrdersModel,
    this.cancel,
    /*    required this.name,
      required this.desc,
      required this.image,
      required this.price,
      required this.orderStatus */
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [AppColors.greyShadow],
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: AppColors.whiteColor,
          border: Border.all(color: AppColors.border),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment:
                MainAxisAlignment.center, // اجعل النص يصطف في الأعلى
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                   myOrdersModel.products!.first.productImages!.first.imageUrl.toString(),
                    height: 120.h,
                    width: 120.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ...myOrdersModel.products!
                        .map(
                          (product) => Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              
                                Text(
                                  '${product.productName}',
                                  style: Styles.style4.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.charcoalGrey,
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: ' السعر',
                                        style: Styles.style5.copyWith(
                                          color: AppColors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' : ${product.totalPrice} £',
                                        style: Styles.style5.copyWith(
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    SizedBox(height: 10.w),
                    if (myOrdersModel.coupons!.isNotEmpty)
                      ...myOrdersModel.coupons!.map(
                        (coupon) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Column(
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: ' استخدمت كوبون ${coupon.code}',
                                      style: Styles.style5.copyWith(
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
                  ],
                ),
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 100.h),

                  Row(
                    children: [
                      myOrdersModel.status == 'pending'
                          ? InkWell(
                            onTap: cancel,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.red,
                                borderRadius: BorderRadius.circular(5.r),
                                border: Border.all(color: AppColors.red),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                  horizontal: 10,
                                ),
                                child: Text(
                                  'الغاء',
                                  style: Styles.style5.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                          : SizedBox(),
                      SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 10,
                          ),
                          child: Text(
                            myOrdersModel.status == 'accepted'
                                ? 'مقبولة'
                                : myOrdersModel.status == 'pending'
                                ? 'نشطه'
                                : myOrdersModel.status == 'cancelled'
                                ? 'ملفاه'
                                : myOrdersModel.status == 'on_way'
                                ? 'قيد التوصيل'
                                : 'مكتملة',
                            style: Styles.style5.copyWith(
                              color:
                                  myOrdersModel.status == 'pending'
                                      ? AppColors.primaryColor
                                      : myOrdersModel.status == 'cancelled'
                                      ? AppColors.red
                                      : Colors.green,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.w),
                  GestureDetector(
                    onTap:
                        () => Get.to(
                          DetailsOrderScreen(
                            orderProductModel: myOrdersModel,
                            id: myOrdersModel.orderId.toString(),
                          ),
                        ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 10,
                        ),
                        child: Text(
                          'عرض تفاصيل الطلب',
                          style: Styles.style5.copyWith(color: Colors.green),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
