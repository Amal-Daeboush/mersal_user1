/* import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mersal/view/authentication/widget/custom_container_button/custom_container_button.dart';
import 'package:mersal/view/authentication/widget/logo/custom_logo.dart';
import 'package:mersal/view/authentication/widget/text_field/custom_text_form_field.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_sizes.dart';
import '../../../../core/constant/styles.dart';
import '../controller/login_phone_controller.dart';

class LoginPhoneScreen extends StatelessWidget {
  const LoginPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder(
            init: LoginPhoneController(),
            builder: (controller) {
              return Form(
                key: controller.keyFormphone,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.defaultSpace),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 80.h,
                        ),
                        const CustomLogo(),
                        SizedBox(
                          height: (AppSizes.lg).h,
                        ),
                        Text(
                          'ابدأ مع مرسال ',
                          style: Styles.style3,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text('ادخل رقم الهاتف الخاص بك',
                            style: Styles.style1
                                .copyWith(color: AppColors.lightGrey)),
                        SizedBox(
                          height: 10.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('رقم الهاتف',
                                textAlign: TextAlign.start,
                                style: Styles.style1
                                    .copyWith(color: Color(0xffC1C7D0))),
                            CustomTextFormField(
                                onChanged: (value) {
                                  controller.checkNumberValidate(value);
                                },
                                keyboardType: TextInputType.number,
                                controller: controller.phoneController,
                                prefixIcon: const Icon(
                                    Icons.local_phone_rounded,
                                    size: 20,
                                    color: AppColors.lightGrey3),
                                hintText: '01234567891',
                                obscureText: false,
                                color: controller.isValidatePhone
                                    ? AppColors.primaryColor
                                    : AppColors.lightGrey3,
                                isPassWord: false,
                                validator: controller.validator),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomContainerButton(
                          onTap: controller.loginWithPhone,
                          borderColor: AppColors.primaryColor,
                          color: AppColors.primaryColor,
                          child: Text(
                            'التالي',
                            style: Styles.style1
                                .copyWith(color: AppColors.whiteColor),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
 */