// ignore_for_file: prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables
//apple-svgrepo-com.svg

import 'package:agri_well/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class NewPlantCard extends StatelessWidget {
  final String label;
  final String imageUrl;
  final String sName;
  final VoidCallback onTap;

  NewPlantCard(
      {required this.label,
      required this.imageUrl,
      required this.onTap,
      required this.sName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 15.h, left: 20.w, right: 20.w),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFEEEEEE),
                blurRadius: 44,
                blurStyle: BlurStyle.outer,
              ),
            ]),
        height: 110.h,
        width: double.infinity,
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              height: 100.h,
              width: 90.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                color: Color(0xFFF9F9F9),
                // color: Colors.amber,
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SvgPicture.asset(
                  'assets/$imageUrl',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: kTextColor,
                    ),
                  ),
                  Text(
                    sName,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(
                        0xFFC8CEC6,
                      ),
                    ),
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
