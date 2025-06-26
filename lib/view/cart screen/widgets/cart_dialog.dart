import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mersal/core/constant/app_colors.dart';
import 'package:mersal/core/constant/styles.dart';
import 'package:mersal/view/cart%20screen/controller/cart_controller.dart';
import 'package:mersal/view/order/widget/card_four.dart';

void showOrderDialogWithCoupon({
  required BuildContext context,
  required CartController controller,
}) {
  bool hasCoupon = false;
  TextEditingController couponController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Center(child: Text('إتمام الطلب', style: Styles.style1)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('هل لديك ملاحظات او طلبات خاصة ', style: Styles.style1),
                SizedBox(height: 5.h,),
                SizedBox(
                  height: 45.h,
                  child: TextField(
                    controller: noteController,
                    decoration: InputDecoration(
                      hintText: 'ادخل الطلبات هنا',
                      helperStyle: Styles.style5.copyWith(
                        color: AppColors.greyColor,
                        fontSize: 8.sp
                      ),
                      filled: true,
                      fillColor: AppColors.whiteColor2,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: AppColors.whiteColor2,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: AppColors.whiteColor2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: const BorderSide(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                CardFour(
                  coupon: controller.coupoun,
                  onCheckCoupon: controller.checkCoupon,
                ),

                SizedBox(height: 20.h),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      controller.noteController.text =
                          noteController.text.trim(); // إغلاق الديالوج
                      controller.orderCartProducts();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 40,
                      ),
                      child: Text(
                        'تأكيد الطلب',
                        style: Styles.style4.copyWith(
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
