import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mersal/data/model/favourite_model.dart' as Fav;
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_image_asset.dart';
import '../../../core/constant/styles.dart';

class CardFavorite extends StatelessWidget {
  final void Function()? deleteFav;
  final Fav.FavouriteModel favouriteModel;
  const CardFavorite({super.key, required this.favouriteModel, this.deleteFav});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                AppImageAsset.im1,
                width: 180.w,
                height: 120.h,
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
                onTap: deleteFav,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.whiteColor,
                  ),
                  child: const Padding(
                    padding: const EdgeInsets.all(2),
                    child: Icon(
                      Icons.favorite_border_outlined,
                      color: AppColors.red,
                      size: 15,
                    ),
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
              favouriteModel.name,
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
                text: ': السعر',
                style: Styles.style5.copyWith(color: AppColors.black),
              ),
              TextSpan(
                text: '${favouriteModel.price} £',
                style: Styles.style5.copyWith(color: AppColors.primaryColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
