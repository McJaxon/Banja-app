import 'dart:async';

import 'package:banja/constants/styles.dart';
import 'package:banja/controllers/auth_controller.dart';
import 'package:banja/controllers/user_detail_controller.dart';
import 'package:banja/models/loan_application_details_model.dart';
import 'package:banja/screens/auth/phone_otp.dart';
import 'package:banja/services/server.dart';
import 'package:banja/utils/form_validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import '../../utils/customOverlay.dart';
import '../../shared/shared.dart';

enum LoginTypes { newUser, emailPassword, phoneOnly }

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var loginType = LoginTypes.newUser;
  var phoneType = LoginTypes.phoneOnly;
  var emailType = LoginTypes.emailPassword;
  var authController = Get.put(AuthController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  PageController sigInInController = PageController();

  bool validateAndSave() {
    final FormState? form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  void initState() {
    Timer.run(() {
      // ignore: void_checks
      return authController.showPolicyDialog(context);
    });
    authController.nationalIDFocus.addListener(() {
      if (authController.nationalIDFocus.hasFocus) {
        authController.trigger(true);
      } else {
        authController.trigger(false);
      }
    });

    authController.referralIDFocus.addListener(() {
      if (authController.referralIDFocus.hasFocus) {
        authController.trigger(true);
      } else {
        authController.trigger(false);
      }
    });

    authController.phoneNumberFocus.addListener(() {
      if (authController.phoneNumberFocus.hasFocus) {
        authController.trigger(true);
      } else {
        authController.trigger(false);
      }
    });

    authController.emailFocus.addListener(() {
      if (authController.emailFocus.hasFocus) {
        authController.trigger(true);
      } else {
        authController.trigger(false);
      }
    });

    authController.passwordFocus.addListener(() {
      if (authController.passwordFocus.hasFocus) {
        authController.trigger(true);
      } else {
        authController.trigger(false);
      }
    });

    super.initState();
  }

  @override
  dispose() {
    super.dispose();
    authController.emailAddress.clear();
    authController.password.clear();
    authController.phoneNumber.clear();
    authController.referralID.clear();
    authController.nationalID.clear();
  }

  buildForm() {
    if (LoginTypes.newUser == loginType) {
      return [
        SizedBox(
          height: 30.h,
        ),
        TextBox(
          textType: TextInputType.text,
          textCapitalization: TextCapitalization.characters,
          // dataVerify: FieldValidator.validateNIN,
          prefixIcon: const Icon(CupertinoIcons.creditcard),
          maxLength: 14,
          focusNode: authController.nationalIDFocus,
          textController: authController.nationalID,
          title: 'Enter NIN Number',
          hintText: 'eg CM546FDF54534FHS',
        ),
        SizedBox(
          height: 22.h,
        ),
        TextBox(
          prefixIcon: const Icon(CupertinoIcons.number),
          textType: TextInputType.text,
          maxLength: 6,
          focusNode: authController.referralIDFocus,
          textController: authController.referralID,
          title: 'Referral ID',
          hintText: 'enter referral ID',
        ),
        SizedBox(
          height: 22.h,
        ),
        TextBox(
          prefixIcon: const Icon(CupertinoIcons.phone),
          textType: TextInputType.phone,
          maxLength: 9,
          dataVerify: FieldValidator.validatePhone,
          focusNode: authController.phoneNumberFocus,
          textController: authController.phoneNumber,
          title: 'Phone Number',
          hintText: 'enter phone',
        ),
        SizedBox(
          height: 300.h,
        ),
      ];
    } else {
      return [
        SizedBox(
          height: 10.h,
        ),
        Text(
          'Log in to continue',
          style: TextStyle(fontSize: 18.sp, fontFamily: 'Poppins '),
        ),
        SizedBox(
          height: 30.h,
        ),
        LoginTypes.phoneOnly != phoneType
            ? Column(children: [
                TextBox(
                  prefixIcon: const Icon(CupertinoIcons.mail),
                  textType: TextInputType.text,
                  // dataVerify: FieldValidator.validateEmail,
                  focusNode: authController.emailFocus,
                  textController: authController.emailAddress,
                  title: 'Email Address',
                  hintText: 'type in your email address',
                ),
                SizedBox(
                  height: 22.h,
                ),
                TextBox(
                  prefixIcon: const Icon(CupertinoIcons.shield),
                  obscureText: true,
                  textType: TextInputType.text,
                  // dataVerify: FieldValidator.validatePassword,

                  isPassword: true,
                  focusNode: authController.passwordFocus,
                  textController: authController.password,
                  title: 'Password',
                  hintText: 'type password here',
                ),
              ])
            : TextBox(
                prefixIcon: const Icon(CupertinoIcons.phone),
                textType: TextInputType.phone,
                maxLength: 9,
                dataVerify: FieldValidator.validatePhone,
                focusNode: authController.phoneNumberFocus,
                textController: authController.phoneNumber,
                title: 'Phone Number',
                hintText: 'enter phone',
              ),
        SizedBox(height: 45.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Divider(
                endIndent: 10.w,
                indent: 70.w,
                color: Colors.black,
              ),
            ),
            Text(
              'OR',
              style: TextStyle(fontFamily: 'Poppins', fontSize: 17.sp),
            ),
            Expanded(
              child: Divider(
                endIndent: 70.w,
                indent: 10.w,
                color: Colors.black,
              ),
            ),
          ],
        ),
        TextButton(
          child: Text(
            LoginTypes.phoneOnly == phoneType
                ? 'Use Email & Password'
                : 'Use Phone',
            style: textButtonStyle,
          ),
          onPressed: () {
            setState(() {
              if (LoginTypes.phoneOnly == phoneType) {
                phoneType = LoginTypes.emailPassword;
              } else {
                phoneType = LoginTypes.phoneOnly;
              }
            });
          },
        ),
        SizedBox(
          height: 300.h,
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() {
          return PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: authController.pageController,
            children: [
              Stack(
                children: <Widget>[
                  AuthPageHeader(
                    heading: LoginTypes.newUser == loginType
                        ? 'REGISTER'
                        : 'WELCOME BACK,\nSIGN IN',
                    trigger: authController.trigger.value,
                  ),
                  Positioned(
                      top: 60.h,
                      right: 5.w,
                      child: IconButton(
                          onPressed: () {
                            authController.showAboutDialog(context);
                          },
                          iconSize: 40.w,
                          icon: const Icon(
                            CupertinoIcons.question_circle_fill,
                            color: Color.fromARGB(173, 44, 205, 217),
                          ))),
                  Padding(
                    padding: EdgeInsets.only(
                        top: authController.trigger.value ? 200.h : 400.h),
                    child: Form(
                      key: formKey,
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 27.w),
                        shrinkWrap: true,
                        children: buildForm(),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.h),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 64.h,
                                    child: CupertinoButton(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: const Color(0xff007981),
                                      child: Text(
                                        LoginTypes.newUser == loginType
                                            ? 'Register'
                                            : 'Sign In',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 23.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      onPressed: () async {
                                        HapticFeedback.lightImpact();
                                        FocusScopeNode currentFocus =
                                            FocusScope.of(context);
                                        if (!currentFocus.hasPrimaryFocus &&
                                            currentFocus.focusedChild != null) {
                                          currentFocus.focusedChild!.unfocus();
                                        }

                                        if (LoginTypes.newUser == loginType) {
                                          if (
                                            authController.referralID.text.isNotEmpty &&
                                            authController
                                                      .nationalID.text.length ==
                                                  14 &&
                                              authController.phoneNumber.text
                                                      .length ==
                                                  9) {
                                            if (validateAndSave()) {
                                              ////
                                              Server.verifyTag(
                                                      context,
                                                      authController
                                                          .referralID.text
                                                          .trim())
                                                  .then(
                                                (value) {
                                                  if (value) {
                                                    GetStorage().write(
                                                        'nin',
                                                        authController
                                                            .nationalID
                                                            .value
                                                            .text);
                                                    authController
                                                        .phoneAuth(context);
                                                  } else {
                                                    CustomOverlay.showToast(
                                                        'The referral ID provided does not exit',
                                                        Colors.orange[900]!   ,
                                                        Colors.white);
                                                  }
                                                },
                                              );
                                            }
                                          } else {
                                            CustomOverlay.showToast(
                                              'Fill all fields to continue',
                                              Colors.red,
                                              Colors.white,
                                            );
                                          }
                                        } else if (phoneType ==
                                            LoginTypes.emailPassword) {
                                          if (authController.emailAddress.text
                                                  .isNotEmpty &&
                                              authController
                                                  .password.text.isNotEmpty) {
                                            if (validateAndSave()) {
                                              var userDetails = EndUserModel(
                                                  emailAddress: authController
                                                      .emailAddress.value.text,
                                                  password: authController
                                                      .password.value.text);

                                              await Server.userLogIn(
                                                  context, userDetails);
                                            }
                                          } else {
                                            CustomOverlay.showToast(
                                                'Fill out email and password to continue',
                                                Colors.red,
                                                Colors.white);
                                          }
                                        } else {
                                          if (authController
                                                  .phoneNumber.text.length ==
                                              9) {
                                            if (validateAndSave()) {
                                              authController.phoneAuth(context,
                                                  existing: true);
                                              await Future.delayed(
                                                  const Duration(seconds: 6));
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PhoneOTP(
                                                            existing: true,
                                                            verificationId:
                                                                authController
                                                                    .verificationId
                                                                    .value,
                                                            tempPhone:
                                                                authController
                                                                    .phoneNumber
                                                                    .text,
                                                          )));
                                            } else {
                                              CustomOverlay.showToast(
                                                  'Type in Correct phone',
                                                  Colors.red,
                                                  Colors.white);
                                            }
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    if (LoginTypes.newUser == loginType) {
                                      loginType = LoginTypes.emailPassword;
                                    } else {
                                      loginType = LoginTypes.newUser;
                                    }
                                  });
                                },
                                child: Text(
                                  LoginTypes.newUser == loginType
                                      ? 'Already have an account?, sign in'
                                      : 'Don\'t have an account, sign up',
                                  style: textButtonStyle,
                                )),

                          ],
                        )),
                  )
                ],
              ),
              PhoneOTP(
                verificationId: authController.verificationId.value,
                tempPhone: authController.phoneNumber.text,
              )
            ],
          );
        }),
      ),
    );
  }
}
