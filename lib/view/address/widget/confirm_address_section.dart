/* 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/class/status_request.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_image_asset.dart';
import '../../../core/constant/app_sizes.dart';
import '../../../core/constant/styles.dart';

import '../../widgets/custom_gradient_button.dart';
import '../controller/address_add_controller.dart';

class ConfirmAddressSection extends StatelessWidget {
  const ConfirmAddressSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressAddController>(builder: (controller) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace.w),
        child: Column(
          children: [
            SizedBox(
              height: AppSizes.lg.h,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
             //     SvgPicture.asset(AppImageAsset.locationIcon),
             Icon(Iconsax.location),
                  SizedBox(
                    width: AppSizes.md.h,
                  ),
                  Text(
                    '${controller.city} , ${controller.street}',
                    style: Styles.styleLight18,
                  )
                ],
              ),
            ),
            const Divider(
              color: AppColors.greyColor,
              thickness: 1,
            ),
            SizedBox(
              height: AppSizes.lg.h,
            ),
            CustomGradientButton(
              isLoading: controller.statusRequest == StatusRequest.loading
                  ? true
                  : false,
              onPressed: () {
                controller.onPressedSaveLocation();
              },
              text:'.confirm Location',
              style: Styles.style18,
            ),
          ],
        ),
      );
    });
  }
}
 */