import 'package:flutter/material.dart';

import '../../../core/class/helper_functions.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_image_asset.dart';
import '../../../core/constant/styles.dart';

class CustompageView extends StatelessWidget {
  const CustompageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Image.asset(
          AppImageAsset.off_Image,
          fit: BoxFit.cover,
          width: HelperFunctions.screenWidth(),
        ),
      ),
      Positioned(
        right: 10,
        top: 20,
        child: Text(
          'احصل على خصم يصل الى\n 50% عند الخدمه الاولى',
          style: Styles.style3.copyWith(color: AppColors.whiteColor),
        ),
      ),
      Positioned(
        right: 10,
        bottom: 5,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: AppColors.whiteColor
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text('اكتشف أكثر',style: Styles.style4.copyWith(color: AppColors.primaryColor),),
          ),
        ),
      ),
    ]);
  }
}
