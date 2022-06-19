import 'package:banja/controllers/homePageController.dart';
import 'package:banja/controllers/loanDetailControllers.dart';
import 'package:banja/controllers/payment_controllers.dart';
import 'package:banja/controllers/userDetailsController.dart';
import 'package:banja/services/server.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '/shared/shared.dart';

class MakeDeposit extends StatefulWidget {
  const MakeDeposit({Key? key}) : super(key: key);

  @override
  State<MakeDeposit> createState() => _MakeDepositState();
}

class _MakeDepositState extends State<MakeDeposit> {
  final homeController = Get.put(HomePageController());
  final userDetails = Get.put(UserDetailsController());
  final loanDetails = Get.put(LoanDetailController());
  final paymentController = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
          width: 70.w,
          height: 70.w,
          decoration: BoxDecoration(
            color: const Color(0xff007981),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: IconButton(
            onPressed: () async {
              //print(await Server.fetchMyPaymentDetails());
              homeController.showHelpDialog(context);
            },
            icon: const Icon(Icons.question_mark, color: Colors.white70),
          )),
      body: Stack(
        children: <Widget>[
          PageHeader(
            heading: 'Make Deposit',
          ),
          Positioned(
              left: 20.w,
              right: 20.w,
              top: 145.h,
              child: Text(
                'How would you like to to pay, you can choose a convenient method',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 19.sp),
              )),
          FutureBuilder(
              future: Server.fetchMyPaymentDetails(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingData();
                } else if (snapshot.hasError) {
                  return const NetworkError();
                } else if (snapshot.data == null) {
                  print(snapshot.data);
                  return const NoRecordError();
                } else {
                  print(snapshot.data);
                  return Padding(
                    padding:
                        EdgeInsets.only(top: 265.h, left: 20.w, right: 20.w),
                    child: snapshot.data['loan_status'] == '1'
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text(
                                  'Outstanding Balance\nUGX ${snapshot.data['loan_amount']}/=',
                                  style: TextStyle(
                                      fontSize: 35.sp,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  'Pay Back Amount: UGX' +
                                      snapshot.data['pay_back'].toString() +
                                      '/=',
                                  style: TextStyle(
                                      fontSize: 25.sp,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400),
                                ),
                                const Spacer(),
                                BouncingWidget(
                                  onPressed: () async {
                                    HapticFeedback.lightImpact();
                                    paymentController.payWithMobileMoney(
                                        context,
                                        snapshot.data['loan_id'].toString(),
                                        snapshot.data['pay_back'].toString());
                                  },
                                  child: Container(
                                      width: double.infinity,
                                      height: 75.0,
                                      decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius:
                                              BorderRadius.circular(36.r)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'Mobile Money',
                                            style: TextStyle(
                                                fontSize: 20.sp,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      )),
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                BouncingWidget(
                                  onPressed: () async {
                                    HapticFeedback.lightImpact();
                                    paymentController.payWithBank(
                                        context,
                                        snapshot.data['loan_id'].toString(),
                                        snapshot.data['pay_back'].toString());
                                  },
                                  child: Container(
                                      width: double.infinity,
                                      height: 75.0,
                                      decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius:
                                              BorderRadius.circular(36.r)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'Bank Transfer',
                                            style: TextStyle(
                                                fontSize: 20.sp,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      )),
                                ),
                                SizedBox(
                                  height: 40.h,
                                ),
                                Text(
                                  'All payment methods are secure, trusted and reliable',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400),
                                ),
                                const Spacer(),
                              ])
                        : Text(
                            'Your loan has not yet been approved',
                            style: TextStyle(
                                fontSize: 32.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600),
                          ),
                  );
                }
              }),
        ],
      ),
    );
  }
}
