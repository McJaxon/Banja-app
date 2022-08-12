import 'package:banja/controllers/user_detail_controller.dart';
import 'package:banja/models/loan_application_details_model.dart';
import 'package:banja/screens/dashboard.dart';
import 'package:banja/services/local_db.dart';
import 'package:banja/services/server.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../screens/loan_detail.dart';

class LoanDetailController extends GetxController {
  var payDetails = {}.obs;
  var loanDetails = [].obs;
  List<bool> transactionSourceSelected = [];
  double loanAmount = 10000.0;
  double interestRate = 2.75;
  var paySchedule = 100;
  var tenurePeriod = 0;
  var transactionSourceType = 100;
  var userDetails = Get.find<UserDetailsController>();
  TextEditingController amountController = TextEditingController();

  List<DropdownMenuItem<int>> dropdown = const [
    DropdownMenuItem(
        child: Text(
          '1 Month',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
              color: Color(0xff007981)),
        ),
        value: 1),
    DropdownMenuItem(
        child: Text(
          '3 Months',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
              color: Color(0xff007981)),
        ),
        value: 2),
  ];

  @override
  void onReady() async {
    super.onReady();
  }

  void getDetails() {
    Server.fetchMyLoanRecords().then((value) {
      if (value != null) {
        GetStorage().write('hasOngoingLoan', true);
        payDetails.addAll(value);
        loanDetails.addAll(value['payload']);
      }
    });
    // LocalDB.getLoanDetails().then((data) {
    //   if (data.isNotEmpty) {
    //     loanDetails.addAll(data);
    //   } else {
    //     Server.fetchMyLoanRecords().then((value) {
    //       if (value != null) {
    //         GetStorage().write('hasOngoingLoan', true);
    //         loanDetails.addAll(value);
    //       }
    //     });
    //   }
    // });
  }

  Future<void> showLoanInfo(BuildContext context, String loanType,
      String loanDescription, String minAmount, maxAmount) {
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
                    'About this loan',
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
                    loanType,
                    style: TextStyle(
                        fontSize: 25.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    loanDescription,
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w200),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  RichText(
                    text: TextSpan(
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w200),
                        text: 'Min Amount: ',
                        children: [
                          TextSpan(
                            text:
                                'UGX${NumberFormat.decimalPattern().format(int.parse(minAmount))}/=',
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500),
                          )
                        ]),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  RichText(
                    text: TextSpan(
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w200),
                        text: 'Min Amount: ',
                        children: [
                          TextSpan(
                            text:
                                'UGX${NumberFormat.decimalPattern().format(int.parse(maxAmount))}/=',
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500),
                          )
                        ]),
                  )
                ],
              ),
            ),
          );
        });
  }

  void requestLoan(
      {required BuildContext context,
      required var loanCategoryData,
      required extraData,
      required loanStatus,
      required AnimationController controller}) {
    bool userHasProfile = GetStorage().read('userHasProfileAlready') ?? false;

    if (userHasProfile) {
      Get.to(() => LoanDetail(
          previousLoanStatus: loanStatus,
          data: extraData,
          loanCategoryData: loanCategoryData,
          loanID: loanCategoryData['id'].toString()));
    } else {
      userDetails.showRegPop(context, controller);
    }
  }

  void applyForLoan(String previousLoanStatus, BuildContext context,
      LoanApplicationModel loanApplicationModel) {
    HapticFeedback.lightImpact();

    if (previousLoanStatus == '0') {
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              elevation: 24.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset('assets/lotties/max_loan_error.json',
                        width: 350.w),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      'Oh you have reached the limit of loans you can apply for!',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'You\'ve got to clear your current loan and then apply for a new one or you can talk to our managers for more assistance and arrangements.',
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 17.sp),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        HapticFeedback.lightImpact();
                      },
                      child: Container(
                        width: 230.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(17.r)),
                        child: Center(
                          child: Text('Okay, got it!',
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.white,
                                fontFamily: 'Poppins',
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    } else {
      try {
        Server.syncLoanApplication(context, loanApplicationModel);
      } catch (e) {
        print(e);
      }
    }
  }

  calculateAmount(var principal, var rate, var time, var remittanceSchedule,
      transactionPref) {
    double interest = (principal * rate * time) / 100;
    double amount = interest + principal;
    double payable = (amount / time);

    var variable = (time == 4 && remittanceSchedule == 1) ||
            (time == 3 && remittanceSchedule == 2)
        ? 1
        : time == 3 && remittanceSchedule == 1
            ? 2
            : 3;

    switch (variable) {
      case 1:
        return {
          'tenure_period': time == 4 ? 1 : 2,
          'payment_frequency': remittanceSchedule,
          'principal': principal,
          'loan_amount': principal,
          'interest': interest.round(),
          'total_amount': amount.round(),
          'loan_period': time == 4 ? '1 Month' : '3 Months',
          'payment_time': remittanceSchedule == 1 ? 'Weekly' : 'Monthly',
          'payment_mode': transactionPref == 0
              ? 'Mobile Money'
              : transactionPref == 2
                  ? 'Bank Transfer'
                  : 'Cash',
          //'total_payback': payable.round(),
          'payback_breakdown': payable.round()
        };

      case 2:
        return {
          'tenure_period': time == 4 ? 1 : 2,
          'payment_frequency': remittanceSchedule,
          'principal': principal,
          'loan_amount': principal,
          'interest': interest.round(),
          'total_amount': amount.round(),
          'loan_period': time == 4 ? '1 Month' : '3 Months',
          'payment_time': remittanceSchedule == 1 ? 'Weekly' : 'Monthly',
          'payment_mode': transactionPref == 0
              ? 'Mobile Money'
              : transactionPref == 2
                  ? 'Bank Transfer'
                  : 'Cash',
          //'payback': payable.round(),
          'payback_breakdown': (payable / 4).round()
        };
      case 3:
        return {
          'tenure_period': time == 4 ? 1 : 2,
          'payment_frequency': remittanceSchedule,
          'principal': principal,
          'loan_amount': principal,
          'interest': interest.round(),
          'total_amount': amount.round(),
          'loan_period': time == 4 ? '1 Month' : '3 Months',
          'payment_time': remittanceSchedule == 1 ? 'Weekly' : 'Monthly',
          'payment_mode': transactionPref == 0
              ? 'Mobile Money'
              : transactionPref == 2
                  ? 'Bank Transfer'
                  : 'Cash',
          //'payback': payable.round(),
          'payback_breakdown': (payable * 4).round()
        };

      default:
    }
  }
}
