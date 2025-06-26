import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mersal/data/model/rating_model.dart';
import 'package:mersal/view/details%20screen/controller/details_controller.dart';
import 'package:mersal/view/widgets/custom_loading.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/styles.dart';

void showEditRateDialog(
  BuildContext context,
  RatingsModel ratings,
  DetailsController controller,
) {
  DetailsController detailsController = Get.find();
  final _formKey = GlobalKey<FormState>();
  TextEditingController editController = TextEditingController(
    text: ratings.comment,
  );

  showDialog(
    context: context,
    builder: (context) {
      return Obx(
        () => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Center(
            child: Text(' تعديل تقييم للمنتج', style: Styles.style1),
          ),
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
                          controller: editController,
                          decoration: InputDecoration(
                            hintStyle: Styles.style12.copyWith(
                              color: AppColors.primaryColor,
                            ),
                            hintText: ratings.comment,
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

                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pop(context);
                              await detailsController.editRate(
                                ratings.id.toString(),
                                editController.text,
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 50,
                            ),
                            child: Text(
                              'تأكيد ',
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
