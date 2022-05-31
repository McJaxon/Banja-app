import 'package:banja/constants/strings.dart';
import 'package:banja/controllers/loanDetailControllers.dart';
import 'package:banja/models/loan_application_details_model.dart';
import 'package:banja/utils/customOverlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LoanDetail extends StatefulWidget {
  const LoanDetail({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<LoanDetail> createState() => _LoanDetailState();
}

class _LoanDetailState extends State<LoanDetail> {
  final LoanDetailController loanController = Get.find();
  List<bool> transactionSourceSelected = [];
  double loanAmount = 10000.0;
  double interestRate = 14.0;
  var paySchedule = 100;
  var tenurePeriod = 0;
  var transactionSourceType = 100;
  List<DropdownMenuItem<int>> dropdown = const [
    DropdownMenuItem(
        child: Text(
          '1 Week',
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 10.0,
              color: Color(0xff007981)),
        ),
        value: 1),
    DropdownMenuItem(
        child: Text(
          '1 Month',
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 10.0,
              color: Color(0xff007981)),
        ),
        value: 2),
    DropdownMenuItem(
        child: Text(
          '5 Months',
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 10.0,
              color: Color(0xff007981)),
        ),
        value: 3)
  ];

  @override
  void initState() {
    transactionSourceSelected =
        List<bool>.filled(transactionSource.length, false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xff06919A),
      body: Stack(
        children: <Widget>[
          Positioned(
            left: 20.w,
            top: 50.h,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r)),
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 8.0),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Color(0xff06919A),
                      size: 15.0,
                    ),
                  )),
            ),
          ),
          Positioned(
              left: 0.0,
              right: 0.0,
              top: 45.h,
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  widget.title,
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              )),
          Positioned(
              left: 0.0,
              right: 0.0,
              top: 75.0,
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'UGX${NumberFormat.decimalPattern().format(loanAmount)}/=',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 23.sp,
                      fontWeight: FontWeight.bold),
                ),
              )),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              width: double.infinity,
              height: size.height - 120.h,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(35.r),
                  )),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0.0, 25.h, 0.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.w, 0.0, 20.w, 0.0),
                      child: const Text(
                        'Loan Amount',
                        style: TextStyle(
                            fontFamily: 'Poppins', fontWeight: FontWeight.w500),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Slider(
                                min: 10000.0,
                                divisions: 4990,
                                max: 5000000.0,
                                value: loanAmount,
                                label: loanAmount.toString(),
                                inactiveColor: const Color(0xffE3E2E2),
                                activeColor: const Color(0xff007981),
                                onChanged: (value) {
                                  setState(() {
                                    loanAmount = value;
                                  });
                                })),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '10,000',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Text(
                            '5,000,000',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                      child: Text(
                        'Tenure Period',
                        style: TextStyle(
                            fontFamily: 'Poppins', fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                      child: Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                            color: const Color(0xffF2F2F2),
                            borderRadius: BorderRadius.circular(10.r)),
                        child: DropdownButtonFormField(
                            hint: Text(
                              'Pick tenure period',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.sp,
                                  color: const Color(0xff007981)),
                            ),
                            icon: const RotatedBox(
                                quarterTurns: 3,
                                child: Icon(Icons.arrow_back_ios_new_rounded,
                                    color: Color(0xff007981), size: 16.0)),
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 20.0),
                              border: InputBorder.none,
                            ),
                            items: dropdown,
                            onChanged: (int? value) {
                              setState(() {
                                tenurePeriod = value!;
                                if (tenurePeriod == 1) {
                                  interestRate = 14;
                                } else if (tenurePeriod == 2) {
                                  interestRate = 19;
                                } else if (tenurePeriod == 3) {
                                  interestRate = 23;
                                }
                              });
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              width: double.infinity,
              height: size.height - 385.h,
              decoration: BoxDecoration(
                  color: const Color(0xffF2F2F2),
                  borderRadius: BorderRadius.circular(35.r)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 0.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Remittance Schedule',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 15.sp,
                            color: const Color(0xff666666)),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        'Payment',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 15.sp,
                            color: const Color(0xff666666)),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ActionChip(
                              onPressed: () {
                                setState(() {
                                  paySchedule = 1;
                                });
                              },
                              backgroundColor: paySchedule == 1
                                  ? const Color(0xff007981)
                                  : Colors.white,
                              label: SizedBox(
                                  width: 80.w,
                                  child: Center(
                                      child: Text(
                                    'Daily',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: paySchedule == 1
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  )))),
                          ActionChip(
                              onPressed: () {
                                setState(() {
                                  paySchedule = 2;
                                });
                              },
                              backgroundColor: paySchedule == 2
                                  ? const Color(0xff007981)
                                  : Colors.white,
                              label: SizedBox(
                                  width: 80.w,
                                  child: Center(
                                      child: Text('Weekly',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: paySchedule == 2
                                                ? Colors.white
                                                : Colors.black,
                                          ))))),
                          ActionChip(
                              onPressed: () {
                                setState(() {
                                  paySchedule = 3;
                                });
                              },
                              backgroundColor: paySchedule == 3
                                  ? const Color(0xff007981)
                                  : Colors.white,
                              label: SizedBox(
                                  width: 80.w,
                                  child: Center(
                                      child: Text('Monthly',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: paySchedule == 3
                                                ? Colors.white
                                                : Colors.black,
                                          ))))),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 20.0, 20.0, 0.0),
                        child: Text(
                          'Interest Rate',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AbsorbPointer(
                              child: SliderTheme(
                                data: const SliderThemeData(
                                  trackHeight: 10.0,
                                  thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius: 6.8),
                                ),
                                child: Slider(
                                    divisions: 2,
                                    min: 14.0,
                                    max: 23.0,
                                    label:
                                        interestRate.toInt().toString() + ' %',
                                    value: interestRate,
                                    inactiveColor: const Color(0xffE3E2E2),
                                    activeColor: const Color(0xff007981),
                                    onChanged: (value) {
                                      HapticFeedback.lightImpact();
                                      setState(() {
                                        interestRate = value;
                                      });
                                    }),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '14%',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '19%',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '23%',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        'Transaction Source',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 15.sp,
                            color: const Color(0xff666666)),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(11.0)),
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: transactionSource.length,
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return RadioListTile(
                                  groupValue: transactionSourceType,
                                  activeColor: const Color(0xff007981),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  title: Text(
                                    transactionSource[index]['title'],
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16.sp),
                                  ),
                                  value: index,
                                  onChanged: (int? value) {
                                    setState(() {
                                      transactionSourceType = value!;
                                    });
                                  });
                            }),
                      ),
                      SizedBox(
                        height: 200.h,
                      )
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
                        height: 64.0,
                        child: CupertinoButton(
                          borderRadius: BorderRadius.circular(10.r),
                          color: const Color(0xff007981),
                          child: const Text(
                            'Apply',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600),
                          ),
                          onPressed: () {
                            HapticFeedback.lightImpact();

                            var loanApplicationDetails = LoanApplicationModel(
                                paymentTime: paySchedule == 1
                                    ? 'Daily'
                                    : paySchedule == 2
                                        ? 'Weekly'
                                        : 'Monthly',
                                paymentMode: transactionSourceType == 0
                                    ? 'Mobile Money'
                                    : transactionSourceType == 2
                                        ? 'Bank Transfer'
                                        : 'Cash',
                                loanPeriod: tenurePeriod == 1
                                    ? '1 Week'
                                    : tenurePeriod == 2
                                        ? '1 Month'
                                        : '5 Months',
                                approvedStatus: false,
                                loanType: widget.title,
                                loanID: '1',
                                loanAmount: loanAmount.toInt(),
                                tenurePeriod: tenurePeriod,
                                paymentFrequency: paySchedule,
                                interestRate: interestRate.toInt(),
                                transactionSource:
                                    transactionSourceType.toString(),
                                principal: loanController.calculateAmount(
                                    loanAmount, interestRate, 5),
                                interest: loanController.calculateAmount(
                                    loanAmount, interestRate, 5),
                                outstandingBalance:
                                    loanController.calculateAmount(
                                        loanAmount, interestRate, 5),
                                payOffDate: DateTime.now()
                                    .add(const Duration(days: 15)),
                                payBack: 450000,
                                isCleared: false);

                            if (tenurePeriod == 0) {
                              CustomOverlay.showToast(
                                  'Pick tenure period to continue ',
                                  Colors.orange.shade400,
                                  Colors.white);
                            } else if (paySchedule == 100) {
                              CustomOverlay.showToast(
                                  'Pick remittance schedule to continue ',
                                  Colors.orange.shade400,
                                  Colors.white);
                            } else if (transactionSourceType == 100) {
                              CustomOverlay.showToast(
                                  'Choose a way of a convenient way for paying your loan balances',
                                  Colors.orange.shade400,
                                  Colors.white);
                            } else {
                              print(
                                  DateTime.now().add(const Duration(days: 5)));
                              loanController.applyForLoan(
                                  context, loanApplicationDetails);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
