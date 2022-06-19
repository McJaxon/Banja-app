import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LoadingData extends StatelessWidget {
  const LoadingData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
            child: Lottie.asset('assets/lotties/loading-circle.json',
                width: 250.w)),
        SizedBox(height: 14.h),
        Text(
          'Fetching data from server',
          style: TextStyle(
              fontSize: 18.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}
