import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_image_asset.dart';
import '../../../core/constant/styles.dart';

class RowDiscount extends StatelessWidget {
  const RowDiscount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.whiteColor3),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  AppImageAsset.discount,
                  height: 30,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              'خصومات',
              style: Styles.style5.copyWith(color: AppColors.black),
            )
          ],
        ),
        SizedBox(
          width: 10.w,
        ),
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.whiteColor3),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  AppImageAsset.cap,
                  height: 30,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              'كاش باك',
              style: Styles.style5.copyWith(color: AppColors.black),
            )
          ],
        )
      ],
    );
  }
}
