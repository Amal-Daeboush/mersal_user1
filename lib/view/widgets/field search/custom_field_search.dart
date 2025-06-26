import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/app_colors.dart';

class CustomFieldSearch extends StatelessWidget {
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final bool isorderScreen;
  const CustomFieldSearch({super.key, required this.isorderScreen, this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isorderScreen?250.w:200.w,
      height: 40.h,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: TextFormField(
          onChanged: onChanged,
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor:isorderScreen?AppColors.whiteColor3: AppColors.whiteColor,
            hintText: 'ابحث هنا',
            prefixIcon: const Icon(
              Icons.search,
              color: AppColors.charcoalGrey,
              size: 15, // حجم الأيقونة
            ),
            hintStyle: TextStyle(
              color:isorderScreen?AppColors.charcoalGrey: Colors.grey,
              fontSize: 16.sp, // حجم النص
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:  BorderSide(color:isorderScreen? AppColors.whiteColor3:AppColors.whiteColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: AppColors.primaryColor),
            ),
            enabledBorder:  OutlineInputBorder(
              borderSide: BorderSide(color: isorderScreen? AppColors.whiteColor3:AppColors.whiteColor),
            ),
          ),
        ),
      ),
    );
  }
}
