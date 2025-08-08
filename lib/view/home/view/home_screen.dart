import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mersal/core/class/status_request.dart';
import 'package:mersal/core/constant/app_image_asset.dart';
import 'package:mersal/core/constant/const_data.dart';
import 'package:mersal/core/constant/styles.dart';
import 'package:mersal/view/address/view/address.dart';
import 'package:mersal/view/details%20screen/view/details_screen.dart';
import 'package:mersal/view/favourite/controller/favourite_controller.dart';
import 'package:mersal/view/home/controller/home_controller.dart';
import 'package:mersal/view/home/view/all_product_screen.dart';
import 'package:mersal/view/home/widgets/categories_shimmer.dart';
import 'package:mersal/view/home/widgets/card_top_product.dart';
import 'package:mersal/view/home/widgets/restaurant_card.dart';
import 'package:mersal/view/restaurant%20screen/view/restaurants_screen.dart';
import 'package:mersal/view/widgets/app%20bar/container_app_bar.dart';
import 'package:mersal/view/widgets/shimmer/product_shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../core/constant/app_colors.dart';
import '../../my_service/view/myservice_screen.dart';
import '../../widgets/custom_licart_card_view/custom_service.dart';
import '../../widgets/icons/notification_icon.dart';
import '../widgets/custom_page_view.dart';
import '../widgets/custom_rich_text.dart';
import '../widgets/custom_row_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FavouriteController favouriteController = Get.find();

    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          body: Column(
            children: [
              ContainerAppBar(
                isSearch: true,
                child: InkWell(
                  onTap: () => Get.to(AddressScreen(isfromHome: true)),
                  child: ListTile(
                    leading: SvgPicture.asset(AppImageAsset.ic_pin),
                    title: Text(
                      'العنوان',
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontFamily: 'Cairo',
                        fontSize: 16.sp,
                      ),
                    ),
                    subtitle: Text(
                      ConstData.addressUser,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 14.sp,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    trailing: NotificationIcon(),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: controller.scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomRowText(
                          text1: 'عروض خاصة بك',
                          text2: 'الكل',
                        ),
                        SizedBox(height: 5.h),
                        SizedBox(
                          height: 170.h,
                          child: PageView.builder(
                            itemCount: 3,
                            onPageChanged: (index) {
                              controller.setActiveIndex(index);
                            },
                            itemBuilder:
                                (context, index) => const CustompageView(),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Center(
                          child: AnimatedSmoothIndicator(
                            activeIndex: controller.activeIndex,
                            count: 3,
                            effect: SwapEffect(
                              dotHeight: 10,
                              dotWidth: 10,
                              dotColor: AppColors.primaryColorWithOpacity,
                              activeDotColor: AppColors.primaryColorBold,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        const CustomRowText(text1: 'خدماتنا'),
                        SizedBox(height: 5.h),
                        controller.statusRequest == StatusRequest.loading
                            ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  4,
                                  (index) => Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: CategoriesShimmer(
                                      width: 50,
                                      height: 50,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            : controller.statusRequest ==
                                    StatusRequest.failure ||
                                controller.statusRequest ==
                                    StatusRequest.offlineFailure
                            ? Center(
                              child: Text(
                                controller.message,
                                style: Styles.style3.copyWith(
                                  color: Colors.red,
                                ),
                              ),
                            )
                            : controller.filteredCategories.isEmpty
                            ? Center(
                              child: Text(
                                'لا يوجد نتائج',
                                style: Styles.style5.copyWith(
                                  color: Colors.red,
                                ),
                              ),
                            )
                            : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children:
                                    controller.filteredCategories
                                        .map(
                                          (cat) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 5,
                                            ),
                                            child: GestureDetector(
                                              //  splashColor: Colors.transparent,
                                              onTap:
                                                  cat.type == '2'
                                                      ? () {
                                                        Get.to(
                                                          RestaurantsScreen(
                                                            id: cat.id,
                                                          ),
                                                        );
                                                      }
                                                      : () => Get.to(
                                                        MyserviceScreen(
                                                          isProductProv: false,
                                                          id: cat.id,
                                                          title: cat.name,
                                                        ),
                                                      ),
                                              child: CustomService(
                                                image: cat.imag,
                                                id: cat.id,
                                                isSelected: false,
                                                name: cat.name,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                              ),
                            ),

                        /* ?SizedBox(
                              height: 100.h,
                              child: ListView.builder(
                                controller: controller.categoryScrollController,
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    1 +
                                    controller.productProviders.length +
                                    controller.filteredCategories.length +
                                    (controller.isLoadingMoreProvider ? 1 : 0),
                                itemBuilder: (context, index) {
                                  if (index == 0) {
                                    return SizedBox();
                                    // 🔵 عنصر "مطاعم"
                                    /*  return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        onTap: () {
                                          // مثال: الانتقال إلى شاشة المطاعم
                                          Get.to(
                                            RestaurantsScreen(),
                                          ); // أو شاشة مخصصة للمطاعم
                                        },
                                        child: const CustomService(
                                          id: -1,
                                          isSelected: false,
                                          name: 'مطاعم',
                                        ),
                                      ),
                                    ); */
                                  }

                                  int adjustedIndex =
                                      index - 1; // لأن "مطاعم" أخذت index = 0
                                  int providerCount =
                                      controller.productProviders.length;

                                  if (adjustedIndex < providerCount) {
                                    final prov =
                                        controller
                                            .productProviders[adjustedIndex];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        onTap:
                                            () => Get.to(
                                              MyserviceScreen(
                                                isProductProv: true,
                                                id: prov.vendor.id,
                                                title: prov.user.name,
                                              ),
                                            ),
                                        child: CustomService(
                                          id: prov.vendor.id,
                                          isSelected: false,
                                          name: prov.user.name,
                                        ),
                                      ),
                                    );
                                  } else if (adjustedIndex <
                                      providerCount +
                                          controller
                                              .filteredCategories
                                              .length) {
                                    final cat =
                                        controller
                                            .filteredCategories[adjustedIndex -
                                            providerCount];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        onTap:
                                            cat.type == '2'
                                                ? () {
                                                  Get.to(
                                                    RestaurantsScreen(
                                                      id: cat.id,
                                                    ),
                                                  );
                                                }
                                                : () => Get.to(
                                                  MyserviceScreen(
                                                    isProductProv: false,
                                                    id: cat.id,
                                                    title: cat.name,
                                                  ),
                                                ),
                                        child: CustomService(
                                          id: cat.id,
                                          isSelected: false,
                                          name: cat.name,
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: CategoriesShimmer(
                                        width: 50,
                                        height: 50,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ), */
                        const SizedBox(height: 10),
                        CustomRowText(
                          onTap: () => Get.to(AllProductScreen()),
                          text1: 'أعلى الخدمات',
                          text2: 'الكل',
                        ),
                        SizedBox(height: 5.h),
                        controller.statusRequest == StatusRequest.loading
                            ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  4,
                                  (index) => ProductCardShimmer(),
                                ),
                              ),
                            )
                            : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children:
                                    controller.products
                                        .map(
                                          (product) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 5,
                                            ),
                                            child: CardTopProduct(
                                              ontap:
                                                  () => Get.to(
                                                    DetailsScreen(
                                                      productModel: product,
                                                    ),
                                                  ),
                                              height: 100.h,
                                              favoriteFunction:
                                                  () => favouriteController
                                                      .addFavorite(
                                                        product.id.toString(),
                                                      ),
                                              productModel: product,
                                            ),
                                          ),
                                        )
                                        .toList(),
                              ),
                            ),
                        SizedBox(height: 15.h),
                        CustomRichText(),
                        SizedBox(height: 5.h),
                        RestaurantCard(),
                        SizedBox(height: 50.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
