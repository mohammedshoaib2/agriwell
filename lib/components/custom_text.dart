// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:agri_well/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  final String headText;
  final String BottomText;

  const CustomText({
    super.key,
    required this.headText,
    required this.BottomText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          headText,
          style: kTextStyle,
        ),
        Text(
          BottomText,
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 38.sp,
              fontWeight: FontWeight.w900,
              color: kTextColor),
        ),
      ],
    );
  }
}
