import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mersal/data/model/products_model.dart' as productModel;
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/styles.dart';

class CardMyService extends StatelessWidget {
  final void Function()? favoriteFunction;
  final productModel.ProductModel ProductModel;
  const CardMyService({
    super.key,
    required this.ProductModel,
    this.favoriteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                ProductModel.images.first.url,
                width: 180.w,
                height: 120.h,
                fit: BoxFit.cover,
              ),
            ),
            ProductModel.discountInfo.hasDiscount
                ? Positioned(
                  top: 3,
                  right: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.red,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      child: Text(
                        '${ProductModel.discountInfo.discountValue}% -',
                        style: Styles.style5.copyWith(
                          color: AppColors.whiteColor,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                )
                : SizedBox(),
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
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              ProductModel.name,
              style: Styles.style1_copy2.copyWith(color: AppColors.greyColor),
            ),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.yellow, size: 10),
                Text(
                  '4.4 (80) ',
                  style: Styles.style1_copy2.copyWith(
                    color: AppColors.greyColor,
                  ),
                ),
              ],
            ),
          ],
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'السعر : ',
                style: Styles.style5.copyWith(color: AppColors.black),
              ),
              TextSpan(
                text: '${ProductModel.price} £',
                style: Styles.style5.copyWith(color: AppColors.primaryColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
