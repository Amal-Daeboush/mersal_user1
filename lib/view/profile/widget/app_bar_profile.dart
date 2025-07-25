import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mersal/core/constant/const_data.dart';
import 'package:mersal/view/widgets/app%20bar/container_app_bar.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_image_asset.dart';
import '../../../core/constant/styles.dart';


class AppBarProfile extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String name;
  const AppBarProfile({super.key, this.controller, this.onChanged, required this.name});

  @override
  Widget build(BuildContext context) {
    return ContainerAppBar(
      height: 150.h,
      radius: 20,
      controller: controller,
      onChanged: onChanged,
      color: AppColors.whiteColor,
      isSearch: false,
      child: Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CircleAvatar(
            radius: 21.r,
            backgroundImage: AssetImage(AppImageAsset.profile),
          ),
          SizedBox(width: 15.w),
          Text(
           name,
            style: Styles.style1.copyWith(color: AppColors.primaryColorBold),
          ),
          Spacer(),
          Image.asset(AppImageAsset.logo, height: 25.h, fit: BoxFit.cover),
        ],
      ),
    );
  }
}
