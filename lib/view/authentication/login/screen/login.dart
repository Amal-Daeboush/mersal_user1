import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mersal/view/authentication/forget%20password/view/forget_pass_screen.dart';
import 'package:mersal/view/authentication/login/controller/login_controller.dart';
import 'package:mersal/view/authentication/register/view/register_screen.dart';
import 'package:mersal/view/authentication/widget/custom_container_button/custom_button_google.dart';
import 'package:mersal/view/authentication/widget/logo/custom_logo.dart';
import 'package:mersal/view/widgets/custom_loading.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_sizes.dart';
import '../../../../core/constant/styles.dart';
import '../../widget/custom_container_button/custom_button_login.dart';
import '../../widget/custom_or.dart';
import '../../widget/text_field/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(LoginController());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.defaultSpace,
            ),
            child: GetBuilder(
              init: LoginController(),
              builder: (controller) {
                return controller.isLoading
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
                          Text('مرحبًا بعودتك', style: Styles.style3),
                          SizedBox(height: 5.h),
                          Text(
                            'مرحبًا بك في مرسال، سجل الدخول للمتابعة!',
                            style: Styles.style1.copyWith(
                              color: AppColors.lightGrey,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: ' أو',
                                  style: Styles.style1.copyWith(
                                    color: AppColors.lightGrey,
                                  ),
                                ),
                                TextSpan(
                                  text: ' أنشئ حسابًا جديدًا',
                                  recognizer:
                                      TapGestureRecognizer()
                                        ..onTap = () {
                                          Get.off(
                                            const RegisterScreen(),
                                          ); // الانتقال إلى شاشة التسجيل
                                        },
                                  style: Styles.style1.copyWith(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h),
                          CustomTextFormField(
                            controller: controller.emailController,
                            hintText: '   الايميل',
                            obscureText: false,
                            isPassWord: false,
                          ),
                          SizedBox(height: 15.h),
                          CustomTextFormField(
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
                            controller: controller.passwordController,
                            hintText: 'الرقم السرى',
                            obscureText: controller.obscureText,
                            isPassWord: true,
                          ),
                          SizedBox(height: 15.h),
                          CustomButtonLogin(
                            onTap: controller.Login,
                            textn: false,
                            isLogin: true,
                          ),
                          SizedBox(height: 15.h),
                          TextButton(
                            onPressed: () => Get.off(ForgetPassScreen()),
                            child: Text(
                              'نسيت كلمه السر؟',
                              style: Styles.style1.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 5.h),
                          CustomOR(),
                          SizedBox(height: 5.h),
                          const CustomButtonGoogle(isGoogle: false),
                          SizedBox(height: 5.h),
                          CustomButtonGoogle(
                            isGoogle: true,
                            onTap: controller.loginGoogle,
                          ),
                        ],
                      ),
                    );
              },
            ),
          ),
        ),
      ),
    );
  }
}
