import 'dart:async';
import 'package:banja/controllers/authControllers.dart';
import 'package:banja/screens/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:slide_countdown/slide_countdown.dart';
import '../../utils/customOverlay.dart';
import '../../shared/shared.dart';

class PhoneOTP extends StatefulWidget {
  const PhoneOTP({Key? key, this.verificationId, this.tempPhone})
      : super(key: key);

  final String? verificationId;
  final String? tempPhone;

  @override
  State<PhoneOTP> createState() => _PhoneOTPState();
}

class _PhoneOTPState extends State<PhoneOTP> {
  final pref = GetStorage();
  final AuthController authController = Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool trigger = false;
  bool showResend = false;
  late Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 40), (Timer timer) {
      authController.showResend(true);
      timer.cancel();
    });

    authController.otp1.addListener(() {
      if (authController.otp1.hasFocus) {
        setState(() {
          trigger = true;
        });
      } else {
        setState(() {
          trigger = false;
        });
      }
    });
    authController.otp2.addListener(() {
      if (authController.otp2.hasFocus) {
        setState(() {
          trigger = true;
        });
      } else {
        setState(() {
          trigger = false;
        });
      }
    });
    authController.otp3.addListener(() {
      if (authController.otp3.hasFocus) {
        setState(() {
          trigger = true;
        });
      } else {
        setState(() {
          trigger = false;
        });
      }
    });
    authController.otp4.addListener(() {
      if (authController.otp4.hasFocus) {
        setState(() {
          trigger = true;
        });
      } else {
        setState(() {
          trigger = false;
        });
      }
    });
    authController.otp5.addListener(() {
      if (authController.otp5.hasFocus) {
        setState(() {
          trigger = true;
        });
      } else {
        setState(() {
          trigger = false;
        });
      }
    });
    authController.otp6.addListener(() {
      if (authController.otp6.hasFocus) {
        setState(() {
          trigger = true;
        });
      } else {
        setState(() {
          trigger = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          AuthPageHeader(
            heading: 'OTP\nVerification',
            trigger: trigger,
          ),
          Obx(() {
            return Padding(
              padding: EdgeInsets.only(top: trigger ? 200.h : 430.h),
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 27.w),
                shrinkWrap: true,
                children: <Widget>[
                  Center(
                    child: Text(
                      'An authorization code has been sent to your phone number +256 ${widget.tempPhone}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 13.0),
                    ),
                  ),
                  SizedBox(
                    height: 36.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      PinTextBox(
                        focusNode: authController.otp1,
                        textEditingController: authController.field1,
                      ),
                      PinTextBox(
                        focusNode: authController.otp2,
                        textEditingController: authController.field2,
                      ),
                      PinTextBox(
                        focusNode: authController.otp3,
                        textEditingController: authController.field3,
                      ),
                      PinTextBox(
                        focusNode: authController.otp4,
                        textEditingController: authController.field4,
                      ),
                      PinTextBox(
                        focusNode: authController.otp5,
                        textEditingController: authController.field5,
                      ),
                      PinTextBox(
                        focusNode: authController.otp6,
                        textEditingController: authController.field6,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 28.0,
                  ),
                  authController.showResend.value
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'I didn\'t receive a code',
                              style: TextStyle(
                                  fontSize: 11.sp, fontFamily: 'Poppins'),
                            ),
                            TextButton(
                                onPressed: null,
                                child: Text(
                                  'Resend Code',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.sp,
                                    color: const Color(0xff007981),
                                  ),
                                ))
                          ],
                        )
                      : Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SlideCountdown(
                                  textStyle: TextStyle(color: Colors.black),
                                  decoration:
                                      BoxDecoration(color: Colors.white),
                                  duration: Duration(seconds: 40),
                                ),
                                Text(
                                  'secs left',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13.sp),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Center(
                                child: SizedBox(
                              height: 24.w,
                              width: 24.w,
                              child: const CircularProgressIndicator(
                                color: Color(0xff007981),
                              ),
                            ))
                          ],
                        ),
                ],
              ),
            );
          }),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 64.0,
                        child: CupertinoButton(
                          borderRadius: BorderRadius.circular(10.r),
                          color: const Color(0xff007981),
                          child: const Text(
                            'Verify Now',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600),
                          ),
                          onPressed: () async {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus &&
                                currentFocus.focusedChild != null) {
                              currentFocus.focusedChild!.unfocus();
                            }
                            print(authController.field3.text);
                            HapticFeedback.lightImpact();
                            CustomOverlay.showLoaderOverlay(duration: 5);
                            final smsCode = authController.field1.text.trim() +
                                authController.field2.text.trim() +
                                authController.field3.text.trim() +
                                authController.field4.text.trim() +
                                authController.field5.text.trim() +
                                authController.field6.text.trim();

                            final credential = PhoneAuthProvider.credential(
                              verificationId: widget.verificationId!,
                              smsCode: smsCode,
                            );

                            if (smsCode.length == 6) {
                              try {
                                // Sign the user in (or link) with the credential
                                await _auth
                                    .signInWithCredential(credential)
                                    .then((val) {
                                  HapticFeedback.lightImpact();
                                  GetStorage().write('phone', widget.tempPhone);
                                  GetStorage().write('isLoggedIn', true);

                                  CustomOverlay.showToast(
                                      'You have successfully been logged in',
                                      Colors.green,
                                      Colors.white);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Dashboard()));
                                });
                              } on FirebaseAuthException catch (e) {
                                CustomOverlay.showToast(
                                    'Something went wrong, please try again later',
                                    Colors.red,
                                    Colors.white);
                              }
                            } else {
                              CustomOverlay.showToast(
                                  'Enter complete OTP code to continue',
                                  Colors.red,
                                  Colors.white);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
