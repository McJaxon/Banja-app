//  DISABILITY INFORMATION MANAGEMENT SYSTEM - DMIS
//
//  Created by Ronnie Zad.
//  2021, Centric Solutions-UG. All rights reserved.
//

//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:oktoast/oktoast.dart';

class AnimatedTextExample {
  final String label;
  final Color? color;
  final Widget child;

  const AnimatedTextExample({
    required this.label,
    required this.color,
    required this.child,
  });
}

class CustomOverlay {
  CustomOverlay._();
  final bool isError = false;

  static showToast(String message, Color bgColor, Color textColor,
      {isError = false}) {
    Widget widget = Stack(clipBehavior: Clip.none, children: [
      Padding(
        padding: EdgeInsets.only(left: 40.w, right: 40.w),
        child: Material(
          shadowColor: bgColor,
          borderRadius: BorderRadius.circular(26.r),
          color: bgColor,
          elevation: 40.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(26.r),
            child: Container(
              width: double.infinity,
              height: 80.0,
              color: bgColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: textColor,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      Positioned(
        top: -75.h,
        left: 20.w,
        child: bgColor == Colors.red
            ? Lottie.asset('assets/lotties/error.json', width: 175.w)
            : Container(),
      )
    ]);
    showToastWidget(
      widget,
      position: ToastPosition.top,
      dismissOtherToast: true,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 200),
      duration: const Duration(seconds: 4),
    );
  }

  ///specify duration in seconds eg 2
  static showLoaderOverlay({int? duration}) {
    IgnorePointer loaderOverlay = IgnorePointer(
      child: SizedBox(
        width: 80.w,
        height: 80.w,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: SizedBox(
                  width: 30.w,
                  height: 30.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 4.w,
                    valueColor: const AlwaysStoppedAnimation(
                      Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    showToastWidget(
      loaderOverlay,
      dismissOtherToast: true,
      position: ToastPosition.center,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 200),
      duration: Duration(seconds: duration ?? 1),
    );
  }
}
