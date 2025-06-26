import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mersal/core/class/status_request.dart';
import 'package:mersal/core/constant/styles.dart';
import 'package:mersal/view/favourite/controller/favourite_controller.dart';
import 'package:mersal/view/favourite/widget/card_favorite.dart';
import 'package:mersal/view/widgets/shimmer/product_shimmer.dart';
import '../widget/favourite_app_bar.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final FavouriteController controller = Get.find();

    // استدعاء التحديث مباشرة عند بناء الصفحة
    controller.getFavorites();
    return Scaffold(
      body: GetBuilder(
        init: FavouriteController(),
        builder: (controller) {
          return Column(
            children: [
              FavouriteAppBar(
                controller: controller.searchController,

                onChanged: (value) {
                  controller.filterMFavourites(value);
                },
              ),
              SizedBox(height: 10.h),
              controller.statusRequest == StatusRequest.loading
                  ? Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 0,
                                crossAxisSpacing: 5,
                                crossAxisCount: 2,
                              ),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return ProductCardShimmer();
                          },
                          /*  CardMyService(
                            serviceModel: controller.favourite[index],
                          ), */
                        ),
                      ),
                    ),
                  )
                  : controller.statusRequest == StatusRequest.failure
                  ? Center(
                    child: Text(
                      controller.message,
                      style: Styles.style3.copyWith(color: Colors.red),
                    ),
                  )
                  : controller.statusRequest == StatusRequest.offlineFailure
                  ? Center(
                    child: Text(
                      controller.message,
                      style: Styles.style3.copyWith(color: Colors.red),
                    ),
                  )
                  : controller.filteredFavourite.isEmpty
                  ? Center(
                    child: Text(
                      'لا يوجد نتائج',
                      style: Styles.style2.copyWith(color: Colors.red),
                    ),
                  )
                  : Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 0,
                                crossAxisSpacing: 5,
                                crossAxisCount: 2,
                              ),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.filteredFavourite.length,
                          itemBuilder: (context, index) {
                            return CardFavorite(
                              deleteFav:
                                  () => controller.deleteFavorite(
                                    controller.filteredFavourite[index].id
                                        .toString(),
                                  ),
                              favouriteModel:
                                  controller.filteredFavourite[index],
                            );
                          },
                          /*  CardMyService(
                            serviceModel: controller.favourite[index],
                          ), */
                        ),
                      ),
                    ),
                  ),
            ],
          );
        },
      ),
    );
  }
}
