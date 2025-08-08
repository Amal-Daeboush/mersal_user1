import 'package:flutter/material.dart';
import 'package:mersal/model/product_order_model.dart';

import '../../../core/class/helper_functions.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/styles.dart' show Styles;

class ProductInfoCard extends StatelessWidget {
  final Product product;
  const ProductInfoCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
      child: Container(
        width: HelperFunctions.screenWidth() / 2.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.primaryColor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    product.productImages!.first.imageUrl!,
                    fit: BoxFit.cover,
                    width: HelperFunctions.screenWidth() / 3,
                    height: HelperFunctions.screenWidth() / 3,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Center(
              child: Text(
                product.productName!,
                style: Styles.style1.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              " الكمية: ${product.quantity}",
              style: Styles.style4.copyWith(color: AppColors.black),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: " السعر: ${product.totalPrice}  ",
                    style: Styles.style4.copyWith(color: AppColors.black),
                  ),
                        if (product.discount != null)
                         TextSpan(
                    text: "- ${product.discount!.value}% ",
                    style: Styles.style4.copyWith(color: AppColors.red),
                  ),
                ],
              ),
            ),
          
          ],
        ),
      ),
    );
  }
}
