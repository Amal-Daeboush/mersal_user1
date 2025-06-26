import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mersal/view/notifications%20screen/view/notification_screen.dart';

import '../../../core/constant/app_colors.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.off(NotificationScreen()),
      child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: AppColors.whiteColorWithOpacity),
                      child: const Padding(
                        padding: const EdgeInsets.all(2),
                        child: Icon(
                          Iconsax.notification,
                          size: 20,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
    );
  }
}