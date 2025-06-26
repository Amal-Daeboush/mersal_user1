import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_image_asset.dart';
import '../../../core/constant/styles.dart';

class CardOne extends StatelessWidget {
  final String name;
  final String des;
  final String price;
  const CardOne({
    super.key,
    required this.name,
    required this.des,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: AppColors.whiteColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start, // اجعل النص يصطف في الأعلى
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(AppImageAsset.im2, height: 90),
            ),
            SizedBox(width: 10.w),
            Expanded(
              // يسمح للنص بالتوسّع ضمن المساحة المتاحة
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // لتجنب التوسّط
                children: [
                  Text(
                    name,
                    style: Styles.style4.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.charcoalGrey,
                    ),
                  ),
                  Text(
                    des,
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
                          text: 'السعر :',
                          style: Styles.style5.copyWith(color: AppColors.black),
                        ),
                        TextSpan(
                          text: ' $price £',
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
          ],
        ),
      ),
    );
  }
}
