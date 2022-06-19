import 'package:banja/constants/strings.dart';
import 'package:banja/models/loan_application_details_model.dart';
import 'package:banja/services/local_db.dart';
import 'package:banja/services/server.dart';
import 'package:banja/shared/options_picker.dart';
import 'package:banja/utils/customOverlay.dart';
import 'package:banja/utils/file_picker.dart';
import 'package:banja/utils/form_validators.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import '../shared/shared.dart';

class UserDetailsController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();
  final TextEditingController _fullNames = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _emailAddress = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordConfirm = TextEditingController();

  final TextEditingController _dateOfBirth = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _profession = TextEditingController();
  final TextEditingController _monthlyIncome = TextEditingController();
  final TextEditingController _loanPurpose = TextEditingController();
  final TextEditingController _haveOtherLoans = TextEditingController();
  final TextEditingController _nextOfKin = TextEditingController();

  var userDetails = [].obs;
  var pageCount = 1.obs;
  var contactName = ''.obs;
  var contactPhone = ''.obs;

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
                  Positioned(
                    top: 65.h,
                    right: 20.w,
                    child: Obx(() {
                      return Text(
                        'Page $pageCount/3',
                        style:
                            TextStyle(fontFamily: 'Poppins', fontSize: 22.sp),
                      );
                    }),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 115.h,
                    ),
                    child: Text(
                      'This information helps to finish creating your profile, and then you can continue to use the services of the application  ',
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 17.sp),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 195.h),
                    child: Form(
                      key: formKey,
                      child: Stack(
                        children: [
                          PageView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: _pageController,
                            scrollDirection: Axis.vertical,
                            onPageChanged: (value) {
                              pageCount.value =
                                  _pageController.page!.toInt() + 2;
                            },
                            children: [
                              Stack(
                                children: <Widget>[
                                  BioDataForm(
                                    fullNames: _fullNames,
                                    emailAddress: _emailAddress,
                                    location: _location,
                                    dateOfBirth: _dateOfBirth,
                                    gender: _gender,
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
                                        } else if (_location
                                                .value.text.isEmpty ||
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
                                        height: 65.h,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            color: const Color(0xff007981)),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Next',
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
                                  EmploymentDataForm(
                                    haveOtherLoans: _haveOtherLoans,
                                    loanPurpose: _loanPurpose,
                                    monthlyIncome: _monthlyIncome,
                                    nextOfKin: _nextOfKin,
                                    profession: _profession,
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
                                        } else if (_location
                                                .value.text.isEmpty ||
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
                                          //if (validateAndSave()) {
                                            HapticFeedback.lightImpact();
                                            CustomOverlay.showLoaderOverlay(
                                                duration: 1);

                                            _pageController.animateToPage(2,
                                                curve: Curves.decelerate,
                                                duration: const Duration(
                                                    milliseconds: 300));
                                         // }
                                        }
                                      },
                                      child: Container(
                                        height: 65.h,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            color: const Color(0xff007981)),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Next',
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
                                    child: ListView(
                                      physics: const BouncingScrollPhysics(),
                                      children: [
                                        TextBox(
                                          title: 'Type password',
                                          obscureText: true,
                                          textController: _password,
                                          dataVerify:
                                              FieldValidator.validatePassword,
                                          hintText:
                                              'should be at least 6 characters long',
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        TextBox(
                                          title: 'Retype password',
                                          obscureText: true,
                                          textController: _passwordConfirm,
                                          dataVerify:
                                              FieldValidator.validatePassword,
                                          hintText:
                                              'should match previous password above',
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.bottomCenter,
                                      child: GestureDetector(
                                        onTap: () async {
                                          if (!(_password.value.text.length >=
                                              6)) {
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
                                                    password:
                                                        _password.value.text,
                                                    passwordConfirm:
                                                        _passwordConfirm
                                                            .value.text,
                                                    phoneNumber: '0' +
                                                        GetStorage()
                                                            .read('phone'),
                                                    profilePic: value,
                                                    nin: GetStorage()
                                                        .read('nin'),
                                                    referralID: '',
                                                    fullNames:
                                                        _fullNames.value.text,
                                                    emailAddress: _emailAddress
                                                        .value.text,
                                                    location:
                                                        _location.value.text);

                                                await Server.createUser(
                                                    userDetails);
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
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: 70.h,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r),
                                                    color: const Color(
                                                        0xff007981)),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Sign up',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            color: Colors.white,
                                                            fontSize: 26.sp),
                                                      ),
                                                      //    Spacer(),
                                                    ]),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class BioDataForm extends StatelessWidget {
  BioDataForm({
    Key? key,
    required TextEditingController fullNames,
    required TextEditingController emailAddress,
    required TextEditingController location,
    required TextEditingController dateOfBirth,
    required TextEditingController gender,
  })  : _dateOfBirth = dateOfBirth,
        _gender = gender,
        _fullNames = fullNames,
        _emailAddress = emailAddress,
        _location = location,
        super(key: key);
  final TextEditingController _dateOfBirth;
  final TextEditingController _gender;
  final TextEditingController _fullNames;
  final TextEditingController _emailAddress;
  final TextEditingController _location;

  List<DropdownMenuItem<int>> dropdown = const [
    DropdownMenuItem(
        child: Text(
          '1 Month',
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 10.0,
              color: Color(0xff007981)),
        ),
        value: 1),
    DropdownMenuItem(
        child: Text(
          '3 Months',
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 10.0,
              color: Color(0xff007981)),
        ),
        value: 2),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 45.h),
      child: ListView(
        padding: EdgeInsets.only(top: 0.h),
        physics: const BouncingScrollPhysics(),
        children: [
          TextBox(
            title: 'What is your full name ?',
            textController: _fullNames,
            textType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            hintText: 'Write names here eg. Mukasa John',
          ),
          SizedBox(
            height: 20.h,
          ),
          TextBox(
            isDate: true,
            title: 'What is your date of birth ?',
            textController: _dateOfBirth,
            textType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            hintText: 'Pick your date of birth',
          ),
          SizedBox(
            height: 20.h,
          ),
          OptionsPicker(
            title: 'What is your gender ?',
            dropdown: gender
                .map((e) => DropdownMenuItem(
                    child: Text(
                      e['category'],
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 10.0,
                          color: Color(0xff007981)),
                    ),
                    value: e['id']))
                .toList(),
            onChanged: (value) {

            },
          ),
          // TextBox(
          //   title: 'What is your gender ?',
          //   textController: _gender,
          //   textType: TextInputType.text,
          //   textCapitalization: TextCapitalization.words,
          //   hintText: 'Pick your gender',
          // ),
          SizedBox(
            height: 20.h,
          ),
          TextBox(
            title: 'What is your email address ?',
            textController: _emailAddress,
            textType: TextInputType.emailAddress,
            dataVerify: FieldValidator.validateEmail,
            hintText: 'Write email address here eg user@test.com',
          ),
          SizedBox(
            height: 20.h,
          ),
          TextBox(
            title: 'What is your location ?',
            textController: _location,
            textType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            hintText: 'eg. Kampala',
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            'Attach Selfie',
            style: TextStyle(fontFamily: 'Poppins', fontSize: 16.8.sp),
          ),
          SizedBox(
            height: 6.h,
          ),
          StatefulBuilder(builder: (context, setter) {
            return Container(
              height: 60.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.white),
              child: Row(children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      FilePicker.getImage('tempProfilePic', setter);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 60.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xff007981)),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 14.w),
                          Text('Take a picture',
                              style: TextStyle(
                                  fontFamily: 'Poppins', fontSize: 18.sp)),
                          const Spacer(),
                          const Icon(
                            Icons.camera,
                            color: Color(0xff007981),
                          ),
                          SizedBox(width: 14.w),
                        ],
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
            style: TextStyle(fontFamily: 'Poppins', fontSize: 17.sp),
          ),
          SizedBox(
            height: 320.h,
          ),
        ],
      ),
    );
  }
}

class EmploymentDataForm extends StatelessWidget {
  EmploymentDataForm({
    Key? key,
    required TextEditingController profession,
    required TextEditingController monthlyIncome,
    required TextEditingController loanPurpose,
    required TextEditingController haveOtherLoans,
    required TextEditingController nextOfKin,
  })  : _profession = profession,
        _monthlyIncome = monthlyIncome,
        _loanPurpose = loanPurpose,
        _haveOtherLoans = haveOtherLoans,
        _nextOfKin = nextOfKin,
        super(key: key);

  //final TextEditingController _dateOfBirth;
  final TextEditingController _profession;
  final TextEditingController _monthlyIncome;
  final TextEditingController _loanPurpose;
  final TextEditingController _haveOtherLoans;
  final TextEditingController _nextOfKin;

  final userDetailsController = Get.put(UserDetailsController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 45.h),
      child: ListView(
        padding: EdgeInsets.only(top: 0.h),
        physics: const BouncingScrollPhysics(),
        children: [
          OptionsPicker(
            title: 'What is your profession ?',
            dropdown: workProfessions
                .map((e) => DropdownMenuItem(
                    child: Text(
                      e['category'],
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 10.0,
                          color: Color(0xff007981)),
                    ),
                    value: e['id']))
                .toList(),
            onChanged: (value) {
              // setState(() {
              //   loanController.tenurePeriod = value!;
              //   if (loanController.tenurePeriod == 1) {
              //     loanController.interestRate = 2.75;
              //   } else if (loanController.tenurePeriod == 2) {
              //     loanController.interestRate = 11;
              //   }
              // });
            },
          ),
          SizedBox(
            height: 20.h,
          ),
          OptionsPicker(
            title: 'What is your monthly salary scale ?',
            dropdown: salaryScale
                .map((e) => DropdownMenuItem(
                    child: Text(
                      e['category'],
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 10.0,
                          color: Color(0xff007981)),
                    ),
                    value: e['id']))
                .toList(),
            onChanged: (value) {},
          ),
          SizedBox(
            height: 20.h,
          ),
          TextBox(
            title: 'What is the purpose of this loan ?',
            textController: _loanPurpose,
            textType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            hintText: 'Pick your gender',
          ),
          SizedBox(
            height: 20.h,
          ),
          OptionsPicker(
            title: 'Do you have any other loan ?',
            dropdown: haveLoans
                .map((e) => DropdownMenuItem(
                    child: Text(
                      e['category'],
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 10.0,
                          color: Color(0xff007981)),
                    ),
                    value: e['id']))
                .toList(),
            onChanged: (value) {},
          ),
          SizedBox(
            height: 20.h,
          ),
          GestureDetector(
              onTap: () {
                _getContactPermission();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Who is your next of kin ?',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 16.8.sp),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Obx(() {
                    return Container(
                      width: double.infinity,
                      height: 60.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12.withOpacity(0.07),
                                offset: const Offset(0, 1),
                                blurRadius: 20.0,
                                spreadRadius: 1)
                          ],
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.w),
                        child: Row(children: [
                          Text(userDetailsController.contactName.value),
                          const Spacer(),
                          Text(userDetailsController.contactPhone.value)
                        ]),
                      ),
                    );
                  }),
                ],
              )),
          SizedBox(
            height: 320.h,
          ),
        ],
      ),
    );
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();

      if (permissionStatus.isGranted) {
        ContactsService.openDeviceContactPicker().then((foundContacts) {
          userDetailsController.contactName.value =
              foundContacts!.displayName ?? '';
          userDetailsController.contactPhone.value =
              foundContacts.phones!.first.value ?? '';
          //debugPrint("done loading contacts${foundContacts.length}");
          //final list = foundContacts.toList();
          //list.sort((a, b) => a.givenName!.compareTo(b.givenName!));
          // setState(() {
          //   contacts = list;
          // });
          //print(contacts.first.givenName);
        }).catchError((error) {
          debugPrint(error.toString());
        });
      }

      return permissionStatus;
    } else {
      if (permission.isGranted) {
        ContactsService.openDeviceContactPicker().then((foundContacts) {
          userDetailsController.contactName.value =
              foundContacts!.displayName ?? '';
          userDetailsController.contactPhone.value =
              foundContacts.phones!.first.value ?? '';
          //debugPrint("done loading contacts${foundContacts.length}");
          //final list = foundContacts.toList();
          //list.sort((a, b) => a.givenName!.compareTo(b.givenName!));
          // setState(() {
          //   contacts = list;
          // });
          //print(contacts.first.givenName);
        }).catchError((error) {
          debugPrint(error.toString());
        });
      }
      return permission;
    }
  }
}
