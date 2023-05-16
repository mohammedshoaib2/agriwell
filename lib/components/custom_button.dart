// ignore_for_file: prefer_const_constructors

import 'package:agri_well/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Color clr;
  final VoidCallback onTap;

  const CustomButton(
      {super.key, required this.label, required this.clr, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 55.h,
        width: 135.w,
        decoration: BoxDecoration(
          color: clr,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
            color: kWhiteColor,
          ),
        ),
      ),
    );
  }
}
