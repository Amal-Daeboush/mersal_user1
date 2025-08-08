import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomChatShimmer extends StatelessWidget {
  const CustomChatShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListTile(
        leading: CircleAvatar(
          radius: 25.r,
          backgroundColor: Colors.white,
        ),
        title: Container(
          height: 15.h,
          width: 100.w,
          color: Colors.white,
          margin: EdgeInsets.only(bottom: 6.h),
        ),
        subtitle: Container(
          height: 12.h,
          width: 150.w,
          color: Colors.white,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 12.h,
              width: 50.w,
              color: Colors.white,
            ),
            SizedBox(height: 5.h),
            Container(
              height: 20.h,
              width: 25.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
