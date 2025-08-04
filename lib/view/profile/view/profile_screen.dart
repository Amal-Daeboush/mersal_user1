import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mersal/core/constant/styles.dart';
import 'package:mersal/core/sevices/sevices.dart';
import 'package:mersal/view/address/view/address.dart';
import 'package:mersal/view/app%20information/view/app_information.dart';
import 'package:mersal/view/authentication/authentication/view/authentication_screen.dart';
import 'package:mersal/view/profile/controller/profile_controller.dart';
import 'package:mersal/view/profile/view/change_password_screen.dart';
import 'package:mersal/view/profile/view/edit_profil_screen.dart';
import 'package:mersal/view/widgets/snack%20bar/custom_snack_bar.dart';

import '../../../core/constant/app_colors.dart';
import '../widget/app_bar_profile.dart';
import '../widget/card_info.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
     Get.put(ProfileController()); 
    return Scaffold(
      backgroundColor: AppColors.whiteColor2,
      body: GetBuilder<ProfileController>(
        builder: (controller) {
          return Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBarProfile(name: controller.name,image:controller.image),
              SizedBox(height: 20.h),
              Expanded(
                child: Container(
                  color: AppColors.whiteColor,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      top: 8,
                      bottom: 8,
                      right: 8,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CardInfo(
                            id: 1,
                            onTap: () => Get.to(EditProfileScreen()),
                          ),
                          Divider(
                            height: 1.h,
                            color: Color.fromARGB(200, 187, 187, 187),
                          ),
                          CardInfo(
                            id: 2,
                            onTap:
                                () => Get.to(AddressScreen(isfromHome: true)),
                          ),
                          Divider(
                            height: 1.h,
                            color: Color.fromARGB(200, 187, 187, 187),
                          ),
                          CardInfo(
                            id: 3,
                            onTap: () => Get.to(ChangePasswordScreen()),
                          ),
                          Divider(
                            height: 1,
                            color: Color.fromARGB(200, 187, 187, 187),
                          ),
                          const CardInfo(id: 4),
                          Divider(
                            height: 1.h,
                            color: Color.fromARGB(200, 187, 187, 187),
                          ),
                          CardInfo(id: 5),
                          Divider(
                            height: 1,
                            color: Color.fromARGB(200, 187, 187, 187),
                          ),
                          CardInfo(
                            id: 6,
                            onTap: () => Get.to(AppInformation()),
                          ),
                          Divider(
                            height: 1.h,
                            color: Color.fromARGB(200, 187, 187, 187),
                          ),
                          CardInfo(id: 7),
                          Divider(
                            height: 1.h,
                            color: Color.fromARGB(200, 187, 187, 187),
                          ),
                          CardInfo(
                            onTap: () {
                              Get.defaultDialog(
                                title: '',
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 5,
                                      ),
                                      child: Text('لا', style: Styles.style4),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      // Log out and navigate to the authentication screen
                                      print("تسجيل خروج ...");
                                      await MyServices().clear();
                                      Get.offAll(const AuthenticationScreen());
                                      CustomSnackBar('تم تسجيل الخروج', true);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 5,
                                      ),
                                      child: Text(
                                        'نعم',
                                        style: Styles.style4.copyWith(
                                          color: AppColors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                                content: Text(
                                  'هل ترغب بتسجيل الخروج؟',
                                  style: Styles.style1,
                                ),
                              );
                            },
                            id: 8,
                          ),
                          SizedBox(height: 50.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
