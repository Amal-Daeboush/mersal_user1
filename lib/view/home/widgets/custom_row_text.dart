import 'package:flutter/material.dart';
import 'package:mersal/core/constant/styles.dart';

class CustomRowText extends StatelessWidget {
  final String? text1;
  final String? text2;
  final void Function()? onTap;
  const CustomRowText({super.key, this.text1, this.text2, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text1!, style: Styles.style1_copy1),
        InkWell(
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: onTap,
          child: Text(text2 ?? '', style: Styles.style1_copy1),
        ),
      ],
    );
  }
}
