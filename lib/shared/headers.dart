import 'package:banja/controllers/homePageController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'clippers.dart';

class AuthPageHeader extends StatelessWidget {
  const AuthPageHeader({
    required this.heading,
    this.trigger = false,
    Key? key,
  }) : super(key: key);
  final String heading;
  final bool trigger;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        !trigger
            ? ClipPath(
                clipper: LoginPageClipper(),
                child: Container(
                    height: 402.h,
                    width: double.infinity,
                    decoration: const BoxDecoration(color: Color(0xff06919A))),
              )
            : ClipPath(
                clipper: LoginPageAlternativeClipper(),
                child: Container(
                  height: 202.h,
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Color(0xff06919A)),
                  child: Padding(
                    padding: EdgeInsets.only(top: 90.h, left: 20.w),
                    child: Text(
                      heading,
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 26.0),
                    ),
                  ),
                ),
              ),
        !trigger
            ? ClipPath(
                clipper: LoginPageSmallClipper(),
                child: Container(
                    height: 286.h,
                    width: 258.w,
                    decoration: const BoxDecoration(color: Color(0xff0EA2AC))),
              )
            : ClipPath(
                clipper: LoginPageSmallAlternativeClipper(),
                child: Container(
                    height: 286.h,
                    width: 258.w,
                    decoration: const BoxDecoration(color: Color(0xff0EA2AC))),
              ),
        !trigger
            ? Positioned(
                right: 20.w,
                top: 180.h,
                child: Image.asset(
                  'assets/images/Vector.png',
                  width: 166.w,
                ))
            : Container(),
        !trigger
            ? Padding(
                padding: EdgeInsets.only(top: 70.h, left: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/tuula_logo.png',
                      width: 150.w,
                    ),
                    SizedBox(height: 10.h),
                    const Text('Tuula Financial Services Limited',
                        style: TextStyle(
                            color: Colors.white60,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins',
                            fontSize: 20.5)),
                  ],
                ),
              )
            : Container(),
        Positioned(
            left: 20.w,
            top: 260.h,
            child: Text(
              heading,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 26.sp),
            ))
      ],
    );
  }
}

class PageHeader extends StatelessWidget {
  PageHeader({
    required this.heading,
    this.canPop = true,
    Key? key,
  }) : super(key: key);
  final String heading;
  final bool canPop;

  var homeController = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: PageClipper(),
          child: Container(
              height: 322.h,
              width: double.infinity,
              decoration: const BoxDecoration(color: Color(0xff06919A))),
        ),
        ClipPath(
          clipper: LoginPageSmallClipper(),
          child: Container(
              height: 286.h,
              width: 258.w,
              decoration: const BoxDecoration(color: Color(0xff0EA2AC))),
        ),
        Positioned(
          left: 20.w,
          top: 50.h,
          child: Container(
            width: 50.0,
            height: 40.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: Colors.white12),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 25.w,
              ),
              onPressed: () {
                HapticFeedback.lightImpact();
                if (canPop) {
                  Navigator.pop(context);
                } else {
                  homeController.currentPage.value = 0;
                  homeController.pageController.animateToPage(0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.decelerate);
                }
              },
            ),
          ),
        ),
        Positioned(
            left: 20.w,
            top: 105.h,
            child: Text(
              heading,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 26.sp),
            ))
      ],
    );
  }
}
