import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mersal/core/class/helper_functions.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/styles.dart';

class CardTwo extends StatelessWidget {
  final TextEditingController textEditingController;
  const CardTwo({super.key, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Container(
        width: HelperFunctions.screenWidth(),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: AppColors.whiteColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'طلبات خاصه',
                style: Styles.style1.copyWith(
                  color: AppColors.primaryColorBold,
                ),
              ),

              Text(
                'اى طلبات خاصه؟',
                style: Styles.style5.copyWith(
                  color: AppColors.primaryColorBold,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'هل هناك اى شيء اخر نحتاج الى معرفته',
                style: Styles.style5.copyWith(
                  color: AppColors.primaryColorBold,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                constraints: BoxConstraints(
                  maxWidth: 200.w, // Limit the width of the container
                ),
                child: TextFormField(
                  controller: textEditingController,
                  maxLines: 4, // Allows the TextField to grow up to 4 lines
                  minLines: 3, // Allows the TextField to shrink to 1 line
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 10,
                    ),
                    hintText: 'اكتب طلبك هنا',
                    hintStyle: Styles.style4,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: AppColors.primaryColorBold),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: AppColors.primaryColorBold),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: AppColors.primaryColorBold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
