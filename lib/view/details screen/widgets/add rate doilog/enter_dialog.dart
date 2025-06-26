import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mersal/view/details%20screen/controller/details_controller.dart';
import 'package:mersal/view/widgets/custom_loading.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/styles.dart';

void showRateDialog(BuildContext context, String id) {
  DetailsController detailsController = Get.find();
  final _formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (context) {
      return Obx(
        () => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Center(child: Text('اكتب تقييم للمنتج', style: Styles.style1)),
          content: Form(
            key: _formKey,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  opacity: detailsController.isLoading.value ? 0.5 : 1.0,
                  child: AbsorbPointer(
                    absorbing: detailsController.isLoading.value,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: detailsController.comment,
                          decoration: InputDecoration(
                            hintStyle: Styles.style12.copyWith(
                              color: AppColors.primaryColor,
                            ),
                            hintText: 'اكتب تعليق',
                            filled: true,
                            fillColor: AppColors.whiteColor2,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: detailsController.numrate,
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'ادخل التقييم';
                            final rating = int.tryParse(value);
                            if (rating == null) return 'ادخل رقماً صالحاً';
                            if (rating < 1 || rating > 5)
                              return 'التقييم من 1 إلى 5 فقط';
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'قيمنا من 5',
                            hintStyle: Styles.style12.copyWith(
                              color: AppColors.primaryColor,
                            ),
                            filled: true,
                            fillColor: AppColors.whiteColor2,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              detailsController.addRate(context);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 50,
                            ),
                            child: Text(
                              'تأكيد التقييم',
                              style: Styles.style4.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (detailsController.isLoading.value)
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 70),
                     child: customLoadingIndictor(),
                   ), // ✅
              ],
            ),
          ),
        ),
      );
    },
  );
}
