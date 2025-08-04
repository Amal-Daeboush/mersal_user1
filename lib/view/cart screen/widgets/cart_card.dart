import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mersal/core/constant/app_colors.dart';
import 'package:mersal/core/constant/styles.dart';
import 'package:mersal/model/cart_model.dart';

class CartCard extends StatelessWidget {
  final CartModel cartModel;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final VoidCallback onDelete;

  const CartCard({
    super.key,
    required this.cartModel,
    required this.onAdd,
    required this.onRemove,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.lightGrey2,
          borderRadius: BorderRadius.circular(10.r)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(cartModel.productModel.images.first.url, width: 100.w, height: 100.h),
              SizedBox(width: 10.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cartModel.productModel.name, style: Styles.style1),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      IconButton(
                        onPressed: onAdd,
                        icon: const Icon(Icons.add_circle_outlined, size: 20),
                      ),
                      Text(
                        '${cartModel.quantityInCart}',
                        style: Styles.style1_copy1,
                      ),
                      IconButton(
                        onPressed: onRemove,
                        icon: const Icon(Icons.remove_circle_outlined, size: 20),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: onDelete,
                icon: const Icon(Iconsax.trash, color: AppColors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

