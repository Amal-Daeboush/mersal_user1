import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/constant/app_colors.dart';

class ServiceOrderCardShimmer extends StatelessWidget {
  const ServiceOrderCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) => SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              boxShadow: [AppColors.greyShadow],
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.white,
              border: Border.all(color: AppColors.border),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 120.h,
                      width: 120.w,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 15.h,
                          width: 120.w,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          height: 14.h,
                          width: 180.w,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          height: 12.h,
                          width: 100.w,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(height: 100.h),
                      Container(
                        height: 20.h,
                        width: 60.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),itemCount: 10,);
  }
}
