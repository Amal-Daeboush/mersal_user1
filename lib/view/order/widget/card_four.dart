import 'package:flutter/material.dart';

import '../../../core/constant/app_colors.dart';

import 'coupon doilog/enter_dialog.dart';

class CardFour extends StatelessWidget {
  final TextEditingController coupon;
    final Future<void> Function(BuildContext context) onCheckCoupon;
  const CardFour({super.key, required this.coupon, required this.onCheckCoupon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.percent,
                    size: 20,
                    color: Colors.purple,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'إضافة كوبون خصم',
                    style: TextStyle(
                        color: AppColors.primaryColorBold,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  showCouponDialog(context,coupon,onCheckCoupon);
                },
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: AppColors.primaryColor,
                  ),
                  child:  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: Text(
                  coupon.text.isEmpty?   'إضافة':'تم الاضافة',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
