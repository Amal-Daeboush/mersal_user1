import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mersal/model/service_revestion_model.dart'
    as service_revestion_model;

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/styles.dart';

class ServiceOrderCard extends StatelessWidget {
  /*   final String name;
  final String desc;
  final String image;
  final double price;
  final OrderStatus orderStatus; */
  final service_revestion_model.ServiceReservationModel serviceModel;
  const ServiceOrderCard({
    super.key,
    required this.serviceModel,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    serviceModel.product.images.first.imag,
                    height: 120.h,
                    width: 120.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                // يسمح للنص بالتوسّع ضمن المساحة المتاحة
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,

                  ///
                  children: [
                    Text(
                      serviceModel.product.name,
                      style: Styles.style4.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.charcoalGrey,
                      ),
                    ),
                    Text(
                      serviceModel.product.description,
                      style: Styles.style5.copyWith(
                        color: AppColors.primaryColorBold,
                      ),
                      softWrap: true, // السماح بلف النص
                    ),

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
                            text: ' : 200 £',
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
                        serviceModel.status == 'pending'
                            ? 'نشطه'
                            : serviceModel.status == 'cancelled'
                            ? 'ملفاه'
                            : 'مكتملة',
                        style: Styles.style5.copyWith(
                          color:
                              serviceModel.status == 'pending'
                                  ? AppColors.primaryColor
                                  : serviceModel.status == 'cancelled'
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
        ),
      ),
    );
  }
}
