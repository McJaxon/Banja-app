import 'dart:async';

import 'package:banja/controllers/authControllers.dart';
import 'package:banja/controllers/userDetailsController.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/headers.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  final UserDetailsController userDetails = Get.find();
  var authController = Get.put(AuthController());
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 740));
    bool userHasProfile = GetStorage().read('userHasProfileAlready') ?? false;
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
              Text(
                'User Details',
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
                              'v.5.3',
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
                height: 120.h,
              ),
            ],
          ),
        )
      ]),
    );
  }
}
