import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mersal/core/class/status_request.dart';
import 'package:mersal/view/details%20screen/view/details_screen.dart';
import 'package:mersal/view/my_service/widgets/card_my_service.dart';
import 'package:mersal/view/restaurant%20screen/controller/restaurants_controller.dart';
import 'package:mersal/view/restaurant%20screen/widgets/food_type_shimmer.dart';
import 'package:mersal/view/restaurant%20screen/widgets/type.dart';
import 'package:mersal/view/widgets/shimmer/product_shimmer.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/styles.dart';
import '../../widgets/app bar/container_app_bar.dart';

class RestaurantsScreen extends StatelessWidget {
  final int id;
  const RestaurantsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    ///// FavouriteController favouriteController = Get.find();
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<RestaurantsController>(
          init: RestaurantsController(id: id),
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
                    controller: controller.searchController,
                    isSearch: false,
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
                          children: List.generate(controller.foodtypes.length, (
                            index,
                          ) {
                            final foodtype = controller.foodtypes[index];
                            final isSelected =
                                controller.selectedType == foodtype;

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4.0,
                              ),
                              child: GestureDetector(
                                onTap:
                                    () => controller.updateCategory(foodtype),

                                child: TypeSelect(
                                  foodTypeModel: foodtype,
                                  isSelect: isSelected,
                                ),
                              ),
                            );
                          }),
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
                            : controller.products.isEmpty
                            ? const Center(
                              child: Text(
                                'لا توجد اطباق لهذه الفئة.',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                            : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GridView.builder(
                                  itemCount:
                                      controller.products.length +
                                      (controller.isLoadingMore ? 1 : 0),
                                  controller: controller.scrollController,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisSpacing: 0,
                                        crossAxisSpacing: 10,
                                        crossAxisCount: 2,
                                      ),
                                  itemBuilder: (context, index) {
                                    if (index < controller.products.length) {
                                      final product =
                                          controller.products[index];
                                      return GestureDetector(
                                        onTap:
                                            () => Get.to(
                                              DetailsScreen(
                                                productModel: product,
                                              ),
                                            ),
                                        child: CardMyService(
                                          ProductModel: product,
                                        ),
                                      );
                                    } else {
                                      return ProductCardShimmer();
                                    }
                                  },
                                ),
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
