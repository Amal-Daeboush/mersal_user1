import 'package:flutter/material.dart';
import 'package:mersal/core/constant/app_colors.dart';
import 'package:mersal/core/constant/styles.dart';
import 'package:mersal/data/model/food_type_model.dart';

class TypeSelect extends StatelessWidget {
  final FoodTypeModel foodTypeModel;
  final bool isSelect;
  const TypeSelect({
    super.key,
    required this.foodTypeModel,
    required this.isSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isSelect ? AppColors.primaryColor : AppColors.backgroundColor,
        border: Border.all(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          foodTypeModel.title,
          style: Styles.style12.copyWith(
            color: isSelect ? Colors.white : AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
