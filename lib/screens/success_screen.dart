import 'package:banja/models/loan_application_details_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:slide_countdown/slide_countdown.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:ticketview/ticketview.dart';
import '../controllers/loanDetailControllers.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({Key? key, required this.loanDetails}) : super(key: key);
  final LoanApplicationModel loanDetails;

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  final LoanDetailController paymentController = Get.find();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xff06919A),
        body: Stack(
          children: <Widget>[
            Positioned(
              left: 20.w,
              right: 20.w,
              top: 60.h,
              child: Column(
                children: [
                  Text(
                    widget.loanDetails.loanType,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    'Request Sent',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  Text(
                    'Wait for approval',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Time Remaining',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 16.6.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      const SlideCountdown(
                        decoration: BoxDecoration(),
                        duration: Duration(days: 1),
                      ),
                      Text(
                        'hours',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 16.6.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Lottie.asset('assets/images/waiting-pigeon.json',
                        width: 220.w
                        // controller: _controller,
                        ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                width: double.infinity,
                height: size.height - 380.h,
                decoration: BoxDecoration(
                    color: const Color(0xffF2F2F2),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(35.r))),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.w, 0.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: Padding(
                            padding: EdgeInsets.all(20.w),
                            child: SizedBox(
                              height: 390.h,
                              width: double.infinity,
                              child: TicketView(
                                backgroundColor: Colors.brown[300],
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 24, horizontal: 0),
                                drawArc: true,
                                triangleAxis: Axis.vertical,
                                borderRadius: 4,
                                drawDivider: true,
                                trianglePos: .18,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 20, 0, 20.w),
                                  child: Column(children: [
                                    Text(
                                      'Loan Repayment Summary',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: const Color(0xff007981),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.sp),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          25, 50, 25, 0),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Interest',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color:
                                                        const Color(0xff06919A),
                                                    fontSize: 13.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              const Spacer(),
                                              Text(
                                                '${widget.loanDetails.interestRate} %',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.black,
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Months',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color:
                                                        const Color(0xff06919A),
                                                    fontSize: 13.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              const Spacer(),
                                              Text(
                                                widget.loanDetails
                                                    .loanAmounts['loan_period'],
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.black,
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Remit',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color:
                                                        const Color(0xff06919A),
                                                    fontSize: 13.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              const Spacer(),
                                              Text(
                                                widget.loanDetails.loanAmounts[
                                                    'payment_time'],
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.black,
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Payment Mode',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color:
                                                        const Color(0xff06919A),
                                                    fontSize: 13.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              const Spacer(),
                                              Text(
                                                widget.loanDetails.loanAmounts[
                                                    'payment_mode'],
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.black,
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Row(
                                            children: [
                                              const Spacer(),
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                      Icons.copy_all_rounded)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 64.h,
                          child: CupertinoButton(
                            borderRadius: BorderRadius.circular(10.r),
                            color: const Color(0xff007981),
                            child: const Text(
                              'Go Home',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            onPressed: () {
                              HapticFeedback.lightImpact();
                              paymentController.updateDetails();
                            },
                          ),
                        ),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
