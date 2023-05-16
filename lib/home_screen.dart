// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:agri_well/account_info_screen.dart';
import 'package:agri_well/components/card.dart';
import 'package:agri_well/constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:agri_well/leaf_scan.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'HomeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: const Color(0xffe9edf1),
      systemNavigationBarColor: secondaryColor,
    ));

    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    'assets/LogoSvg.svg',
                    width: 40,
                    height: 40,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (builder) {
                        return AccountInfoScreen();
                      }));
                    },
                    icon: Icon(
                      FontAwesomeIcons.user,
                      size: 23.h,
                    ),
                  )
                ],
              ),
            ),
            //

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ClipRRect(
                child: Image.asset(
                  'assets/new_banner.png',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10.0,
                left: 20,
              ),
              child: Text(
                'Select Crop',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: kTextColor,
                ),
              ),
            ),
            Flexible(
              child: ListView(
                physics: BouncingScrollPhysics(),
                // clipBehavior: Clip.none,
                scrollDirection: Axis.vertical,

                children: [
                  SizedBox(
                    height: 12.h,
                  ),
                  NewPlantCard(
                    label: 'Apple',
                    sName: 'Malus pumila',
                    imageUrl: 'apple-svgrepo-com.svg',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const LeafScan(modelName: 'Apple'),
                        ),
                      );
                    },
                  ),
                  NewPlantCard(
                    label: 'BellPepper',
                    sName: 'Capsicum annuum',
                    imageUrl: 'bell-pepper-svgrepo-com.svg',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const LeafScan(modelName: 'BellPepper'),
                        ),
                      );
                    },
                  ),
                  NewPlantCard(
                    label: 'Cherry',
                    sName: 'Prunus avium',
                    imageUrl: 'cherry-svgrepo-com(1).svg',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const LeafScan(modelName: 'Cherry'),
                        ),
                      );
                    },
                  ),
                  NewPlantCard(
                    label: 'Corn',
                    sName: 'Zea mays',
                    imageUrl: 'corn-svgrepo-com.svg',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const LeafScan(modelName: 'Corn'),
                        ),
                      );
                    },
                  ),
                  NewPlantCard(
                    label: 'Grape',
                    sName: 'Vitis vinifera',
                    imageUrl: 'grapes-grape-svgrepo-com.svg',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const LeafScan(modelName: 'Grape'),
                        ),
                      );
                    },
                  ),
                  NewPlantCard(
                    label: 'Peach',
                    sName: 'Prunus persica',
                    imageUrl: 'peach-svgrepo-com.svg',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const LeafScan(modelName: 'Peach'),
                        ),
                      );
                    },
                  ),
                  NewPlantCard(
                    label: 'Potato',
                    sName: 'Solanum tuberosum',
                    imageUrl: 'potato-svgrepo-com.svg',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const LeafScan(modelName: 'Potato'),
                        ),
                      );
                    },
                  ),
                  NewPlantCard(
                    label: 'Rice',
                    sName: 'Oryza sativa',
                    imageUrl: 'sheaf-of-rice-svgrepo-com(1).svg',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const LeafScan(modelName: 'Rice'),
                        ),
                      );
                    },
                  ),
                  NewPlantCard(
                    label: 'Tomato',
                    sName: 'Solanum lycopersicum',
                    imageUrl: 'tomato-svgrepo-com.svg',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const LeafScan(modelName: 'Tomato'),
                        ),
                      );
                    },
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
