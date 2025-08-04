import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_image_asset.dart';
import '../../../core/constant/styles.dart';
import '../../widgets/app bar/container_app_bar.dart';

class DetailsOrderAppBar extends StatelessWidget {
  const DetailsOrderAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerAppBar(
      isSearch: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 20),
          Text(
            'تفاصيل الطلب',
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
