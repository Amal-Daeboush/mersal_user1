import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mersal/core/class/helper_functions.dart';
import 'package:mersal/core/constant/app_image_asset.dart';
import 'package:mersal/view/botttom%20nav%20bar/view/bottom_nav_bar_screen.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/styles.dart';
import '../../my order/controller/my_orders_controller.dart';


class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      return SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              height: HelperFunctions.screenHeight(),
              width: HelperFunctions.screenWidth(),
              child: Stack(
                children: [
                  Container(
                    color: Colors.grey[200],
                  ),
                  Container(
                    height: HelperFunctions.screenHeight() / 6,
                    color: AppColors.primaryColor,
                    child:  Padding(
                      padding:const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                      radius: 20.r,
                      backgroundImage:const AssetImage(AppImageAsset.profile),
                    ),
                          Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                    color: AppColors.whiteColorWithOpacity2
                              ),
                              child: IconButton(
                                  onPressed: () =>Get.off(BottomNavBarScreen()),
                                  icon:const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 15,
                                    color: AppColors.whiteColor,
                                  )),
                            ),
                        ],
                      )
                    ),
                  ),
                ],
              ),
            ),
            GetBuilder(
                init: MyOrdersController(),
                builder: (controller) {
                  return Positioned(
                      top: HelperFunctions.screenHeight() / 7,
                      child: Container(
                          height: constraints.maxHeight -
                              (HelperFunctions.screenHeight() / 7),
                          width: HelperFunctions.screenWidth(),
                          decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.r),
                                  topRight: Radius.circular(30.r))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                  children: [
                    SvgPicture.asset(AppImageAsset.handel),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'الاشعارات',
                            style: Styles.style6.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppColors.primaryColorBold),
                          ),
                          const Icon(Icons.done_all,
                              color: AppColors.primaryColorBold)
                        ],
                      ),
                    ),
                  /*   SizedBox(
                      height: 10.h,
                    ), */
                    Expanded(
                      child: ListView.separated(itemBuilder: (context, index) =>
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 30.r,
                                  backgroundImage:
                                      AssetImage(AppImageAsset.notif_image),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                                                      'تم تسليم طلبك بنجاح. نتمنى أن تكون تجربتك رائعة!',
                                                                      style: Styles.style1.copyWith(color: AppColors.primaryColorBold),
                                                                    ),
                                    )),
                                Text('2 min',style: Styles.style4.copyWith(color: AppColors.greyColor),)
                              ],
                            ),
                          ),
                        ),
                     separatorBuilder: (context, index) => Divider(height: 2,color: AppColors.whiteColor3,), itemCount: 10)
                    )
                  ],
                ),
                          )));
                })
          ],
        ),
      );
    }));
  }
}



/* Column(
                children: [
                  SvgPicture.asset(AppImageAsset.handel),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'الاشعاارات',
                          style: Styles.style6.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.primaryColorBold),
                        ),
                        const Icon(Icons.wechat_sharp,
                            color: AppColors.primaryColorBold)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Expanded(
                    child: ListView.separated(itemBuilder: (context, index) =>
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 20.r,
                                backgroundImage:
                                    AssetImage(AppImageAsset.notif_image),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                  child: Text(
                                'تم تسليم طلبك بنجاح. نتمنى أن تكون تجربتك رائعة!',
                                style: Styles.style1.copyWith(color: AppColors.primaryColorBold),
                              )),
                              Text('2 min',style: Styles.style5.copyWith(color: AppColors.lightGrey2),)
                            ],
                          ),
                        ),
                      ),
                   separatorBuilder: (context, index) => Divider(height: 5,), itemCount: 10)
                  )
                ],
              ), */