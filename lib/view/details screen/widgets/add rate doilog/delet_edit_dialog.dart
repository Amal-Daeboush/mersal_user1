import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mersal/data/model/rating_model.dart';
import 'package:mersal/view/details%20screen/controller/details_controller.dart';
import 'package:mersal/view/details%20screen/widgets/add%20rate%20doilog/edit_rate_dialog.dart';
import 'package:mersal/view/widgets/custom_loading.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/styles.dart';

void showDeleteDialogDialog(
  BuildContext context,
  RatingsModel replay,
  DetailsController controller,
) {
  showDialog(
    context: context,
    builder: (context) {
      return Obx(
        () => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Center(
            child: Text('عدل او احذف التقييم', style: Styles.style1),
          ),

          content: Stack(
            alignment: Alignment.center,
            children: [
              Opacity(
                opacity: controller.isLoading.value ? 0.5 : 1.0,
                child: AbsorbPointer(
                  absorbing: controller.isLoading.value,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                        //  Navigator.pop(context);  
                         Get.back();
                          showEditRateDialog(context, replay, controller);
                       
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                          //  horizontal: 8,
                          ),
                          child: Text(
                            'تعديل التقييم',
                            style: Styles.style4.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,)
                   ,   ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          await controller.deleteRate(
                            replay.id.toString(),
                            replay.id.toString(),
                            context
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                       //     horizontal: 8,
                          ),
                          child: Text(
                            'حذف التقييم',
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
              if (controller.isLoading.value)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: customLoadingIndictor(),
                ), // ✅
            ],
          ),
        ),
      );
    },
  );
}
