import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mersal/core/class/helper_functions.dart';
import 'package:mersal/core/constant/app_colors.dart';
import 'package:mersal/core/constant/app_image_asset.dart';
import 'package:mersal/core/constant/styles.dart';
import 'package:mersal/model/notification_model.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notificationModel;
  const NotificationCard({super.key, required this.notificationModel});

  @override
  Widget build(BuildContext context) {
    String formatSmartDate(DateTime dateTime) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final aDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
      final difference = today.difference(aDate).inDays;

      final time =
          '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';

      if (difference == 0) {
        return '$time';
      } else if (difference == 1) {
        return '$time\nYesterday';
      } else {
        final date = DateFormat('d MMMM').format(dateTime); // مثل: 10 June
        return '$time\n$date';
      }
    }
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        width: HelperFunctions.screenWidth(),
        color:
            notificationModel.status == 'pending'
                ? AppColors.whiteColor3
                : Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundImage: AssetImage(AppImageAsset.notif_image),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    notificationModel.notification!,
                    style: Styles.style1.copyWith(
                      color: AppColors.primaryColorBold,
                    ),
                  ),
                ),
              ),
              Text(
                 formatSmartDate(notificationModel.createdAt!),
                style: Styles.style4.copyWith(color: AppColors.greyColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
