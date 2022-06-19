import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class NetworkError extends StatelessWidget {
  const NetworkError({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: 245.h, left: 25.w, right: 25.w),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Lottie.asset(
                'assets/lotties/no-internet-animation.json'),
          ]),
    );
  }
}
