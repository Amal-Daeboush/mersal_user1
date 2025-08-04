import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mersal/model/products_model.dart' as product;

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_image_asset.dart';
import '../../../core/constant/styles.dart';

class CardTopService extends StatelessWidget {
  final product.ProductModel productModel;
  final void Function()? favoriteFunction;
  const CardTopService({
    super.key,
    required this.productModel,
    this.favoriteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  AppImageAsset.off_Image,
                  height: 100.h,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                    top: 3,
              left: 5,
                child: InkWell(
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: favoriteFunction,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.whiteColor,
                    ),
                    child: const Padding(
                      padding: const EdgeInsets.all(2),
                      child: Icon(Icons.favorite_border_outlined, size: 15),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 3,
                right: 5,
                child: Container(












                  
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: AppColors.whiteColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      '${productModel.price} £',
                      style: Styles.style5,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min, // Ensure Row wraps its children
            children: [
              Text(
                productModel.name,
                style: Styles.style1_copy2.copyWith(color: AppColors.greyColor),
              ),
              const Flexible(
                fit: FlexFit.loose, // Adjust the flexible widget
                child: SizedBox(width: 20), // Spacer-like effect
              ),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.yellow, size: 10),
                  Text(
                    '4.4 (80)',
                    style: Styles.style1_copy2.copyWith(
                      color: AppColors.greyColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
