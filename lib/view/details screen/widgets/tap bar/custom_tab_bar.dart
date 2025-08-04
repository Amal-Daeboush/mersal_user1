import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:mersal/data/model/products_model.dart' as Product;
import 'package:mersal/data/model/rating_model.dart';

import '../../../../core/constant/app_colors.dart';
import 'image_list.dart';
import 'opinions_list.dart';

class CustomTabBar extends StatelessWidget {
  final List<RatingsModel> ratings;
  final String? message;
    final List<Product.Image> images;
  final double? height;
  const CustomTabBar({super.key, this.height, required this.ratings, this.message, required this.images});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ContainedTabBarView(
        tabBarProperties: const TabBarProperties(
          padding: EdgeInsets.only(bottom: 4),
          height: 40,
          indicatorWeight: 2,
          labelStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 17,
            color: AppColors.primaryColor,
          ),
          unselectedLabelStyle: TextStyle(fontSize: 15, color: Colors.black87),
          indicatorColor: AppColors.primaryColor,
        ),
        tabs: const [Text('الاراء'), Text('الصور')],
        views: [
          // opinions
          OpinionsList(ratings: ratings,message: message,),
          // images
          ImagesList(images: images,),
        ],
      ),
    );
  }
}
