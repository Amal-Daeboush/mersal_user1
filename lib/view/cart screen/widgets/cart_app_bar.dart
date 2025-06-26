import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_image_asset.dart';
import '../../../core/constant/styles.dart';
import '../../widgets/app bar/container_app_bar.dart';

class CartAppBar extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  const CartAppBar({super.key, this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ContainerAppBar(
      controller: controller,
      onChanged: onChanged,
      isSearch: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.whiteColor,
              size: 20,
            ),
          ),
          Text(
            'السلة',
            style: Styles.style6.copyWith(
              color: AppColors.whiteColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          Image.asset(AppImageAsset.logo, height: 25.h, fit: BoxFit.cover),
        ],
      ),
    );
  }
}
