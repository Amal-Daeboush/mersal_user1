/* 
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/class/status_request.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_sizes.dart';
import '../../../core/constant/styles.dart';
import '../../widgets/custom_gradient_button.dart';
import '../controller/address_confirm_controller.dart';

class ConfirmDeliveryAddressSection extends StatelessWidget {
  const ConfirmDeliveryAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressConfirmController>(builder: (controller) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace.w),
        child: Column(
          children: [
            SizedBox(
              height: AppSizes.lg.h,
            ),
            Card(
              color: AppColors.whiteColor,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.spaceBtwItems.w,
                    vertical: AppSizes.md.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                       'delver to',
                          style: Styles.style1.copyWith(
                              color: AppColors.greyColor,
                              fontWeight: FontWeight.w400),
                        ),
                        controller.isEditable
                            ? Container()
                            : InkWell(
                                onTap: () {
                                  controller.onPressedEdit();
                                },
                                child: Text(
                                 'edit',
                                  style: Styles.style1.copyWith(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                         Icon(Iconsax.location),

                          SizedBox(
                            width: AppSizes.md.h,
                          ),
                          GetBuilder<AddressConfirmController>(
                            builder: (controller) {
                              return Text(
                                // '${controller.locality} , ${controller.street}',
                                controller.locality,
                                style: Styles.style12.copyWith(
                                    color: AppColors.greyColor,
                                    fontWeight: FontWeight.w600),
                              );
                            },
                          )
                          // Text(data)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: AppSizes.md.h,
            ),
            CustomGradientButton(
              isLoading: controller.statusRequest == StatusRequest.loading
                  ? true
                  : false,
              onPressed: () {
                controller.onPressedConfirmAddress();
              },
              text: 'confirm location',
              style: Styles.style18,
            ),
          ],
        ),
      );
    });
  }
}
 */