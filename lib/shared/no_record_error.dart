import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class NoRecordError extends StatelessWidget {
  const NoRecordError({
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
              'You currently have no records here!',
              style: TextStyle(
                  fontSize: 38.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600),
            ),
            Lottie.asset('assets/lotties/no-search-result.json'),
          ]),
    );
  }
}
