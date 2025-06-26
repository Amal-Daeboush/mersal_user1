import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mersal/core/class/status_request.dart';
import 'package:mersal/data/model/category_model.dart';
import 'package:mersal/view/details%20screen/view/details_screen.dart';
import 'package:mersal/view/favourite/controller/favourite_controller.dart';
import 'package:mersal/view/my_service/controller/my_service_controller.dart';
import 'package:mersal/view/restaurant%20screen/controller/restaurants_controller.dart';
import 'package:mersal/view/restaurant%20screen/view/food_screen.dart';
import 'package:mersal/view/restaurant%20screen/widgets/food_type_shimmer.dart';
import 'package:mersal/view/restaurant%20screen/widgets/restaurants_card.dart';
import 'package:mersal/view/restaurant%20screen/widgets/type.dart';
import 'package:mersal/view/widgets/shimmer/product_shimmer.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/styles.dart';
import '../../widgets/app bar/container_app_bar.dart';
import '../../widgets/custom_licart_card_view/custom_service.dart';

class RestaurantsScreen extends StatelessWidget {
  const RestaurantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ///// FavouriteController favouriteController = Get.find();
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<RestaurantsController>(
          init: RestaurantsController(),
          builder: (controller) {
            return Opacity(
              opacity: 1,
              /*  opacity:
                  favouriteController.isLoadingcFavourie.value ? 0.5 : 1.0, */
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // شريط العنوان
                  ContainerAppBar(
                    isSearch: true,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.shopping_cart_outlined,
                          size: 20,
                          color: AppColors.whiteColor,
                        ),
                        Text(
                          'المطاعم',
                          style: Styles.style1.copyWith(
                            color: AppColors.whiteColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () => Get.back(),
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // قبل قائمة الأنواع
                  controller.statusRequest == StatusRequest.loading
                      ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: List.generate(4, (index) {
                            return foodTypeShimmer();
                          }),
                        ),
                      )
                      : controller.foodtypes.isEmpty
                      ? const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: Text(
                            'لا توجد مطاعم حالياً',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                      )
                      : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...controller.foodtypes.map((foodtype) {
                              final isSelected =
                                  controller.selectedType == foodtype;
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4.0,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    controller.updateCategory(foodtype);
                                    controller.getFoodProviders();
                                  },
                                  child: TypeSelect(
                                    foodTypeModel: foodtype,
                                    isSelect: isSelected,
                                  ),
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ),

                  SizedBox(height: 10.h),

                  // قائمة الخدمات
                  Expanded(
                    child:
                        controller.statusRequestProviders ==
                                StatusRequest.loading
                            ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GridView.builder(
                                itemCount: 5,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 0,
                                      crossAxisSpacing: 10,
                                      crossAxisCount: 2,
                                    ),
                                itemBuilder: (context, index) {
                                  return ProductCardShimmer();
                                },
                              ),
                            )
                            : controller.foodProviders.isEmpty
                            ? const Center(
                              child: Text(
                                'لا توجد مطاعم لهذه الفئة.',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                            : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GridView.builder(
                                itemCount: controller.foodProviders.length,

                                shrinkWrap: true,

                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 0,
                                      crossAxisSpacing: 10,
                                      crossAxisCount: 2,
                                    ),
                                itemBuilder: (context, index) {
                                  final product =
                                      controller.foodProviders[index];
                                  return InkWell(
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onTap:
                                        () => Get.to(
                                          FoodScreen(
                                            id:
                                                controller
                                                    .foodProviders[index]
                                                    .providerFood
                                                    .id,
                                            type:
                                                controller.selectedType!.title,
                                            title:
                                                controller
                                                    .foodProviders[index]
                                                    .user
                                                    .name,
                                          ),
                                        ),
                                    child: RestaurantsCard(
                                      ProductModel: product,
                                      /*   favoriteFunction:
                                            () => favouriteController
                                                .addFavorite(
                                                  product.id.toString(),
                                                ), */
                                    ),
                                  );
                                },
                              ),
                            ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
