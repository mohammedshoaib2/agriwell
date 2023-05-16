// ignore_for_file: prefer_const_constructors

import 'package:agri_well/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomNavBar extends StatelessWidget {
  final String title;

  const CustomNavBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_rounded,
            ),
          ),
          Text(
            title,
            style: TextStyle(
                color: kTextColor,
                fontFamily: 'Poppins',
                fontSize: 20.sp,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
