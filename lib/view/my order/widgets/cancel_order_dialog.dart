import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mersal/view/details%20screen/controller/details_controller.dart';
import 'package:mersal/view/my%20order/controller/my_orders_controller.dart';
import 'package:mersal/view/widgets/custom_loading.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/styles.dart';

void CancelOrderDialog(BuildContext context, String id) {
  MyOrdersController myOrdersController = Get.find();
 

  showDialog(
    context: context,
    builder: (context) {
      return Obx(
        () => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Center(child: Text('هل انت متأكد من الغاء الطلب', style: Styles.style1)),
          content: Stack(
            alignment: Alignment.center,
            children: [
              Opacity(
                opacity: myOrdersController.isLoading.value ? 0.5 : 1.0,
                child: AbsorbPointer(
                  absorbing: myOrdersController.isLoading.value,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      SizedBox(height: 20),
                      ElevatedButton(
                        
                        onPressed: () {
                        
                            myOrdersController.CancelOrder(context,id);
                          
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 50,
                          ),
                          child: Text(
                            'تأكيد الالغاء',
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
              if (myOrdersController.isLoading.value)
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
