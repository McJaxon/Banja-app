import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class NetworkError extends StatelessWidget {
  const NetworkError({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 307.h, left: 25.w, right: 25.w),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Something went wrong!',
              style: TextStyle(
                  fontSize: 38.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 15.h),
            Text(
              'Check your internet to be sure everything is working well',
              style: TextStyle(
                  fontSize: 28.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300),
            ),
            Center(child: Lottie.asset('assets/lotties/no-internet-animation.json', width: 240)),

            Text(
              'Clicking Restart App will reload the app and try to resolve the issue',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(height: 45.h),
            Center(
              child: TextButton.icon(
                  onPressed: () async {
                    // reset current app state
                    await Get.deleteAll(force: true);
                    // restart app
                    Phoenix.rebirth(Get.context!);
                    // reset get state
                    Get.reset();
                  },
                  icon: const Icon(CupertinoIcons.refresh),
                  label: Text(
                    'Restart App',
                    style: TextStyle(
                        fontSize: 28.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600),
                  )),
            ),

          ]),
        ],
      ),
    );
  }
}
