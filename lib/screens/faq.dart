import 'package:banja/controllers/homepage_controller.dart';
import 'package:banja/services/server.dart';
import 'package:intl/intl.dart';
import '../shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '/shared/shared.dart';

class FAQ extends StatefulWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
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
            heading: 'FAQ ',
          ),
          Positioned(
              left: 20.w,
              right: 20.w,
              top: 145.h,
              child: Text(
                'Find help and Frequently Asked Questions here',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 19.sp),
              )),
          FutureBuilder(
              future: Server.fetchAllFAQs(),
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
                        ListView.builder(
                          padding: EdgeInsets.only(top: 10.h, bottom: 200.h),
                          itemCount: snapshot.data['payload'].length,
                          itemBuilder: ((context, index) {

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
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
                                    borderRadius: BorderRadius.circular(10.r)),
                                child: Padding(
                                  padding: EdgeInsets.all(26.w),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data['payload'][index]
                                              ['question'],
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20.sp),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        const Divider(),
                                        RichText(
                                          text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Answer: ',
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16.sp),
                                                ),
                                                TextSpan(
                                                  text: snapshot.data['payload']
                                                      [index]['answer'],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w200,
                                                      fontSize: 16.sp),
                                                )
                                              ],
                                              style: const TextStyle(
                                                  color: Colors.black)),
                                        ),
                                        SizedBox(height: 5.h),
                                      ]),
                                ),
                              ),
                            );
                          }),
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
