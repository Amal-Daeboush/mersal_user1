import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mersal/view/authentication/login/screen/login.dart';
import 'package:mersal/view/authentication/register/controller/register_controller.dart';
import 'package:mersal/view/authentication/widget/custom_container_button/custom_button_google.dart';
import 'package:mersal/view/authentication/widget/logo/custom_logo.dart';
import 'package:mersal/view/widgets/custom_loading.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_sizes.dart';
import '../../../../core/constant/styles.dart';
import '../../widget/custom_container_button/custom_button_login.dart';
import '../../widget/custom_or.dart';
import '../../widget/text_field/custom_text_form_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(LoginController());
    return Scaffold(
      body: GetBuilder(
        init: RegisterController(),
        builder: (controller) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.defaultSpace,
                ),
                child:
                    controller.isLoading
                        ? Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 100.w,
                            vertical: 100.h,
                          ),
                          child: Center(child: customLoadingIndictor()),
                        )
                        : Form(
                          key: controller.keyForm,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 80.h),
                              const CustomLogo(),
                              SizedBox(height: (AppSizes.lg).h),
                              Text('مرحبًا ! انشاء حساب', style: Styles.style3),
                              SizedBox(height: 5.h),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: ' هل لديك حساب بالفعل؟ ',
                                      style: Styles.style1.copyWith(
                                        color: AppColors.lightGrey,
                                      ),
                                    ),
                                    TextSpan(
                                      recognizer:
                                          TapGestureRecognizer()
                                            ..onTap = () {
                                              Get.off(
                                                const LoginScreen(),
                                              ); // الانتقال إلى شاشة التسجيل
                                            },
                                      text: 'قم بتسجيل الدخول',
                                      style: Styles.style1.copyWith(
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.h),
                              CustomTextFormField(
                                controller: controller.nameController,
                                hintText: 'اسم المستخدم',
                                obscureText: false,
                                isPassWord: false,
                              ),
                              SizedBox(height: 15.h),
                              CustomTextFormField(
                                controller: controller.emailController,
                                hintText: 'البريد الالكتروني',
                                obscureText: false,
                                isPassWord: false,
                              ),
                              SizedBox(height: 15.h),
                              CustomTextFormField(
                                controller: controller.passwordController,
                                hintText: 'الرقم السرى',
                                obscureText: controller.obscureText,
                                isPassWord: true,
                                onTapobscure: () {
                                  controller.changeObscureText();
                                },
                                icon:
                                    controller.obscureText
                                        ? const Icon(
                                          Icons.visibility_off,
                                          color: AppColors.lightGrey3,
                                          size: 15,
                                        )
                                        : const Icon(
                                          Icons.visibility,
                                          color: AppColors.lightGrey3,
                                          size: 15,
                                        ),
                              ),
                              SizedBox(height: 15.h),
                              CustomButtonLogin(
                                onTap: controller.register,
                                isLogin: true,
                                textn: true,
                              ),
                              SizedBox(height: 5.h),
                              CustomOR(),
                              SizedBox(height: 5.h),
                              CustomButtonGoogle(isGoogle: false),
                              SizedBox(height: 5.h),
                              CustomButtonGoogle(isGoogle: true),
                              SizedBox(height: 5.h),
                            ],
                          ),
                        ),
              ),
            ),
          );
        },
      ),
    );
  }
}
