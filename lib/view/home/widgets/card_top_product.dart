import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mersal/data/model/products_model.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_image_asset.dart';
import '../../../../core/constant/styles.dart';

class CardTopProduct extends StatelessWidget {
  final ProductModel productModel;
  final void Function()? favoriteFunction;
  final void Function()? ontap;
  final double? height;

  const CardTopProduct({
    super.key,
    this.ontap,
    required this.productModel,
    this.favoriteFunction,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: ontap,
      child: SizedBox(
        width: 150.w,
        child: Column(
          children: [
            Container(
              height: height ?? 150.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(AppImageAsset.off_Image),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        productModel.discountInfo.hasDiscount?
                          Container(
                              decoration:  BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(5),
                                color: AppColors.red,
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2),
                                child: Text(
                                  '${productModel.discountInfo.discountValue}% -',
                                  style: Styles.style5.copyWith(
                                    color: AppColors.whiteColor,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ):
                       SizedBox()
                          ,
                        InkWell(
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
                              padding: EdgeInsets.all(2),
                              child: Icon(
                                Icons.favorite_border_outlined,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.whiteColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 5,
                        ),
                        child: Text(
                          '${productModel.price} £',
                          style: Styles.style5.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      productModel.name,
                      style: Styles.style5.copyWith(
                        color: AppColors.greyColor,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.yellow, size: 15),
                      SizedBox(width: 5.w),
                      Text(
                        '(80) 4.4',
                        style: Styles.style5.copyWith(
                          color: AppColors.greyColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
