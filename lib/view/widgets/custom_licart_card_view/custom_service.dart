import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mersal/core/constant/app_image_asset.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/styles.dart';

class CustomService extends StatelessWidget {
  final String name;
  final String? image;
  final bool isSelected;
  final int id;
  const CustomService({
    super.key,
    required this.name,
    //  required this.image,
    required this.isSelected,
    required this.id,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Column(
        children: [
          Container(
            height: 50.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  isSelected ? AppColors.primaryColor : AppColors.whiteColor3,
            ),
            child: Padding(
              padding:   image != null?const EdgeInsets.all(1): const EdgeInsets.all(8),
              child:
                  image != null
                      ? CircleAvatar(
                        backgroundImage: NetworkImage(image!),
                        //borderRadius: BorderRadius.circular(50),
                       /*  child: Image.network(
                          image!,
                          height: 30,
                         
                        ), */
                      )
                      : SvgPicture.asset(
                        AppImageAsset.home_service,
                        height: 30,
                        color:
                            isSelected
                                ? AppColors.whiteColor3
                                : AppColors.primaryColor,
                      ),
            ),
          ),
          Text(name, style: Styles.style1_copy2),
        ],
      ),
    );
  }
}
