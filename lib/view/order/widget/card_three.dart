import 'package:flutter/material.dart';
import 'package:mersal/model/products_model.dart';

import '../../../core/class/helper_functions.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/styles.dart';

class CardThree extends StatelessWidget {
  final String price;final ProductModel productModel;
  const CardThree({super.key, required this.price, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Container(
         width: HelperFunctions.screenWidth(),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: AppColors.whiteColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text('السعر',style: Styles.style4.copyWith(color: AppColors.primaryColorBold)),
                Text('$price £ ',style: Styles.style4.copyWith(color: AppColors.primaryColorBold))
              ],),
              Divider(height: 5,color: AppColors.whiteColor2,),
                   Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text('رسوم التوصيل',style: Styles.style4.copyWith(color: AppColors.primaryColorBold)),
                Text('40.00 £ ',style: Styles.style4.copyWith(color: AppColors.primaryColorBold))
              ],),
                   Divider(height: 5,color: AppColors.whiteColor2,),
                   Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text('رسوم الخدمه ',style: Styles.style4.copyWith(color: AppColors.primaryColorBold)),
                Text('40.00 £ ',style: Styles.style4.copyWith(color: AppColors.primaryColorBold))
              ],),
                   Divider(height: 5,color: AppColors.whiteColor2,),
                   Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text(' الخصم ',style: Styles.style4.copyWith(color: AppColors.primaryColorBold)),
                Text(productModel.discountInfo.hasDiscount?productModel.discountInfo.discountValue!:"0",style: Styles.style4.copyWith(color: AppColors.primaryColorBold))
              ],),
                  Divider(height: 5,color: AppColors.whiteColor2,),
                   Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text('المبلغ الاجمالى',style: Styles.style4.copyWith(color: AppColors.primaryColorBold)),
                 Text(productModel.discountInfo.finalPrice.toString(),style: Styles.style4.copyWith(color: AppColors.primaryColor,fontWeight: FontWeight.w600))
           
              ],),
          
          
          
          
          
          
          
          
          
          
          
              
            ],
          ),
        ),
    );
  }
}