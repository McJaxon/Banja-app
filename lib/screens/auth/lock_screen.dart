import 'dart:ui';
import 'package:banja/animation/animation.dart';
import 'package:banja/constants/styles.dart';
import 'package:banja/services/server.dart';
import 'package:banja/utils/customOverlay.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../controllers/lock_screen_controller.dart';
import '../../shared/keypad_button.dart';

class LockScreen extends StatefulWidget {
  const LockScreen({
    Key? key,
    this.entry,
    this.controller,
    this.isChangePIN = false,
    this.isSetUpPIN = false,
    this.isRestPIN = false,
    this.pinController2,
    required this.pinController,
    required this.title,
  }) : super(key: key);
  final OverlayEntry? entry;
  final String title;
  final PageController? controller;
  final bool isChangePIN, isSetUpPIN, isRestPIN;
  final TextEditingController pinController;
  final TextEditingController? pinController2;

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  var lockScreenController = Get.put(LockScreenController());

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Positioned(
        top: 50,
        right: 10,
        left: 10,
        child: DelayedFade(
          delay: 300,
          child: Row(
            children: <Widget>[
              widget.isChangePIN || widget.isSetUpPIN
                  ? IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(CupertinoIcons.multiply,
                          size: 26, color: Colors.black))
                  : Container(),
            ],
          ),
        ),
      ),
      Positioned(
        top: 140.0,
        right: 10.0,
        left: 10.0,
        child: Column(
          children: <Widget>[
            DelayedFade(
              delay: 450,
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
                style: homePageTextStyle,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            DelayedFade(
              delay: 550,
              child: TextFormField(
                readOnly: true,
                controller: widget.pinController2 ?? widget.pinController,
                maxLength: 4,
                obscureText: true,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                    border: InputBorder.none, counterText: ''),
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 54.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w900),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
      Positioned(
          left: 0.0,
          right: 0.0,
          bottom: -10.0,
          child: Animator(
              delay: 400,
              builder: (context, w, value) {
                return Transform.translate(
                  offset: Offset(0, 100 * (1 - value)),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2 + 80,
                    decoration: const BoxDecoration(
                      border: Border.symmetric(
                          horizontal: BorderSide(color: Colors.black12)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ///here we make a grid of 9 blocks and inflate it with the KeyPad buttons, and
                        ///pass the index value plus 1
                        GridView.builder(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 25.0),
                            itemCount: 9,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisExtent: 65.0,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    crossAxisCount: 3),
                            itemBuilder: (context, index) {
                              return DelayedFade(
                                delay: 750 + (index * 5),
                                child: KeyPadButton(
                                    index: index,
                                    tapAction: () {
                                      HapticFeedback.lightImpact();
                                      lockScreenController.insertText(
                                          '${index + 1}',
                                          widget.pinController2 ??
                                              widget.pinController);
                                      setState(() {});
                                    }),
                              );
                            }),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20.0,
                            left: 55.0,
                            right: 55.0,
                          ),
                          child: DelayedFade(
                            delay: 850,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                KeyPadButton(
                                  index: 9,
                                  tapAction: () {},
                                ),
                                KeyPadButton(
                                  index: 10,
                                  tapAction: () {
                                    lockScreenController.insertText(
                                        '0',
                                        widget.pinController2 ??
                                            widget.pinController);
                                    setState(() {});
                                  },
                                ),
                                KeyPadButton(
                                  index: 11,
                                  tapAction: () {
                                    HapticFeedback.lightImpact();
                                    if (widget.pinController2 == null) {
                                      if (widget.pinController.value.text
                                          .isNotEmpty) {
                                        widget.pinController.text = widget
                                            .pinController.value.text
                                            .substring(
                                                0,
                                                widget.pinController.value.text
                                                        .length -
                                                    1);
                                        setState(() {});
                                      }
                                    } else {
                                      if (widget.pinController2!.value.text
                                          .isNotEmpty) {
                                        widget.pinController2!.text = widget
                                            .pinController2!.value.text
                                            .substring(
                                                0,
                                                widget.pinController2!.value
                                                        .text.length -
                                                    1);
                                        setState(() {});
                                      }
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        DelayedAnimation(
                          delay: 950,
                          child: Container(
                              height: 60.0,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 40.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: BouncingWidget(
                                  child: Text(
                                    widget.isSetUpPIN || widget.isRestPIN
                                        ? 'Next'
                                        : widget.isChangePIN
                                            ? 'Next'
                                            : 'Login',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'Poppins'),
                                  ),
                                  onPressed: () {
                                    if (widget.isRestPIN) {
                                      if (widget.controller!.page == 0.0) {
                                        print('here');
                                        if (widget.pinController.value.text
                                                .length ==
                                            4) {
                                          widget.controller!.animateToPage(1,
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.easeIn);
                                        }
                                      } else if (widget.controller!.page ==
                                          1.0) {
                                        if (widget.pinController.value.text ==
                                            widget.pinController2!.value.text) {
                                          Server.updatePIN(widget
                                                  .pinController2!.value.text)
                                              .then((value) =>
                                                  Navigator.pop(context));
                                        } else {
                                          CustomOverlay.showToast(
                                              'Your PINs do not match',
                                              Colors.red,
                                              Colors.white);
                                        }
                                      }
                                    } else if (widget.isSetUpPIN) {
                                      if (widget.controller!.page == 0.0) {
                                        print('here');
                                        if (widget.pinController.value.text
                                                .length ==
                                            4) {
                                          widget.controller!.animateToPage(1,
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.easeIn);
                                        }
                                      } else if (widget.controller!.page ==
                                          1.0) {
                                        if (widget.pinController.value.text ==
                                            widget.pinController2!.value.text) {
                                          Server.createUserPIN(
                                                  context,
                                                  widget.pinController2!.value
                                                      .text)
                                              .then((value) =>
                                                  Navigator.pop(context));
                                        } else {
                                          CustomOverlay.showToast(
                                              'Your PINs do not match',
                                              Colors.red,
                                              Colors.white);
                                        }
                                      }
                                    } else if (widget.isChangePIN) {
                                      if (GetStorage().read('user_pin') !=
                                          null) {
                                        if (widget.controller!.page == 0.0) {
                                          if (widget.pinController.value.text ==
                                              GetStorage().read('user_pin')) {
                                            widget.controller!.animateToPage(1,
                                                duration: const Duration(
                                                    milliseconds: 300),
                                                curve: Curves.easeIn);
                                          } else {
                                            CustomOverlay.showToast(
                                                'Your PINs do not match',
                                                Colors.red,
                                                Colors.white);
                                          }
                                        } else if (widget.controller!.page ==
                                            1.0) {
                                          Server.updatePIN(widget
                                                  .pinController2!.value.text)
                                              .then((value) =>
                                                  Navigator.pop(context));
                                        }
                                      }
                                    } else {
                                      if (widget.pinController.value.text ==
                                          GetStorage().read('user_pin')) {
                                        widget.pinController.clear();
                                        widget.entry!.remove();
                                      } else {
                                        widget.pinController.clear();
                                        CustomOverlay.showToast('Incorrect PIN',
                                            Colors.red, Colors.white);
                                      }
                                    }
                                  })),
                        ),
                        widget.isSetUpPIN || widget.isRestPIN
                            ? Container()
                            : widget.isChangePIN
                                ? Container()
                                : DelayedAnimation(
                                    delay: 1000,
                                    child: BouncingWidget(
                                        child: Text(
                                          'Forgot PIN?',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17.sp,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Poppins'),
                                        ),
                                        onPressed: () {
                                          widget.entry!.remove();
                                          lockScreenController
                                              .showResetPINPage(context);
                                        }),
                                  ),
                      ],
                    ),
                  ),
                );
              }))
    ]);
  }
}

class SetNewPin extends StatefulWidget {
  const SetNewPin({Key? key}) : super(key: key);

  @override
  State<SetNewPin> createState() => _SetNewPinState();
}

class _SetNewPinState extends State<SetNewPin> {
  PageController controller = PageController();
  TextEditingController pin1 = TextEditingController();
  TextEditingController pin2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
      controller: controller,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        LockScreen(
          pinController: pin1,
          isRestPIN: true,
          title: 'Enter new Tuula PIN',
          controller: controller,
        ),
        LockScreen(
          pinController: pin1,
          pinController2: pin2,
          isRestPIN: true,
          title: 'Re-enter PIN',
          controller: controller,
        ),
      ],
    ));
  }
}

class ChangePin extends StatefulWidget {
  const ChangePin({Key? key}) : super(key: key);

  @override
  State<ChangePin> createState() => _ChangePinState();
}

class _ChangePinState extends State<ChangePin> {
  PageController controller = PageController();
  TextEditingController pin1 = TextEditingController();
  TextEditingController pin2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
      controller: controller,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        LockScreen(
          pinController: pin1,
          isChangePIN: true,
          title: 'Enter your Old Tuula PIN',
          controller: controller,
        ),
        LockScreen(
          pinController: pin1,
          pinController2: pin2,
          isChangePIN: true,
          title: 'Enter your New Tuula PIN',
          controller: controller,
        ),
      ],
    ));
  }
}

class SetUpPin extends StatefulWidget {
  const SetUpPin({Key? key}) : super(key: key);

  @override
  State<SetUpPin> createState() => _SetUpPinState();
}

class _SetUpPinState extends State<SetUpPin> {
  PageController controller = PageController();
  TextEditingController pin1 = TextEditingController();
  TextEditingController pin2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
      controller: controller,
      // physics: const NeverScrollableScrollPhysics(),
      children: [
        LockScreen(
          pinController: pin1,
          isSetUpPIN: true,
          title: 'Set up a Tuula PIN',
          controller: controller,
        ),
        LockScreen(
          pinController: pin1,
          pinController2: pin2,
          isSetUpPIN: true,
          title: 'Re-enter PIN',
          controller: controller,
        ),
      ],
    ));
  }
}
