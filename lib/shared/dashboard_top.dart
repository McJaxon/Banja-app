
import 'package:awesome_circular_chart/awesome_circular_chart.dart';
import 'package:banja/controllers/loan_detail_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../animation/animation.dart';
import '../controllers/user_detail_controller.dart';
import 'clippers.dart';

class DashTopPart extends StatelessWidget {
  DashTopPart(
      {Key? key,
      required this.data,
      required this.onClick,
      required this.notifyTap})
      : super(key: key);
  var data;
  final LoanDetailController loanController = Get.find();
  final UserDetailsController userDetails = Get.find();
  final VoidCallback onClick, notifyTap;

  String greeting() {
    var timeNow = DateTime.now().hour;

    if (timeNow <= 12) {
      return 'Good Morning';
    } else if ((timeNow > 12) && (timeNow <= 16)) {
      return 'Good Afternoon';
    } else if ((timeNow > 16) && (timeNow < 20)) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Animator(
              delay: 400,
              builder: (context, w, value) {
                return Transform.translate(
                  offset: Offset(0, -100 * (1 - value)),
                  child: Container(
                    height: 430.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0.0, 4.0),
                            blurRadius: 5.0,
                            spreadRadius: 0.0,
                            color: Color.fromRGBO(0, 0, 0, 0.12))
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(23.r),
                          bottomRight: Radius.circular(23.r)),
                    ),
                  ),
                );
              }),
          Animator(
              delay: 500,
              builder: (context, w, value) {
                return Transform.translate(
                  offset: Offset(0, -40 * (1 - value)),
                  child: Container(
                    height: 220.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0.0, 4.0),
                            blurRadius: 5.0,
                            spreadRadius: 0.0,
                            color: Color.fromRGBO(0, 0, 0, 0.12))
                      ],
                      color: const Color(0xff06919A),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(23.r),
                          bottomRight: Radius.circular(23.r)),
                    ),
                  ),
                );
              }),
          DelayedFade(
            delay: 400,
            child: ClipPath(
              clipper: LoginPageSmallClipper(),
              child: Container(
                  height: 306.w,
                  width: 308.w,
                  decoration: const BoxDecoration(color: Color(0xff0EA2AC))),
            ),
          ),
          Positioned(
            left: 20.w,
            top: 125.h,
            child: DelayedFade(
              delay: 200,
              child: Text(
                GetStorage().read('fullNames') == null
                    ? 'Welcome,'
                    : '${greeting.call()},\n${GetStorage().read('fullNames')}',
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0),
              ),
            ),
          ),
          Positioned(
              right: 170.w,
              top: 130.h,
              child: DelayedFade(
                delay: 350,
                child: Image.asset(
                  'assets/images/Vector.png',
                  width: 76.w,
                  height: 60.w,
                ),
              )),
          Positioned(
              right: 20.w,
              top: 100.h,
              child: DelayedFade(
                delay: 300,
                child: Image.asset(
                  'assets/images/card.png',
                  width: 126.w,
                  height: 85.h,
                ),
              )),
          Positioned(
              left: 20.w,
              right: 20.w,
              top: 65.h,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: onClick,
                    child: DelayedFade(
                      delay: 200,
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.r)),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
                            child: SvgPicture.asset(
                              'assets/images/menu.svg',
                            ),
                          )),
                    ),
                  ),
                  // const Spacer(),
                  // GestureDetector(
                  //   onTap: notifyTap,
                  //   child: Container(
                  //       decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius: BorderRadius.circular(8.r)),
                  //       child: Padding(
                  //         padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
                  //         child: SvgPicture.asset(
                  //           'assets/images/bell.svg',
                  //         ),
                  //       )),
                  // ),
                ],
              )),
          Positioned(
            left: 20.w,
            bottom: 6.h,
            right: 0.w,
            child: SizedBox(
              height: 220.h,
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 1,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, int index) {
                  return DelayedFade(
                    delay: 450,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        Row(
                          children: <Widget>[
                            index == 0
                                ? Container(
                                    width: 30.w,
                                    height: 6.h,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        color: const Color(0xff06919A)),
                                  )
                                : Container(),
                            SizedBox(
                              width: 4.w,
                            ),
                            Container(
                              width: 10.w,
                              height: 6.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color:
                                      const Color.fromARGB(113, 6, 144, 154)),
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            index == 1
                                ? Container(
                                    width: 30.w,
                                    height: 6.h,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        color: const Color(0xff06919A)),
                                  )
                                : Container(),
                            SizedBox(
                              width: 4.w,
                            ),
                            Container(
                              width: 10.w,
                              height: 6.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color:
                                      const Color.fromARGB(113, 6, 144, 154)),
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            index == 2
                                ? Container(
                                    width: 30.w,
                                    height: 6.h,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        color: const Color(0xff06919A)),
                                  )
                                : Container(),
                            SizedBox(
                              width: 4.w,
                            ),
                            Text(
                              loanController.loanDetails.isEmpty
                                  ? ''
                                  : '${index + 1}/${loanController.loanDetails.length.toString()}',
                              style: TextStyle(
                                  fontFamily: 'Poppins', fontSize: 15.sp),
                            ),
                            const Spacer(),
                            Text(
                              data == null
                                  ? 'You have no loans'
                                  : data['payload'][index]['is_approved'] == '0'
                                      ? 'Your loan has not yet been approved'
                                      : 'Your loan has been approved',
                              style: TextStyle(
                                  fontFamily: 'Poppins', fontSize: 15.sp),
                            ),
                            SizedBox(
                              width: 20.w,
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Balance',
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 18.sp),
                                ),
                                Text(
                                    data == null
                                        ? 'UGX-/='
                                        : 'UGX ${NumberFormat.decimalPattern().format(int.parse(data['outstanding_balance'].toString()))}/=',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: const Color(0xff007981),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 25.sp)),
                              ],
                            ),
                            const Spacer(),
                            AnimatedCircularChart(
                              size: Size(130.w, 130.w),
                              initialChartData: <CircularStackEntry>[
                                CircularStackEntry(
                                  <CircularSegmentEntry>[
                                    CircularSegmentEntry(
                                      data == null
                                          ? 0
                                          : (int.parse((data['total_paid'])
                                                      .toString()) /
                                                  int.parse(
                                                      (data['total_loan_amount']
                                                          .toString()))) *
                                              100.0,
                                      Colors.blue[400],
                                      rankKey: 'completed',
                                    ),
                                    CircularSegmentEntry(
                                      100,
                                      Colors.blueGrey[600],
                                      rankKey: 'remaining',
                                    ),
                                  ],
                                  rankKey: 'progress',
                                ),
                              ],
                              edgeStyle: SegmentEdgeStyle.round,
                              chartType: CircularChartType.Radial,
                              percentageValues: true,
                              holeLabel: data == null
                                  ? '0%'
                                  : ((int.parse((data['total_paid'])
                                                      .toString()) /
                                                  int.parse(
                                                      (data['total_loan_amount']
                                                          .toString()))) *
                                              100.0)
                                          .round()
                                          .toString() +
                                      '%',
                              holeRadius: 15.0,
                              labelStyle: TextStyle(
                                color: Colors.blueGrey[600],
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data == null
                                        ? 'Current Payment\nPayback'
                                        : 'Current ${(data['payload'][index]['payment_time'])}\nPayment',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6.0,
                                  ),
                                  Text(
                                      data == null
                                          ? 'UGX-/='
                                          : 'UGX${NumberFormat.decimalPattern().format(int.parse(data['payload'][index]['pay_back']))}/=',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: const Color(0xff007981),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.sp)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Average Interest\nRate',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  Text(
                                      data == null
                                          ? '-%'
                                          : '${data['payload'][index]['interest_rate']}%',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: const Color(0xff007981),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.sp)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Payoff Date',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                  SizedBox(
                                    height: 22.h,
                                  ),
                                  Text(
                                      data == null
                                          ? '--/--/--'
                                          : DateFormat.yMMMd().format(
                                              DateTime.parse(data['payload']
                                                      [index]['pay_off_date']
                                                  .toString())),
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: const Color(0xff007981),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.sp)),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
