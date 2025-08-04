import 'package:flutter/material.dart';
import 'package:mersal/core/constant/app_colors.dart';

class OrderButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final bool isprimary;

  const OrderButton({
    super.key,
    required this.title,
    this.onPressed,
   required this.isprimary,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isprimary ? AppColors.primaryColor : AppColors.border,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Cairo',
                color: isprimary ? Colors.white : AppColors.black,
              ),
            ),
          ),
        ),
      ),
    ) /* ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    ) */;
  }
}
