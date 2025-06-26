/* import 'package:mersal/core/class/status_request.dart';
import 'package:mersal/core/constant/app_sizes.dart';
import 'package:mersal/view/address/controller/address_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_texts.dart';
import '../../../core/constant/styles.dart';
import '../../authentication/widget/gradiant/custom_gradient_button.dart';

import 'custom_border_button.dart';

class AddressActionSection extends StatelessWidget {
  const AddressActionSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressController>(builder: (controller) {
      return Column(children: [
        SizedBox(
          height: AppSizes.spaceBtwItems.h,
        ),
        Text(
         'welcom',
         // style: Styles.styleBold20,
        ),
        SizedBox(
          height: AppSizes.sm.h,
        ),
        Text(
          'location Exploration Message',
          style: Styles.style1.copyWith(color: AppColors.greyColor),
        ),
        SizedBox(
          height: AppSizes.md.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace.w),
          child: Column(
            children: [
              CustomBorderButton(
                isLoading: controller.statusRequest == StatusRequest.loading
                    ? true
                    : false,
                text: 'your location',
                onPressed: () {
                  controller.onPressedUseCurrentLocation();
                },
              ),
              SizedBox(
                height: AppSizes.md.h,
              ),
              CustomGradientButton(
                onPressed: () {
                  controller.onPressedAddLocationFromMap();
                },
                text:'your new location',
                style: Styles.style18,
              ),
              SizedBox(
                height: AppSizes.sm.h,
              ),
              InkWell(
                onTap: () {
                  controller.onTapSkip();
                },
                child: Text(
                 'skip',
                  style: Styles.style2,
                ),
              ),
            ],
          ),
        )
      ]);
    });
  }
}
 */