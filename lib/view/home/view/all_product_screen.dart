import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mersal/core/class/status_request.dart';
import 'package:mersal/view/favourite/controller/favourite_controller.dart';
import 'package:mersal/view/home/controller/home_controller.dart';
import 'package:mersal/view/home/widgets/card_top_product.dart';
import 'package:mersal/view/widgets/shimmer/product_shimmer.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/styles.dart';
import '../../widgets/app bar/container_app_bar.dart';

class AllProductScreen extends StatelessWidget {
  AllProductScreen({super.key});
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final favouriteController = Get.find<FavouriteController>();
    final controller = Get.find<HomeController>();

    // أول تحميل
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getProducts(perPage: 10);
    });

    return Scaffold(
      body: SafeArea(
        child: GetBuilder<HomeController>(
          builder: (controller) {
            return Stack(
              children: [
                Opacity(
                  opacity:
                      favouriteController.isLoadingcFavourie.value ? 0.5 : 1.0,
                  child: Column(
                    children: [
                      ContainerAppBar(
                        isSearch: false,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              Icons.shopping_cart_outlined,
                              color: AppColors.whiteColor,
                            ),
                            Text(
                              'أعلى المنتجات',
                              style: Styles.style1.copyWith(
                                color: AppColors.whiteColor,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                color: AppColors.whiteColor,
                              ),
                              onPressed: () => Get.back(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Expanded(
                        child:
                            controller.statusRequest == StatusRequest.loading
                                ? GridView.builder(
                                  itemCount: 6,
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
                                )
                                : controller.products.isEmpty
                                ? const Center(child: Text("لا توجد منتجات"))
                                : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GridView.builder(
                                    controller: scrollController,
                                    padding: EdgeInsets.zero,
                                    itemCount: controller.products.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                          mainAxisExtent: 150,
                                          childAspectRatio: 0.7,
                                        ),
                                    itemBuilder: (context, index) {
                                      final product =
                                          controller.products[index];
                                      return CardTopProduct(
                                        productModel: product,
                                        favoriteFunction:
                                            () =>
                                                favouriteController.addFavorite(
                                                  product.id.toString(),
                                                ),
                                      );
                                    },
                                  ),
                                ),
                      ),
                    ],
                  ),
                ),
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
