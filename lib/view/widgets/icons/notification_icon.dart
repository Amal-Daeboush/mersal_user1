import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mersal/core/constant/styles.dart';
import 'package:mersal/view/notifications%20screen/controller/notification_controller.dart';
import 'package:mersal/view/notifications%20screen/view/notification_screen.dart';

import '../../../core/constant/app_colors.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
      builder: (controller) => InkWell(
        onTap: () {
          controller.loadNotifications(loadUnreadAlso: false);
          Get.to(NotificationScreen());
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: AppColors.whiteColorWithOpacity,
              ),
              child: const Padding(
                padding: EdgeInsets.all(2),
                child: Icon(
                  Iconsax.notification,
                  size: 20,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
            controller.unreadCount == 0
                ? SizedBox()
                : Positioned(
                    top: -10,
                    left: -10,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.red,
                      ),
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        controller.unreadCount.toString(),
                        style: Styles.style1.copyWith(
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
