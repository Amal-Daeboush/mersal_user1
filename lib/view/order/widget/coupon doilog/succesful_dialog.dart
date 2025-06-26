import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:mersal/core/constant/app_image_asset.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/styles.dart';


successfulDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           SvgPicture.asset(AppImageAsset.check),
            const SizedBox(width: 10),
            Text('لقد تم طلبك بنجاح',
                style:
                    Styles.style1.copyWith(color: AppColors.primaryColorBold)),
          ],
        ),
        content: Text(
          'تم تأكيد طلبك بنجاح، وسيتم تنفيذ الخدمة في غضون 20 دقيقة. نتمنى أن تكون راضيًا عن خدمتنا.',
          textAlign: TextAlign.center,
          style: Styles.style4,
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 50),
                child: Text(
                  'استمر في التصفح',
                  style: Styles.style4.copyWith(color: AppColors.whiteColor),
                ),
              ),
            ),
          )
        ],
      );
    },
  );
}
