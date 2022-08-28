import 'dart:async';

import 'package:banja/animation/delay_fade.dart';
import 'package:banja/controllers/auth_controller.dart';
import 'package:banja/controllers/user_detail_controller.dart';
import 'package:banja/utils/customOverlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '/shared/shared.dart';
import 'auth/lock_screen.dart';

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
  bool isPINEnabled = GetStorage().read('pin_enabled') ?? false;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 740));

    if (!userHasProfile) {
      Timer.run(() {
        userDetails.showRegPop(context, _controller);
      });
    }
    super.initState();
  }

  Future<void> visitSite(String webLink) async {
    if (!await launchUrl(Uri.parse(
      webLink,
    ))) {
      throw 'Could not launch site';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(top: 250.h, right: 25.0, left: 25.w),
          children: [
            DelayedFade(
              delay: 230,
              child: Row(
                children: [
                  Text(
                    'User Details',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 21.sp),
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
            ),
            SizedBox(height: 10.h),
            DelayedFade(
              delay: 240,
              child: Container(
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
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.sp),
                            ),
                            const Spacer(),
                            Text(
                              GetStorage().read('fullNames') ?? '-',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w300,
                                  fontSize: 19.sp),
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
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.sp),
                            ),
                            const Spacer(),
                            Text(
                              GetStorage().read('userID').toString(),
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w300,
                                  fontSize: 19.sp),
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
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.sp),
                            ),
                            const Spacer(),
                            Text(
                              GetStorage().read('phoneNumber') ?? '-',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w300,
                                  fontSize: 19.sp),
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
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.sp),
                            ),
                            const Spacer(),
                            Text(
                              GetStorage().read('emailAddress') ?? '-',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w300,
                                  fontSize: 19.sp),
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
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.sp),
                            ),
                            const Spacer(),
                            Text(
                              GetStorage().read('location') ?? '-',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w300,
                                  fontSize: 19.sp),
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
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.sp),
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
                                  fontWeight: FontWeight.w300,
                                  fontSize: 19.sp),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
            ),
            SizedBox(
              height: 20.h,
            ),
            DelayedFade(
              delay: 250,
              child: Text(
                'App Details',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 21.sp),
              ),
            ),
            SizedBox(height: 10.h),
            DelayedFade(
              delay: 260,
              child: Container(
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
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.sp),
                            ),
                            const Spacer(),
                            Text(
                              'Tuula',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w300,
                                  fontSize: 19.sp),
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
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.sp),
                            ),
                            const Spacer(),
                            Text(
                              'v2.1.5',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w300,
                                  fontSize: 19.sp),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
            SizedBox(
              height: 20.h,
            ),
            DelayedFade(
              delay: 270,
              child: Text(
                'Privacy & Security',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 21.sp),
              ),
            ),
            SizedBox(height: 10.h),
            DelayedFade(
              delay: 280,
              child: Container(
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Enable Security Lock',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18.sp),
                                ),
                                Text(
                                  'Will require your PIN when you close the\napp',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16.sp),
                                ),
                              ],
                            ),
                            const Spacer(),
                            CupertinoSwitch(
                                value: isPINEnabled,
                                onChanged: (value) {
                                  HapticFeedback.selectionClick();
                                  if (GetStorage().read('user_pin') == null) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SetUpPin()));
                                  } else {
                                    setState(() {
                                      isPINEnabled = value;
                                    });
                                    GetStorage().write('pin_enabled', value);
                                  }
                                })
                          ],
                        ),
                        const Divider(),
                        SizedBox(
                          height: 10.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.selectionClick();
                            if (GetStorage().read('user_pin') != null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ChangePin()));
                            } else {
                              CustomOverlay.showToast(
                                  'You have no PIN set up',
                                  const Color.fromARGB(255, 197, 118, 0),
                                  Colors.white);
                            }
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Text(
                                  'Change Tuula PIN',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18.sp),
                                ),
                                const Spacer(),
                                const Icon(Icons.arrow_forward_ios_outlined)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            SizedBox(
              height: 20.h,
            ),
            DelayedFade(
              delay: 270,
              child: Text(
                'Docs & Resources',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 21.sp),
              ),
            ),
            SizedBox(height: 10.h),
            DelayedFade(
              delay: 280,
              child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey.shade100,
                      borderRadius: BorderRadius.circular(12.r)),
                  child: Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.selectionClick();
                            authController.showAboutDialog(context);
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Text(
                                  'Learn more about Tuula ',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18.sp),
                                ),
                                const Spacer(),
                                const Icon(Icons.arrow_forward_ios_outlined)
                              ],
                            ),
                          ),
                        ),
                        const Divider(),
                        SizedBox(
                          height: 10.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.selectionClick();
                            authController.showPolicyDialog(context);
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Text(
                                  'Learn more our Privacy Policy',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18.sp),
                                ),
                                const Spacer(),
                                const Icon(Icons.arrow_forward_ios_outlined)
                              ],
                            ),
                          ),
                        ),
                        const Divider(),
                        SizedBox(
                          height: 10.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.selectionClick();
                            visitSite('https://tuulacredit.com/');
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Text(
                                  'Visit our website',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18.sp),
                                ),
                                const Spacer(),
                                const Icon(Icons.arrow_forward_ios_outlined)
                              ],
                            ),
                          ),
                        ),
                        const Divider(),
                        SizedBox(
                          height: 10.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.selectionClick();
                            visitSite(
                                'https://play.google.com/store/apps/details?id=com.zaren.tuula');
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Text(
                                  'Rate us on Google Play',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18.sp),
                                ),
                                const Spacer(),
                                const Icon(Icons.arrow_forward_ios_outlined)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            SizedBox(
              height: 120.h,
            ),
          ],
        ),
        PageHeader(
          heading: 'Settings',
          canPop: false,
        ),
        Positioned(
            left: 20.w,
            right: 20.w,
            top: 145.h,
            child: DelayedFade(
              delay: 190,
              child: Text(
                'Here you view your bio info, app details and learn more about our services and products',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 19.sp),
              ),
            ))
      ]),
    );
  }
}
