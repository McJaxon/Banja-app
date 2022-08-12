//  ZOFI CASH APP
//
//  Created by Ronnie Zad Muhanguzi .
//  2022, Zofi Cash App. All rights reserved.
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import 'package:banja/screens/auth/lock_screen.dart';
import 'package:banja/shared/text_box.dart';
import 'package:banja/utils/customOverlay.dart';
import 'package:banja/utils/form_validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// #####  Home Page Controller
/// Here we are creating our [HomePageController] class
class LockScreenController extends GetxController {
  /// #####  Amount Controller
  /// Here we are initializing the [amountController] and marking it as an observable variable using
  /// `obs` from the `package:get`
  final pinController1 = TextEditingController();
  final pinController2 = TextEditingController();
  final TextEditingController ninController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  var pin = TextEditingController();

  /// #####  insertText method
  /// This method is used to input text from a user via the keypad.
  /// Here we first check  if the `amountController` current selection is mot empty  we then set the
  /// new cursor position to the current controller position and move it by the length of the
  /// `inserted text` . We then replace the substring with the `insertedText` and set it to text value
  /// of the controller.
  /// Also the maximum text length is set to 9.
  void insertText(String textToInsert, TextEditingController pinController) {
    if (pinController.value.selection.start >= 0) {
      int newPosition =
          pinController.value.selection.start + textToInsert.length;
      pinController.text = pinController.value.text.replaceRange(
        pinController.value.selection.start,
        pinController.value.selection.end,
        textToInsert,
      );
      pinController.selection = TextSelection(
        baseOffset: newPosition,
        extentOffset: newPosition,
      );
    } else if (pinController.value.text.length < 4) {
      pinController.text += textToInsert;
    }
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool validateAndSave() {
    final FormState? form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  late OverlayEntry entry;
  OverlayEntry _getEntry(context) {
    entry = OverlayEntry(
      opaque: true,
      maintainState: true,
      builder: (_) => Material(
          child: LockScreen(
              pinController: pin, title: 'Enter your Tuula PIN', entry: entry)),
    );
    return entry;
  }

  Future<void> showLockScreenHelp(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0)),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'LockScreen Help',
                    style: TextStyle(
                        fontSize: 25.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500),
                  ),
                  const Divider(
                    endIndent: 120,
                    color: Color(0xff06919A),
                    thickness: 8.0,
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Text(
                    'loanType',
                    style: TextStyle(
                        fontSize: 25.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'loanDescription',
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w200),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          );
        });
  }

  showResetPINPage(BuildContext context) {
    return showModalBottomSheet(
        useRootNavigator: true,
        isScrollControlled: true,
        enableDrag: false,
        isDismissible: false,
        context: context,
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 60, left: 5.0),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Overlay.of(context)!.insert(_getEntry(context));
                          phoneController.clear();
                          ninController.clear();
                        },
                        icon: const Icon(CupertinoIcons.multiply)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 108.0, left: 20.0, right: 20.0),
                    child: Text(
                      'Reset your Tuula\nPIN',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 48.sp,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 228.0, left: 20.0, right: 20.0),
                    child: Text(
                      'We need to ask you a couple of questions to make sure you\'re the owner of the account',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 350.0, left: 20.0, right: 20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextBox(
                              maxLength: 14,
                              textType: TextInputType.text,
                              textCapitalization: TextCapitalization.characters,
                              // dataVerify: FieldValidator.validateNIN,
                              title: 'What is your National ID number?',
                              hintText: '',
                              textController: ninController),
                          const SizedBox(
                            height: 10.0,
                          ),
                          TextBox(
                              // dataVerify: FieldValidator.validatePhone,
                              title: 'What is your phone number?',
                              maxLength: 9,
                              hintText: '',
                              textController: phoneController)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                              'Next',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600),
                            ),
                            onPressed: () {
                              HapticFeedback.lightImpact();

                              if (validateAndSave()) {
                                if (ninController.value.text.isNotEmpty &&
                                    phoneController.value.text.isNotEmpty) {
                                  if ((ninController.value.text ==
                                          GetStorage().read('nin')) &&
                                      ('0${phoneController.value.text}' ==
                                          GetStorage().read('phoneNumber'))) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SetNewPin()));
                                  } else {
                                    CustomOverlay.showToast(
                                        'No match found!',
                                        Colors.red,
                                        Colors.white);
                                  }
                                }
                                else{
                                       CustomOverlay.showToast(
                                      'Fill all fields to continue!',
                                      Colors.red,
                                      Colors.white);
                                }
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50.sp,
              )
            ],
          );
        });
  }
}
