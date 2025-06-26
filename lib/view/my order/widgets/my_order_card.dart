import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mersal/core/constant/app_image_asset.dart';
import 'package:mersal/data/model/product_order_model.dart';

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
                  child: Image.asset(
                    AppImageAsset.im1,
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
                    ...myOrdersModel.products
                        .map(
                          (product) => Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              '• ${product.productName}',
                              style: Styles.style4.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.charcoalGrey,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    SizedBox(height: 10.w),
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
                            text: ' : ${myOrdersModel.totalPrice} £',
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
                          SizedBox(width: 10,),
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
                            myOrdersModel.status == 'pending'
                                ? 'نشطه'
                                : myOrdersModel.status == 'cancelled'
                                ? 'ملفاه'
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
