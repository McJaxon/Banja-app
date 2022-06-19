import 'dart:async';

import 'package:banja/controllers/authControllers.dart';
import 'package:banja/controllers/userDetailsController.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/shared/shared.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  bool userHasProfile = GetStorage().read('userHasProfileAlready') ?? false;
  final UserDetailsController userDetails = Get.find();
  var authController = Get.put(AuthController());
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 740));

    if (!userHasProfile) {
      Timer.run(() {
        // ignore: void_checks
        return userDetails.showRegPop(context, _controller);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageHeader(
          heading: 'Settings',
          canPop: false,
        ),
        Positioned(
            left: 20.w,
            right: 20.w,
            top: 145.h,
            child: Text(
              'Here you view your bio info, app details and learn more about our services and products',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 19.sp),
            )),
        Padding(
          padding: EdgeInsets.only(top: 250.h),
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            children: [
              Row(
                children: [
                  Text(
                    'User Details',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 20.sp),
                  ),
                  const Spacer(),
                  !userHasProfile
                      ? TextButton.icon(
                          onPressed: () {
                            userDetails.showRegPop(context, _controller);
                          },
                          icon: SvgPicture.asset('assets/images/Edit.svg'),
                          label: Text(
                            'Add Profile',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 17.sp),
                          ))
                      : Container()
                ],
              ),
              SizedBox(height: 10.h),
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey.shade100,
                      borderRadius: BorderRadius.circular(12.r)),
                  child: Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Name',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp),
                            ),
                            const Spacer(),
                            Text(
                              GetStorage().read('fullNames') ?? '-',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Text(
                              'User ID',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp),
                            ),
                            const Spacer(),
                            Text(
                              GetStorage().read('userID').toString(),
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Text(
                              'Phone number',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp),
                            ),
                            const Spacer(),
                            Text(
                              GetStorage().read('phoneNumber') ?? '-',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Text(
                              'Email Address',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp),
                            ),
                            const Spacer(),
                            Text(
                              GetStorage().read('emailAddress') ?? '-',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Text(
                              'Location',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp),
                            ),
                            const Spacer(),
                            Text(
                              GetStorage().read('location') ?? '-',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Text(
                              'Account Status',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp),
                            ),
                            const Spacer(),
                            Container(
                              width: 20.w,
                              height: 20.w,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              'Active',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
              SizedBox(
                height: 30.h,
              ),
              Text(
                'App Details',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 20.sp),
              ),
              SizedBox(height: 10.h),
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey.shade100,
                      borderRadius: BorderRadius.circular(12.r)),
                  child: Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Name',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp),
                            ),
                            const Spacer(),
                            Text(
                              'Tuula',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Text(
                              'Version',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp),
                            ),
                            const Spacer(),
                            Text(
                              'v.2.0',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                height: 20.h,
              ),
              BouncingWidget(
                onPressed: () {
                  authController.showAboutDialog(context);
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey.shade200,
                      borderRadius: BorderRadius.circular(40.r)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Lean more about Tuula',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              BouncingWidget(
                onPressed: () {
                  authController.showPolicyDialog(context);
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey.shade200,
                      borderRadius: BorderRadius.circular(40.r)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Lean more our Privacy Policy',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 120.h,
              ),
            ],
          ),
        )
      ]),
    );
  }
}
