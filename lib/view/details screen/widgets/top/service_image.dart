import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mersal/view/cart%20screen/view/cart_screen.dart';
import 'package:mersal/view/chat%20screen/view/your_chat_screen.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_image_asset.dart';
import 'icon_image.dart';

Widget ServiceImage(
  double screenWidth,
  double screenHeight,
  bool service,
  int id,
  String name,
) {
  return SizedBox(
    width: screenWidth,
    height: screenHeight,
    child: Stack(
      children: [
        Container(color: Colors.grey[200]),
        Stack(
          children: [
            Image.asset(
              AppImageAsset.im2,
              width: screenWidth,
              height: screenHeight / 3,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 40,
              left: 20,
              child: buildIcon(
                Icons.arrow_forward_ios,
                AppColors.whiteColorWithOpacity2,
                () => Get.back(),
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: buildIcon(
                service ? Iconsax.message1 : Icons.shopping_cart_outlined,
                AppColors.whiteColorWithOpacity2,
                () {
                  service
                      ? Get.to(YourChatScreen(senderName: name, id: id))
                      : Get.to(CartScreen());
                },
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
