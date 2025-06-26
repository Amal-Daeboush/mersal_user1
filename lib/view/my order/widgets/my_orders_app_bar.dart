import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mersal/core/constant/app_image_asset.dart';
import 'package:mersal/view/cart%20screen/view/cart_screen.dart';
import 'package:mersal/view/widgets/app%20bar/container_app_bar.dart';

import '../../../core/constant/app_colors.dart';

import '../../../core/constant/styles.dart';

class MyOrdersAppBar extends StatelessWidget {
    final TextEditingController? controller;
  final void Function(String)? onChanged;
  const MyOrdersAppBar({super.key, this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ContainerAppBar(
      controller: controller,
    //  color: AppColors.whiteColor,
        onChanged: onChanged,
      isSearch: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Get.to(CartScreen());
            },
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: AppColors.whiteColor,
              size: 20,
            ),
          ),
          Text(
            'الطلبات والحجوزات',
            style: Styles.style6.copyWith(
              color: AppColors.whiteColor,
              fontWeight: FontWeight.w500,
            ),
          ),
         Image.asset(
            AppImageAsset.logo,
            height: 25.h,
            fit: BoxFit.cover,
          )
        ],
      ),
    );
  }
}
