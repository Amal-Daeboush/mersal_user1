import 'package:flutter/material.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/styles.dart';

Widget CustomRichText() {
  return RichText(
      text: TextSpan(children: [
    TextSpan(
      text: ' احصل على اقصى استفاده من ',
      style: Styles.style1.copyWith(
          color: AppColors.primaryColorBold, fontWeight: FontWeight.w600),
    ),
    TextSpan(
      text: 'مرسال',
      style: Styles.style1
          .copyWith(color: AppColors.primaryColor, fontWeight: FontWeight.w600),
    ),
  ]));
}
