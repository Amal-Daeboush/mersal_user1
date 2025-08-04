import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mersal/core/class/helper_functions.dart';
import 'package:mersal/core/constant/app_image_asset.dart';
import 'package:mersal/model/notification_model.dart';
import 'package:mersal/view/notifications%20screen/notification_card.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/const_data.dart';
import '../../../core/constant/styles.dart';

import '../controller/notification_controller.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotificationController>();

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SafeArea(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                SizedBox(
                  height: HelperFunctions.screenHeight(),
                  width: HelperFunctions.screenWidth(),
                  child: Stack(
                    children: [
                      Container(color: Colors.grey[200]),
                      Container(
                        height: HelperFunctions.screenHeight() / 6,
                        color: AppColors.primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 20.r,
                                backgroundImage:
                                    ConstData.image.isEmpty
                                        ? const AssetImage(AppImageAsset.user)
                                        : NetworkImage(ConstData.image)
                                            as ImageProvider,
                              ),
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: AppColors.whiteColorWithOpacity2,
                                ),
                                child: IconButton(
                                  onPressed: () async {
                                    if (controller.unread.isNotEmpty) {
                                      await controller.markAllAsRead();
                                    } // اجعلها async
                                    Get.back();
                                  },

                                  icon: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 15,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GetBuilder<NotificationController>(
                  //    init: MyOrdersController(),
                  builder: (controller) {
                    return Positioned(
                      top: HelperFunctions.screenHeight() / 7,
                      child: Container(
                        height:
                            constraints.maxHeight -
                            (HelperFunctions.screenHeight() / 7),
                        width: HelperFunctions.screenWidth(),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.r),
                            topRight: Radius.circular(30.r),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SvgPicture.asset(AppImageAsset.handel),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'الاشعارات',
                                      style: Styles.style6.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.primaryColorBold,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.done_all,
                                      color: AppColors.primaryColorBold,
                                    ),
                                  ],
                                ),
                              ),
                              /*   SizedBox(
                      height: 10.h,
                    ), */
                              Expanded(
                                child: ListView(
                                  children: [
                                    ..._sortedNotifications(
                                          controller.read,
                                          controller.unread,
                                        )
                                        .map(
                                          (e) => NotificationCard(
                                            notificationModel: e,
                                          ),
                                        )
                                        .toList(),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.h),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

List<NotificationModel> _sortedNotifications(
  List<NotificationModel> read,
  List<NotificationModel> unread,
) {
  // دمج القائمتين
  List<NotificationModel> allNotifications = [...read, ...unread];

  // فرز القائمتين حسب createdAt
  allNotifications.sort(
    (a, b) => b.createdAt!.compareTo(a.createdAt!),
  ); // من الأحدث إلى الأقدم

  return allNotifications;
}
