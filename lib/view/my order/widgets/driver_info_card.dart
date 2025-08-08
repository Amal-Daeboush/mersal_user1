import 'package:flutter/material.dart';
import 'package:mersal/core/class/helper_functions.dart';
import 'package:mersal/core/constant/app_colors.dart';
import 'package:mersal/core/constant/app_image_asset.dart';
import 'package:mersal/core/constant/styles.dart';
import 'package:mersal/model/details_order.dart';

class DriverInfoCard extends StatelessWidget {
  final Driver driver;
  const DriverInfoCard({super.key, required this.driver});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: HelperFunctions.screenWidth() / 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.primaryColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage(AppImageAsset.driver),
                 
                ),
              ),
              SizedBox(height: 5),
              Text(
                "الاسم: ${driver.driverName}",
                style: Styles.style4.copyWith(color: AppColors.black),
              ),
              SizedBox(height: 5),
              Text(
                "الهاتف: ${driver.phone}",
                style: Styles.style4.copyWith(color: AppColors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
