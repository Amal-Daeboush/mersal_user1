import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mersal/core/class/helper_functions.dart';
import '../../../core/constant/app_colors.dart';
import '../field search/custom_field_search.dart';

class ContainerAppBar extends StatelessWidget {
  final TextEditingController? controller;
  final Widget? child;
  final bool isSearch;
  final double? radius;
  final Color? color;
  final double? height;
  final void Function(String)? onChanged;
  const ContainerAppBar({
    super.key,
    this.child,
    required this.isSearch,
    this.controller,
    this.onChanged, this.color, this.height, this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height:height?? HelperFunctions.screenHeight()/4,
      decoration:  BoxDecoration(
        color:color ??AppColors.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(radius??10),
          bottomRight: Radius.circular(radius??10),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              child!,
              SizedBox(height: 20.h),
              isSearch
                  ? CustomFieldSearch(
                    isorderScreen: false,
                    controller: controller,
                    onChanged: onChanged,
                  )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
