import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mersal/core/class/status_request.dart';
import 'package:mersal/view/details%20screen/view/details_screen.dart';
import 'package:mersal/view/favourite/controller/favourite_controller.dart';
import 'package:mersal/view/my_service/controller/my_service_controller.dart';
import 'package:mersal/view/my_service/widgets/card_my_service.dart';
import 'package:mersal/view/restaurant%20screen/controller/food_controller.dart';
import 'package:mersal/view/widgets/shimmer/product_shimmer.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/styles.dart';
import '../../widgets/app bar/container_app_bar.dart';
import '../../widgets/custom_licart_card_view/custom_service.dart';

class FoodScreen extends StatelessWidget {
  final String title;
  final int id;
  final String type;

  const FoodScreen({
    super.key,

    required this.id,
    required this.type,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    FavouriteController favouriteController = Get.find();
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<FoodController>(
          init: FoodController(id: id, type: type),
          builder: (controller) {
            return Stack(
              children: [
                Opacity(
                  opacity:
                      favouriteController.isLoadingcFavourie.value ? 0.5 : 1.0,
                  child: Column(
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
                              '${title}',
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

                      // قائمة الخدمات
                      Expanded(
                        child:
                            controller.statusRequest == StatusRequest.loading
                                ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GridView.builder(
                                    itemCount: 5,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
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
                                    'لا يوحد طعام لهذه الفئة.',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                                : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GridView.builder(
                                    itemCount:
                                        controller.products.length +
                                        (controller.isLoadingMore ? 1 : 0),

                                    shrinkWrap: true,
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
                                        return InkWell(
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          onTap:
                                              () => Get.to(
                                                DetailsScreen(
                                                  productModel: product,
                                                ),
                                              ),
                                          child: CardMyService(
                                            ProductModel: product,
                                            favoriteFunction:
                                                () => favouriteController
                                                    .addFavorite(
                                                      product.id.toString(),
                                                    ),
                                          ),
                                        );
                                      } else {
                                        return ProductCardShimmer();
                                      }
                                    },
                                  ),
                                ),
                      ),
                    ],
                  ),
                ),

                // مؤشر التحميل فوق العناصر
                if (favouriteController.isLoadingcFavourie.value)
                  const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
