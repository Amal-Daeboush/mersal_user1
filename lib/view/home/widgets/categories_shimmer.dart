import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget CategoriesShimmer({required double width, required double height, }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
       
        ),
      ),
    );}