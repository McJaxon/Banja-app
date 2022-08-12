import 'package:banja/controllers/homepage_controller.dart';
import 'package:banja/services/server.dart';
import 'package:intl/intl.dart';
import '../shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '/shared/shared.dart';

class Slips extends StatefulWidget {
  const Slips({Key? key}) : super(key: key);

  @override
  State<Slips> createState() => _SlipsPageState();
}

class _SlipsPageState extends State<Slips> {
  final homeController = Get.put(HomePageController());
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
            onPressed: () {
              homeController.showHelpDialog(context);
            },
            icon: const Icon(Icons.question_mark, color: Colors.white70),
          )),
      body: Stack(
        children: <Widget>[
          PageHeader(
            heading: 'Slips',
          ),
          Positioned(
              left: 20.w,
              right: 20.w,
              top: 145.h,
              child: Text(
                'Your payment slips appear here',
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
                  return const NoRecordError();
                } else {
                  return Padding(
                    padding: EdgeInsets.only(
                      top: 265.h,
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Loan Amount: ',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20.sp),
                                  ),
                                  Text(
                                    'UGX ' +
                                        NumberFormat.decimalPattern().format(
                                            int.parse(snapshot
                                                .data['loan_amount']
                                                .toString())) +
                                        '/=',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20.sp),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Total Amount Paid: ',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20.sp),
                                  ),
                                  Text(
                                    'UGX ' +
                                        NumberFormat.decimalPattern().format(
                                            int.parse(snapshot
                                                .data['total_paid']
                                                .toString())) +
                                        '/=',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20.sp),
                                  ),
                                ],
                              ),
                              const Divider(),
                              Row(
                                children: [
                                  Text(
                                    'Balance: ',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 24.sp),
                                  ),
                                  Text(
                                    'UGX ' +
                                        NumberFormat.decimalPattern().format(
                                            int.parse(snapshot
                                                .data['outstanding_balance']
                                                .toString())) +
                                        '/=',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 24.sp),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 95.h),
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(
                                vertical: 30.h, horizontal: 20.w),
                            itemCount: snapshot.data['payload'].length,
                            itemBuilder: ((context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 20.3,
                                            offset: const Offset(0.5, 0.1),
                                            spreadRadius: 0.5,
                                            color: Colors.teal[50]!)
                                      ],
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  child: Padding(
                                    padding: EdgeInsets.all(26.w),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      //Spacer(),
                                                      Text(
                                                        snapshot.data['payload']
                                                                [index]
                                                            ['payment_date'],
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 23.sp),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Paid By:',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 18.sp),
                                                      ),
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      Text(
                                                        snapshot.data['payload']
                                                                [index]
                                                                ['full_names']
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.w200,
                                                            fontSize: 18.sp),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Amount:',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18.sp),
                                              ),
                                              const Spacer(),
                                              Text(
                                                'UGX ${NumberFormat.decimalPattern().format(int.parse(snapshot.data['payload'][index]['paid_amount'].toString()))}/=',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 18.sp),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 25.h,
                                          ),
                                          const Divider(
                                            color: Colors.black38,
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Paid using:',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18.sp),
                                              ),
                                              const Spacer(),
                                              Text(
                                                snapshot.data['payload'][index]
                                                    ['transaction_mode'],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 18.sp),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Transaction ID:',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18.sp),
                                              ),
                                              const Spacer(),
                                              Text(
                                                snapshot.data['payload'][index]
                                                        ['transaction_id']
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 18.sp),
                                              ),
                                            ],
                                          )
                                        ]),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              })
        ],
      ),
    );
  }
}
