import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/styles.dart';


void showCouponDialog(
  BuildContext context,
  TextEditingController couponController,
  Function(BuildContext context) onCheckCoupon,
) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Center(child: Text('كوبون خصم', style: Styles.style1)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 40.h,
              child: TextField(
                controller: couponController,

                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(2),
                  hintText: 'ادخل الكوبون هنا',
                  helperStyle: Styles.style5.copyWith(
                    color: AppColors.greyColor,
                  ),
                  filled: true,
                  fillColor: AppColors.whiteColor2,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: AppColors.whiteColor2),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: AppColors.whiteColor2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: const BorderSide(color: AppColors.whiteColor2),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                //  String enteredCoupon = couponController.text.trim();
                //  validateCoupon(enteredCoupon, context);
                await onCheckCoupon(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 50,
                ),
                child: Text(
                  'تأكيد الكوبون',
                  style: Styles.style4.copyWith(color: AppColors.whiteColor),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
