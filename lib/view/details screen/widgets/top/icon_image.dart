  import 'package:flutter/material.dart';

import '../../../../core/constant/app_colors.dart';



  //build icon  Widget _buildIcon(IconData icon, Color color) {

Widget buildIcon(IconData icon, Color color,void Function()? onTap) {
    return InkWell(
      onTap:onTap ,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: color,
        ),
        child: Icon(icon, size: 17, color: AppColors.whiteColor),
      ),
    );
  }