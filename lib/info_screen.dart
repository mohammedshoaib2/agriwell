// ignore_for_file: prefer_const_constructors

import 'package:agri_well/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0.2,
        title: Text(
          'About',
          style: TextStyle(color: kTextColor),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.10,
          ),
          Expanded(
            child: ListView(
              clipBehavior: Clip.none,
              physics: BouncingScrollPhysics(),
              children: [
                CarouselSlider(
                    items: const [
                      DeveloperDetails(
                        name: 'Mohammed Shoaib',
                        title:
                            'Flutter Developer and User \nInterface Designer(UI/UX)',
                        linkedinUrl: 'www.linkedin.com',
                        linkedInPath: '/in/mohammed-shoaib-10bb6a19a',
                        twitterUrl: 'twitter.com',
                        twitterPath: '/thizisshoaib',
                        url: shoaibProfileUrl,
                        boxFit: BoxFit.contain,
                      ),
                      DeveloperDetails(
                        name: 'Mohammed Faisal \nUddin',
                        title: 'Flutter Trainee and\nUser Interface Designer',
                        linkedinUrl: 'www.linkedin.com',
                        linkedInPath: '/in/faisal-uddin-9b43091b2',
                        twitterUrl: 'twitter.com',
                        twitterPath: '/faixallll',
                        url: faisalProfileUrl,
                        boxFit: BoxFit.cover,
                      ),
                      DeveloperDetails(
                        name: 'Mohammed Azhar\nUddin',
                        title: 'User Interface Designer\nand Content Provider',
                        linkedinUrl: 'www.linkedin.com',
                        linkedInPath: '/in/mohammed-azhar-uddin-127a61239',
                        twitterUrl: 'twitter.com',
                        twitterPath: '/mohdazhar059',
                        url: azharProfilrUrl,
                        boxFit: BoxFit.contain,
                      ),
                    ],
                    options: CarouselOptions(
                      height: 459.0,
                      enlargeCenterPage: false,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: false,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      viewportFraction: 0.8,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DeveloperDetails extends StatelessWidget {
  final String url;
  final String name;
  final String title;
  final String linkedinUrl;
  final String linkedInPath;
  final String twitterUrl;
  final String twitterPath;
  final BoxFit boxFit;

  const DeveloperDetails(
      {super.key,
      required this.url,
      required this.boxFit,
      required this.name,
      required this.linkedInPath,
      required this.twitterPath,
      required this.title,
      required this.linkedinUrl,
      required this.twitterUrl});

  Future openUrl(String link, String path) async {
    var completeUri = Uri.https(link, path);

    var openLink = await canLaunchUrl(completeUri);

    if (openLink) {
      await launchUrl(completeUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(25.h),
      height: 319.h,
      width: 500.w,
      decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFF4F4F5),
              blurRadius: 10.0,
              spreadRadius: 4,
              blurStyle: BlurStyle.outer,
            )
          ]),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 40.h),
            height: 130.h,
            width: 130.w,
            decoration: BoxDecoration(
                color: kWhiteColor,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(url),
                ),
                shape: BoxShape.circle,
                border: Border.all(color: kWhiteColor, width: 5)),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            name,
            textAlign: TextAlign.center,
            style: kTextStyle.copyWith(fontSize: 18.sp),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            'Hyderabad, TS, India',
            textAlign: TextAlign.center,
            style: kTextStyle.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w300,
                color: Colors.grey),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: kTextStyle.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    await openUrl(linkedinUrl, linkedInPath);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20.h, right: 5.h),
                    alignment: Alignment.center,
                    height: 60.h,
                    decoration: BoxDecoration(
                        color: kGreenColor,
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Text(
                      'Linkedin',
                      style: kTextStyle.copyWith(
                          color: kWhiteColor, fontSize: 14.sp),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    await openUrl(twitterUrl, twitterPath);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 5.w, right: 20.w),
                    alignment: Alignment.center,
                    height: 60.h,
                    decoration: BoxDecoration(
                        border: Border.all(color: kDarkGreen),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Text(
                      'Twitter',
                      style: kTextStyle.copyWith(
                          color: kDarkGreen, fontSize: 14.sp),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }
}
