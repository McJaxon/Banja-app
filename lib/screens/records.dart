import 'package:banja/controllers/homePageController.dart';
import 'package:banja/services/server.dart';
import 'package:banja/widgets/headers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RecordsPage extends StatefulWidget {
  const RecordsPage({Key? key}) : super(key: key);

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
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
            heading: 'My Records',
          ),
          Positioned(
              left: 20.w,
              right: 20.w,
              top: 145.h,
              child: Text(
                'Loan and payment history details appear here',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 19.sp),
              )),
          FutureBuilder(
              future: Server.fetchMyLoanRecords(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Center(child: CircularProgressIndicator()),
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
                } else if (snapshot.hasError) {
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
                        ]),
                  );
                } else if (snapshot.data == null) {
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
                        ]),
                  );
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
                                    'You currently have one loan applications',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20.sp),
                                  ),
                                  // Text(
                                  //   'UGX ' +
                                  //       snapshot.data['loan_amount']
                                  //           .toString() +
                                  //       '/=',
                                  //   style: TextStyle(
                                  //       color: Colors.black87,
                                  //       fontFamily: 'Poppins',
                                  //       fontWeight: FontWeight.w600,
                                  //       fontSize: 20.sp),
                                  // ),
                                ],
                              ),
                              // Row(
                              //   children: [
                              //     Text(
                              //       'Total Amount Paid: ',
                              //       style: TextStyle(
                              //           color: Colors.black87,
                              //           fontFamily: 'Poppins',
                              //           fontWeight: FontWeight.w500,
                              //           fontSize: 20.sp),
                              //     ),
                              //     Text(
                              //       'UGX ' + snapshot.data['total_paid'] + '/=',
                              //       style: TextStyle(
                              //           color: Colors.black87,
                              //           fontFamily: 'Poppins',
                              //           fontWeight: FontWeight.w600,
                              //           fontSize: 20.sp),
                              //     ),
                              //   ],
                              // ),
                              // const Divider(),
                              // Row(
                              //   children: [
                              //     Text(
                              //       'Balance: ',
                              //       style: TextStyle(
                              //           color: Colors.black87,
                              //           fontFamily: 'Poppins',
                              //           fontWeight: FontWeight.w500,
                              //           fontSize: 24.sp),
                              //     ),
                              //     Text(
                              //       'UGX ' +
                              //           snapshot.data['outstanding_balance']
                              //               .toString() +
                              //           '/=',
                              //       style: TextStyle(
                              //           color: Colors.black87,
                              //           fontFamily: 'Poppins',
                              //           fontWeight: FontWeight.w600,
                              //           fontSize: 24.sp),
                              //     ),
                              //   ],
                              // ),
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
                                                            ['loan_type'],
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
                                                        'Loan Status',
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
                                                            ['is_approved'] == '0' ? 'Not Approved':'Approved',
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
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Loan Amount:',
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
                                                                ['loan_amount']
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
                                                'Pay Back amount:',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18.sp),
                                              ),
                                              const Spacer(),
                                              Text(
                                                'UGX ${snapshot.data['payload'][index]['pay_back']}/=',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 18.sp),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Interest Rate:',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18.sp),
                                              ),
                                              const Spacer(),
                                              Text(
                                                '${snapshot.data['payload'][index]['interest_rate']}%',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 18.sp),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.h,
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
                                                'Expected Completion Date:',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18.sp),
                                              ),
                                              const Spacer(),
                                              // Text(
                                              //   snapshot.data['payload'][index]
                                              //       ['transaction_mode'],
                                              //   style: TextStyle(
                                              //       color: Colors.black,
                                              //       fontFamily: 'Poppins',
                                              //       fontWeight: FontWeight.w200,
                                              //       fontSize: 18.sp),
                                              // ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Payment Time:',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18.sp),
                                              ),
                                              const Spacer(),
                                              Text(
                                                snapshot.data['payload'][index]
                                                    ['payment_time'],
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
                                                'Payment Mode:',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18.sp),
                                              ),
                                              const Spacer(),
                                              Text(
                                                snapshot.data['payload'][index]
                                                    ['payment_mode'],
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
