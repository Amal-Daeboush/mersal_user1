import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:mersal/model/messages_model.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/styles.dart';

class CustomChat extends StatelessWidget {
  final int unreadCount;
  final MessagesModel messagesModel;

  const CustomChat({
    super.key,
    required this.messagesModel,
    this.unreadCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25.r,
        backgroundColor: AppColors.primaryColor.withOpacity(0.1),
        child: const Icon(Iconsax.user, size: 25, color: AppColors.black),
      ),
      title: Text(
        messagesModel.name,
        style: Styles.style1.copyWith(color: AppColors.black),
      ),
     
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            DateFormat('a hh:mm').format(messagesModel.lastMessageAt.toLocal()),
            style: Styles.style4.copyWith(color: AppColors.greyColor),
          ),
          if (unreadCount > 0)
            Container(
              margin: EdgeInsets.only(top: 5.h),
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                messagesModel.unreadCount.toString(),
                style: Styles.style3.copyWith(color: Colors.white, fontSize: 12.sp),
              ),
            ),
        ],
      ),
    );
  }
}
