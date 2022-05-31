import 'package:banja/models/loan_application_details_model.dart';
import 'package:banja/services/local_db.dart';
import 'package:banja/services/server.dart';
import 'package:banja/utils/customOverlay.dart';
import 'package:banja/utils/file_picker.dart';
import 'package:banja/utils/form_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserDetailsController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _fullNames = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _emailAddress = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordConfirm = TextEditingController();
  final PageController _pageController = PageController();
  var userDetails = [].obs;

  @override
  void onReady() async {
    super.onReady();
    getDetails();
  }

  getDetails() {
    LocalDB.getUserDetails().then((data) {
      if (data.isNotEmpty) {
        userDetails.addAll(data);
      }
    });
  }

  bool validateAndSave() {
    final FormState? form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  showRegPop(BuildContext context, AnimationController controller) {
    HapticFeedback.lightImpact();
    return showModalBottomSheet(
        enableDrag: false,
        transitionAnimationController: controller,
        isScrollControlled: true,
        backgroundColor: const Color(0xffE5F2F2),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
        isDismissible: false,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.w, 15.h),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Stack(
                children: [
                  Row(
                    children: <Widget>[
                      Text(
                        'Finish Creating your\nProfile,',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w700),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                    10.r,
                                  )),
                                  child: SizedBox(
                                    width: 340.w,
                                    height: 220.h,
                                    child: Padding(
                                      padding: EdgeInsets.all(15.w),
                                      child: Column(
                                        children: [
                                          const Text('Do you wish to close?',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600)),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Text(
                                            'You are closing without editing/saving changes. You may have limited access until you finish setting up your profile',
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 13.5.sp),
                                            textAlign: TextAlign.center,
                                          ),
                                          const Spacer(),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    height: 55.h,
                                                    child: const Center(
                                                        child: Text(
                                                      'NO',
                                                      style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Colors.red.shade400,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          10.r,
                                                        )),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15.w,
                                              ),
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    height: 55.h,
                                                    child: const Center(
                                                        child: Text('YES',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600))),
                                                    decoration: BoxDecoration(
                                                        color: Colors
                                                            .green.shade400,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          10.r,
                                                        )),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 85.h),
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _pageController,
                      scrollDirection: Axis.vertical,
                      children: [
                        Stack(
                          children: <Widget>[
                            Text(
                              'This information helps to finish creating your profile, and then you can continue to use the services of the application  ',
                              style: TextStyle(
                                  fontFamily: 'Poppins', fontSize: 17.sp),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 105.h),
                              child: Form(
                                key: formKey,
                                child: ListView(
                                  physics: const BouncingScrollPhysics(),
                                  children: [
                                    Text(
                                      'What is your full name',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16.8.sp),
                                    ),
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    Container(
                                      height: 60.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          color: Colors.white),
                                      child: TextFormField(
                                        controller: _fullNames,
                                        keyboardType: TextInputType.text,
                                        textCapitalization:
                                            TextCapitalization.words,
                                        decoration: InputDecoration(
                                            hintText:
                                                'Write names here eg. Mukasa John',
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 20.w),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Text(
                                      'What is your email address',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16.8.sp),
                                    ),
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    Container(
                                      height: 60.0,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Colors.white),
                                      child: TextFormField(
                                        controller: _emailAddress,
                                        validator: FieldValidator.validateEmail,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                            hintText:
                                                'Write email address here eg user@test.com',
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 20.w),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Text(
                                      'What is your location',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16.8.sp),
                                    ),
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    Container(
                                      height: 60.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          color: Colors.white),
                                      child: TextFormField(
                                        controller: _location,
                                        textCapitalization:
                                            TextCapitalization.words,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            hintText: 'eg. Kampala',
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 20.w),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Text(
                                      'Attach Selfie',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16.8.sp),
                                    ),
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    StatefulBuilder(builder: (context, setter) {
                                      return Container(
                                        height: 60.h,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            color: Colors.white),
                                        child: Row(children: [
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                FilePicker.getImage(
                                                    'tempProfilePic', setter);
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                height: 60.h,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r),
                                                    color: const Color(
                                                        0xff007981)),
                                                child: const Icon(
                                                  Icons.camera,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          )
                                        ]),
                                      );
                                    }),
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    Text(
                                      'Please take a clear close-up picture of your face, make sure the lighting and background are good',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 17.sp),
                                    ),
                                    SizedBox(
                                      height: 320.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: GestureDetector(
                                onTap: () async {
                                  if (_fullNames.value.text.isNotEmpty &&
                                      _fullNames.value.text
                                              .trim()
                                              .split(' ')
                                              .length <
                                          2) {
                                    CustomOverlay.showToast(
                                        'Enter your full name please',
                                        Colors.red,
                                        Colors.white);
                                  } else if (_location.value.text.isEmpty ||
                                      _emailAddress.value.text.isEmpty) {
                                    CustomOverlay.showToast(
                                        'Fill all fields to continue saving',
                                        Colors.red,
                                        Colors.white);
                                  } else if (GetStorage()
                                          .read('tempProfilePic') ==
                                      null) {
                                    CustomOverlay.showToast(
                                        'Please tap the snap selfie button to take a pic',
                                        Colors.red,
                                        Colors.white);
                                  } else {
                                    if (validateAndSave()) {
                                      HapticFeedback.lightImpact();
                                      CustomOverlay.showLoaderOverlay(
                                          duration: 1);

                                      _pageController.animateToPage(1,
                                          curve: Curves.decelerate,
                                          duration: const Duration(
                                              milliseconds: 300));
                                    }
                                  }
                                },
                                child: Container(
                                  height: 60.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: const Color(0xff007981)),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Confirm',
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w800,
                                              color: Colors.white,
                                              fontSize: 26.sp),
                                        ),
                                        //    Spacer(),
                                      ]),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: <Widget>[
                            Text(
                              'Create a password to use for logging in',
                              style: TextStyle(
                                  fontFamily: 'Poppins', fontSize: 17.sp),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 105.h),
                              child: Form(
                                key: formKey,
                                child: ListView(
                                  physics: const BouncingScrollPhysics(),
                                  children: [
                                    Text(
                                      'Type Password',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16.8.sp),
                                    ),
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    Container(
                                      height: 60.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          color: Colors.white),
                                      child: TextFormField(
                                        obscureText: true,
                                        validator:
                                            FieldValidator.validatePassword,
                                        controller: _password,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            hintText:
                                                'should be at least 6 characters long',
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 20.w),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Text(
                                      'Retype password',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16.8.sp),
                                    ),
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    Container(
                                      height: 60.0,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Colors.white),
                                      child: TextFormField(
                                        obscureText: true,
                                        validator:
                                            FieldValidator.validatePassword,
                                        controller: _passwordConfirm,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            hintText:
                                                'should match previous password above ',
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 20.w),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: GestureDetector(
                                  onTap: () async {
                                    if (!(_password.value.text.length >= 6)) {
                                      CustomOverlay.showToast(
                                          'Password should be at least 6 characters long',
                                          Colors.red,
                                          Colors.white);
                                    } else if (_password.value.text !=
                                        _passwordConfirm.value.text) {
                                      CustomOverlay.showToast(
                                          'Sorry, your passwords do not match.',
                                          Colors.red,
                                          Colors.white);
                                    } else {
                                      if (validateAndSave()) {
                                        HapticFeedback.lightImpact();
                                        CustomOverlay.showLoaderOverlay(
                                            duration: 2);

                                        GetImagePath.uploadFile(
                                          FilePicker.imageFile,
                                        ).then((value) async {
                                          var userDetails = EndUserModel(
                                              password: _password.value.text,
                                              passwordConfirm:
                                                  _passwordConfirm.value.text,
                                              phoneNumber: '0' +
                                                  GetStorage().read('phone'),
                                              profilePic: value,
                                              nin: GetStorage().read('nin'),
                                              referralID: '',
                                              fullNames: _fullNames.value.text,
                                              emailAddress:
                                                  _emailAddress.value.text,
                                              location: _location.value.text);

                                          await Server.createUser(userDetails);
                                        }).onError((error, stackTrace) {
                                          CustomOverlay.showToast(
                                              'Failed to attach photo, try again later',
                                              Colors.red,
                                              Colors.white);
                                          Get.back();
                                        });
                                      }
                                    }
                                  },
                                  child: Container(
                                    height: 60.h,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        color: const Color(0xff007981)),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Sign up',
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w800,
                                                color: Colors.white,
                                                fontSize: 26.sp),
                                          ),
                                          //    Spacer(),
                                        ]),
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
