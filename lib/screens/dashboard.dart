import 'dart:async';

import 'package:banja/constants/strings.dart';
import 'package:banja/controllers/homePageController.dart';
import 'package:banja/controllers/loanDetailControllers.dart';
import 'package:banja/controllers/notifications_controller.dart';
import 'package:banja/controllers/userDetailsController.dart';
import 'package:banja/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:awesome_circular_chart/awesome_circular_chart.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/shared/shared.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  var userDetails = Get.put(UserDetailsController());
  var loanDetails = Get.put(LoanDetailController());
  var homeController = Get.put(HomePageController());
  var notificationController = Get.put(NotificationsController());

  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 740));
    bool userHasProfile = GetStorage().read('userHasProfileAlready') ?? false;
    if (!userHasProfile) {
      Timer.run(() {
        // ignore: void_checks
        return userDetails.showRegPop(context, _controller);
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SliderDrawer(
      slideDirection: SlideDirection.LEFT_TO_RIGHT,
      appBar: Container(),
      sliderOpenSize: 240,
      key: homeController.sliderKey,
      slider: SliderView(),
      child: GestureDetector(
        onTap: () {
          homeController.sliderKey.currentState?.closeSlider();
        },
        child: Stack(
          children: [
            PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: homeController.pageController,
              children: [
                Stack(
                  children: [
                    DashTopPart(
                      onClick: () {
                        homeController.sliderKey.currentState?.toggle();
                      },
                      notifyTap: () {
                        notificationController.showNotificationModalPage(
                            context, build);
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 445.h),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            ListView.builder(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: loanCategory.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.h),
                                    child: Container(
                                      height: 60.h,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 241, 244, 244),
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 60.w,
                                              height: 50.w,
                                              decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 223, 229, 229),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.r)),
                                              child: Padding(
                                                padding: EdgeInsets.all(8.w),
                                                child: SvgPicture.asset(
                                                  'assets/images/${loanCategory[index]['asset']!}',
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Text(
                                              loanCategory[index]['category'],
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16.sp),
                                            ),
                                            const Spacer(),
                                            GestureDetector(
                                              onTap: () {
                                                HapticFeedback.lightImpact();
                                                loanDetails.requestLoan(
                                                    context: context,
                                                    loanCategory:
                                                        loanCategory[index]
                                                            ['category']!,
                                                    loanID: loanCategory[index]
                                                        ['loan_id']!,
                                                    controller: _controller);
                                              },
                                              child: Text(
                                                'Apply',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15.sp),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            const Icon(Icons.arrow_forward_ios,
                                                color: Color(0xff06919A))
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                            SizedBox(
                              height: 120.h,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const ProfilePage()
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Obx(() {
                return BottomNavigationBar(
                    selectedItemColor: Colors.lightBlue,
                    currentIndex: homeController.currentPage.value,
                    onTap: homeController.pageSelector,
                    elevation: 20.0,
                    selectedIconTheme:
                        const IconThemeData(color: Color(0xff007981)),
                    unselectedIconTheme:
                        const IconThemeData(color: Color(0xff9FCDD0)),
                    items: homeController.navBarItems);
              }),
            )
          ],
        ),
      ),
    ));
  }
}

class DashTopPart extends StatelessWidget {
  DashTopPart({Key? key, required this.onClick, required this.notifyTap})
      : super(key: key);

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
    return Obx(() {
      return Material(
        child: Stack(
          children: [
            Container(
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
            Container(
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
            ClipPath(
              clipper: LoginPageSmallClipper(),
              child: Container(
                  height: 306.w,
                  width: 308.w,
                  decoration: const BoxDecoration(color: Color(0xff0EA2AC))),
            ),
            Positioned(
                left: 20.w,
                top: 125.h,
                child: Text(
                  GetStorage().read('fullNames') == null
                      ? 'Welcome,'
                      : '${greeting.call()},\n${GetStorage().read('fullNames')}',
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18.0),
                )),
            Positioned(
                right: 170.w,
                top: 130.h,
                child: Image.asset(
                  'assets/images/Vector.png',
                  width: 76.w,
                  height: 60.w,
                )),
            Positioned(
                right: 20.w,
                top: 100.h,
                child: Image.asset(
                  'assets/images/card.png',
                  width: 126.w,
                  height: 85.h,
                )),
            Positioned(
                left: 20.w,
                right: 20.w,
                top: 50.h,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: onClick,
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
                    const Spacer(),
                    GestureDetector(
                      onTap: notifyTap,
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.r)),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
                            child: SvgPicture.asset(
                              'assets/images/bell.svg',
                            ),
                          )),
                    ),
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
                  itemCount: loanController.loanDetails.isEmpty
                      ? 1
                      : loanController.loanDetails.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, int index) {
                    return Column(
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
                                    loanController.loanDetails.isEmpty
                                        ? 'UGX-/='
                                        : 'UGX ${loanController.loanDetails[index]['loan_amount']}/=',
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
                                      34,
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
                              holeLabel: '34%',
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
                                    'Current Monthly\nPayment',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6.0,
                                  ),
                                  Text(
                                      loanController.loanDetails.isEmpty
                                          ? 'UGX-/='
                                          : 'UGX${loanController.loanDetails[index]['pay_back']}/=',
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
                                      loanController.loanDetails.isEmpty
                                          ? '-%'
                                          : '${loanController.loanDetails[index]['interest_rate']}%',
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
                                      loanController.loanDetails.isEmpty
                                          ? '--/--/--'
                                          : DateFormat.yMMMd().format(
                                              DateTime.parse(loanController
                                                      .loanDetails[index]
                                                  ['pay_off_date'].toString())),
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
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
