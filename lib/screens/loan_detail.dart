import 'package:banja/constants/strings.dart';
import 'package:banja/controllers/loanDetailControllers.dart';
import 'package:banja/models/loan_application_details_model.dart';
import 'package:banja/shared/options_picker.dart';
import 'package:banja/utils/customOverlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LoanDetail extends StatefulWidget {
  LoanDetail(
      {Key? key,
      required this.data,
      required this.loanCategoryData,
      required this.loanID})
      : super(key: key);
  var loanCategoryData;
  final String loanID;

  var data;
  @override
  State<LoanDetail> createState() => _LoanDetailState();
}

class _LoanDetailState extends State<LoanDetail> {
  final LoanDetailController loanController = Get.find();

  List<DropdownMenuItem<int>> dropdown = const [
    DropdownMenuItem(
        child: Text(
          '1 Month',
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 10.0,
              color: Color(0xff007981)),
        ),
        value: 1),
    DropdownMenuItem(
        child: Text(
          '3 Months',
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 10.0,
              color: Color(0xff007981)),
        ),
        value: 2),
  ];

  @override
  void initState() {
    loanController.transactionSourceSelected =
        List<bool>.filled(transactionSource.length, false);
    loanController.loanAmount =
        double.parse(widget.loanCategoryData['minimum_amount']);

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
                  widget.loanCategoryData['loan_type'],
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
                  'UGX${NumberFormat.decimalPattern().format(loanController.loanAmount)}/=',
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
                                min: double.parse(
                                    widget.loanCategoryData['minimum_amount']),
                                divisions: 4990,
                                max: double.parse(
                                    widget.loanCategoryData['maximum_amount']),
                                value: loanController.loanAmount,
                                label: loanController.loanAmount
                                    .toInt()
                                    .toString(),
                                inactiveColor: const Color(0xffE3E2E2),
                                activeColor: const Color(0xff007981),
                                onChanged: (value) {
                                  setState(() {
                                    loanController.loanAmount = value;
                                  });
                                })),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            NumberFormat.decimalPattern().format(int.parse(
                                widget.loanCategoryData['minimum_amount'])),
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Text(
                            NumberFormat.decimalPattern().format(int.parse(
                                widget.loanCategoryData['maximum_amount'])),
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                      child: OptionsPicker(
                        title: 'Pick tenure period',
                        dropdown: dropdown,
                        onChanged: (value) {
                          setState(() {
                            loanController.tenurePeriod =
                                int.parse(value.toString());
                            if (loanController.tenurePeriod == 1) {
                              loanController.interestRate = 2.75;
                            } else if (loanController.tenurePeriod == 2) {
                              loanController.interestRate = 11;
                            }
                          });
                        },
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
                              // onPressed: () {
                              //   setState(() {
                              //     paySchedule = 3;
                              //   });
                              // },
                              onPressed: () {},
                              backgroundColor: loanController.paySchedule == 3
                                  ? const Color(0xff007981)
                                  : Colors.white,
                              label: SizedBox(
                                  width: 80.w,
                                  child: Center(
                                      child: Text('Daily',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color:
                                                loanController.paySchedule == 3
                                                    ? Colors.white
                                                    : Colors.black,
                                          ))))),
                          ActionChip(
                              onPressed: () {
                                setState(() {
                                  loanController.paySchedule = 1;
                                });
                              },
                              backgroundColor: loanController.paySchedule == 1
                                  ? const Color(0xff007981)
                                  : Colors.white,
                              label: SizedBox(
                                  width: 80.w,
                                  child: Center(
                                      child: Text(
                                    'Weekly',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: loanController.paySchedule == 1
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  )))),
                          ActionChip(
                              onPressed: () {
                                setState(() {
                                  loanController.paySchedule = 2;
                                });
                              },
                              backgroundColor: loanController.paySchedule == 2
                                  ? const Color(0xff007981)
                                  : Colors.white,
                              label: SizedBox(
                                  width: 80.w,
                                  child: Center(
                                      child: Text('Monthly',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color:
                                                loanController.paySchedule == 2
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
                                    min: 2.75,
                                    max: 23.0,
                                    label: loanController.interestRate
                                            .toInt()
                                            .toString() +
                                        ' %',
                                    value: loanController.interestRate,
                                    inactiveColor: const Color(0xffE3E2E2),
                                    activeColor: const Color(0xff007981),
                                    onChanged: (value) {
                                      HapticFeedback.lightImpact();
                                      setState(() {
                                        loanController.interestRate = value;
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
                              '2.75%',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '11%',
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
                            itemCount: widget.data.length,
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return RadioListTile(
                                  groupValue:
                                      loanController.transactionSourceType,
                                  activeColor: const Color(0xff007981),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  title: Text(
                                    widget.data[index]['name'],
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16.sp),
                                  ),
                                  value: index,
                                  onChanged: (int? value) {
                                    setState(() {
                                      loanController.transactionSourceType =
                                          value!;
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
                                approvedStatus: false,
                                isCleared: false,
                                loanType: widget.loanCategoryData['loan_type'],
                                loanID: widget.loanID,
                                interestRate:
                                    loanController.interestRate.toInt(),
                                transactionSource: loanController
                                    .transactionSourceType
                                    .toString(),
                                loanAmounts: loanController.calculateAmount(
                                    loanController.loanAmount,
                                    loanController.interestRate,
                                    loanController.tenurePeriod == 1 ? 4 : 3,
                                    loanController.paySchedule,
                                    loanController.transactionSourceType),
                                payOffDate: loanController.tenurePeriod == 1
                                    ? DateTime.now()
                                        .add(const Duration(days: 30))
                                    : DateTime.now()
                                        .add(const Duration(days: 90)));

                            if (loanController.tenurePeriod == 0) {
                              CustomOverlay.showToast(
                                  'Pick tenure period to continue ',
                                  Colors.orange.shade400,
                                  Colors.white);
                            } else if (loanController.paySchedule == 100) {
                              CustomOverlay.showToast(
                                  'Pick remittance schedule to continue ',
                                  Colors.orange.shade400,
                                  Colors.white);
                            } else if (loanController.transactionSourceType ==
                                100) {
                              CustomOverlay.showToast(
                                  'Choose a way of a convenient way for paying your loan balances',
                                  Colors.orange.shade400,
                                  Colors.white);
                            } else {
                              print(
                                  DateTime.now().add(const Duration(days: 5)));
                              print(loanApplicationDetails.toMap());
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
