// ignore_for_file: prefer_const_constructors

import 'package:agri_well/constants.dart';
import 'package:agri_well/details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResultPage extends StatelessWidget {
  static const String id = 'ResultPage';
  final String pickedImage;
  final String disease;
  final String confidence;
  final String plantName;

  // ignore: prefer_const_constructors_in_immutables
  ResultPage(
      {super.key,
      required this.pickedImage,
      required this.disease,
      required this.confidence,
      required this.plantName});

  @override
  Widget build(BuildContext context) {
    double convertedConfidence = double.parse(confidence);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Result',
            style: TextStyle(color: kTextColor),
          ),
          elevation: 0,
          backgroundColor: kWhiteColor,
          leading: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: kTextColor,
            ),
          ),
        ),
        backgroundColor: kWhiteColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                height: 250.h,
                width: double.infinity,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: pickedImage,
                      fit: BoxFit.fill,
                      placeholder: (context, url) {
                        return getShimmerLoading(
                          height: 250,
                          width: 250,
                          radiius: 10,
                        );
                      },
                    )),
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: kRoundedContainerColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                disease,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.w600,
                                  color: kTextColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Confidence : $confidence%',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: kLightColor2,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        'The AgriWell Plant Leaf Disease Detection app is an advanced mobile application designed to help farmers, gardeners, and other plant enthusiasts quickly and accurately detect and diagnose diseases in their plants',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: kLightColor1,
                        ),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return DetailScreen(
                              confidence: convertedConfidence,
                              disease: disease,
                              imageUrl: pickedImage,
                              docId: 'null',
                              isFromResultScreen: true,
                              plantName: plantName,
                              time: DateTime.now(),
                              user: null,
                            );
                          }));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: kGreenColor,
                              borderRadius: BorderRadius.circular(50.r)),
                          height: 68.h,
                          width: 41.h,
                          child: Text(
                            'View Treatment',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                              color: kWhiteColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
