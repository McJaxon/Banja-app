import 'package:banja/constants/strings.dart';
import 'package:banja/constants/styles.dart';
import 'package:banja/screens/dashboard.dart';
import 'package:banja/services/server.dart';
import 'package:banja/utils/customOverlay.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  TextEditingController nationalID = TextEditingController();
  TextEditingController referralID = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController emailAddress = TextEditingController();

  TextEditingController field1 = TextEditingController();
  TextEditingController field2 = TextEditingController();
  TextEditingController field3 = TextEditingController();
  TextEditingController field4 = TextEditingController();
  TextEditingController field5 = TextEditingController();
  TextEditingController field6 = TextEditingController();

  FocusNode otp1 = FocusNode();
  FocusNode otp2 = FocusNode();
  FocusNode otp3 = FocusNode();
  FocusNode otp4 = FocusNode();
  FocusNode otp5 = FocusNode();
  FocusNode otp6 = FocusNode();

  FocusNode nationalIDFocus = FocusNode();
  FocusNode referralIDFocus = FocusNode();
  FocusNode phoneNumberFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  var loanDetails = [].obs;

  var trigger = false.obs;
  var showResend = false.obs;
  bool isLoading = false;
  var error = ''.obs;
  var verificationId = ''.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  PageController pageController = PageController();

  Future phoneAuth(BuildContext context, {bool existing = false}) async {
    HapticFeedback.lightImpact();
    try {
      CustomOverlay.showLoaderOverlay(duration: 4);
      await Future.delayed(const Duration(seconds: 5));
      CustomOverlay.showToast(
          'Sending OTP to your phone', Colors.blue, Colors.white);
      await _auth.verifyPhoneNumber(
        phoneNumber: '+256' + phoneNumber.text,
        verificationCompleted: (_) async {
          if (existing) {
            await Server.phoneSignIn(context, phoneNumber.text);
          } else {
            GetStorage().write('phone', phoneNumber.text);
            HapticFeedback.lightImpact();
            GetStorage().write('isLoggedIn', true);
            HapticFeedback.lightImpact();
            CustomOverlay.showLoaderOverlay(duration: 4);
            CustomOverlay.showToast('You have successfully been logged in',
                Colors.green, Colors.white);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Dashboard()));
          }
        },
        verificationFailed: (e) {
          HapticFeedback.lightImpact();
          if (e.code == 'network-request-failed') {
            CustomOverlay.showToast(
                'You are not connected to internet', Colors.red, Colors.white);
          } else if (e.code == 'web-context-cancelled') {
            CustomOverlay.showToast(
                'User cancelled action', Colors.red, Colors.white);
          }

          error.value = '${e.message}';
          print(e.code);
        },
        codeSent: (String verificationID, int? resendToken) async {
          HapticFeedback.lightImpact();
          if (existing) {
          } else {
            pageController.animateToPage(1,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInExpo);
          }

          verificationId.value = verificationID;
        },
        codeAutoRetrievalTimeout: (e) {
          error.value = e;
        },
      );
    } catch (e) {
      error.value = '$e';
    } finally {
      isLoading = !isLoading;
    }
  }

  showAboutDialog(BuildContext context) {
    HapticFeedback.lightImpact();
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: const Color(0xffE5F2F2),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
        context: context,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.95,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.topCenter,
                          child: Image.asset(
                            'assets/images/tuula_logo.png',
                            width: 200.w,
                          )),
                      SizedBox(height: 10.h),
                      Text('Tuula Financial Services Limited',
                          style: companyDetailsTitleStyle)
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 140.h),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20.w),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text('What We Do?',
                              style: companyDetailsHeadingStyle),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.w),
                        child: Text(
                            'At Tuula clients come first. We help individuals, families, institutions, and SME\'s raise, manage, and distribute the capital they need to achieve their goals.\n\nWe help people, businesses and institutions build, preserve, and manage wealth so they can pursue their financial goals.\n\nAs a bridging financier, we target entrepreneurs, contractors, schools, importers, real estate developers, transporters, service providers, suppliers, and other viable clients.',
                            style: companyDetailsBodyStyle),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.w),
                        child: Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              'Our Vision',
                              style: companyDetailsHeadingStyle,
                            )),
                      ),
                      Text(
                          'To become the preferred credit partner for our clients across emerging markets. ',
                          style: companyDetailsBodyStyle),
                      Padding(
                        padding: EdgeInsets.all(20.w),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text('Our Mission',
                                style: companyDetailsHeadingStyle)),
                      ),
                      Text(
                          'By utilizing the power of technology to facilitate trade across the continent by providing simple, accessible, and friendly financial services.',
                          style: companyDetailsBodyStyle),
                      Padding(
                        padding: EdgeInsets.all(20.w),
                        child: Align(
                            alignment: Alignment.topRight,
                            child: Text('Why Choose Tuula?',
                                style: companyDetailsHeadingStyle)),
                      ),
                      Text(
                          'To realize their potential, Businesses need a financial partner that is committed to their growth. You should be able to access financial services when you need it and in minutes, not days.',
                          style: companyDetailsBodyStyle),
                      SizedBox(height: 10.h),
                      Text('Contact', style: companyDetailsHeavy),
                      Text('info@tuulacredit.com', style: companyDetailsLight),
                      Text('+256 782 920 587', style: companyDetailsLight),
                      Text('+256 757 642 885', style: companyDetailsLight),
                      Text('+256 701 530 658', style: companyDetailsLight),
                      SizedBox(height: 20.h),
                      Text('Address', style: companyDetailsHeavy),
                      Text('Tuula Financial Services Limited',
                          style: companyDetailsLight),
                      Text('Plot 1200 Old Port Bell Road, Kitintale',
                          style: companyDetailsLight),
                      Text('2nd Floor Hardware World Mall',
                          style: companyDetailsLight),
                      SizedBox(
                        height: 30.h,
                      ),
                      Row(children: [
                        Expanded(
                            child: SizedBox(
                                height: 64.h,
                                child: CupertinoButton(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color:
                                        const Color.fromARGB(255, 35, 101, 105),
                                    child: const Text(
                                      'Okay',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    })))
                      ]),
                      SizedBox(
                        height: 70.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  showPolicyDialog(BuildContext context) {
    HapticFeedback.lightImpact();
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: const Color(0xffE5F2F2),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
        context: context,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.95,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.topCenter,
                          child: Image.asset(
                            'assets/images/tuula_logo.png',
                            width: 200.w,
                          )),
                      SizedBox(height: 10.h),
                      Text('Tuula App Privacy Policy',
                          style: companyDetailsTitleStyle)
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 140.h),
                  child: Stack(
                    children: [
                      ListView(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Text(privacyPolicy,
                                style: companyDetailsBodyStyle),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 30.h,
                        right: 15.w,
                        left: 15.w,
                        child: Row(children: [
                          Expanded(
                              child: SizedBox(
                                  height: 64.h,
                                  child: CupertinoButton(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: const Color.fromARGB(
                                          255, 35, 101, 105),
                                      child: const Text(
                                        'Okay, I understand',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      })))
                        ]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
