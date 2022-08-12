import 'dart:async';

import 'package:banja/animation/animation.dart';
import 'package:banja/controllers/controllers.dart';
import 'package:banja/screens/auth/lock_screen.dart';
import 'package:banja/screens/profile.dart';
import 'package:banja/services/server.dart';
import 'package:banja/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  var userDetails = Get.put( UserDetailsController());
  var loanDetails = Get.put(LoanDetailController());
  var homeController = Get.put(HomePageController());

  // NotificationService notificationService = Get.find();
  var pin = TextEditingController();

  late AnimationController _controller;

  late OverlayEntry entry;
  OverlayEntry _getEntry(context) {
    entry = OverlayEntry(
      opaque: true,
      maintainState: true,
      builder: (_) => Material(
          child: LockScreen(
              pinController: pin, title: 'Enter your Tuula PIN', entry: entry)),
    );
    return entry;
  }

  @override
  void initState() {
    bool userHasProfile = GetStorage().read('userHasProfileAlready') ?? false;
    bool isPINEnabled = GetStorage().read('pin_enabled') ?? true;
    Timer.run(() {
      if (GetStorage().read('user_pin') != null) {
        if (isPINEnabled) {
          Overlay.of(context)!.insert(_getEntry(context));
        }
      }

      if (!userHasProfile) {
        userDetails.showRegPop(context, _controller);
      }
    });
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 740));

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
            FutureBuilder(
                future: Future.wait([
                  Server.fetchAllLoanCategories(),
                  Server.fetchMyLoanRecords(),
                  Server.fetchTransactions()
                ]),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LoadingData();
                  } else if (snapshot.data == null) {
                    return const NetworkError();
                  } else {
                    return PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: homeController.pageController,
                      children: [
                        Stack(
                          children: [
                            DashTopPart(
                              data: snapshot.data[1],
                              onClick: () {
                                homeController.sliderKey.currentState?.toggle();

                                HapticFeedback.lightImpact();
                              },
                              notifyTap: () {

                              },
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 445.h),
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                  children: [
                                    ListView.builder(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.w),
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            snapshot.data[0]['payload'].length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8.h),
                                            child: DelayedFade(
                                              delay: 400 + index * 100,
                                              child: GestureDetector(
                                                onTap: () {
                                                  HapticFeedback.lightImpact();

                                                  loanDetails.requestLoan(
                                                      loanStatus: snapshot.data[
                                                                  1] ==
                                                              null
                                                          ? '1'
                                                          : snapshot
                                                                  .data[1][
                                                                      'payload']
                                                                  .last[
                                                              'is_cleared'],
                                                      extraData:
                                                          snapshot.data[2],
                                                      context: context,
                                                      loanCategoryData: snapshot
                                                              .data[0]
                                                          ['payload'][index],
                                                      controller: _controller);
                                                },
                                                child: Container(
                                                  height: 60.h,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              241,
                                                              244,
                                                              244),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.r)),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10.w),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 60.w,
                                                          height: 50.w,
                                                          decoration: BoxDecoration(
                                                              color: const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  255,
                                                                  255,
                                                                  255),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.r)),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    2.w),
                                                            child: Image.asset(
                                                              'assets/images/loan.png',
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10.w,
                                                        ),
                                                        Text(
                                                          snapshot.data[0][
                                                                      'payload']
                                                                  [index]
                                                              ['loan_type'],
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 16.sp),
                                                        ),
                                                        const Spacer(),
                                                        Text(
                                                          'Apply',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 15.sp),
                                                        ),
                                                        SizedBox(
                                                          width: 10.w,
                                                        ),
                                                        const Icon(
                                                            Icons
                                                                .arrow_forward_ios,
                                                            color: Color(
                                                                0xff06919A))
                                                      ],
                                                    ),
                                                  ),
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
                    );
                  }
                }),
            Align(
              alignment: Alignment.bottomCenter,
              child: Obx(() {
                return BottomNavigationBar(
                    unselectedFontSize: 13,
                    selectedFontSize: 15,
                    selectedLabelStyle: const TextStyle(
                        color: Color.fromARGB(255, 0, 92, 98),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold),
                    unselectedLabelStyle: const TextStyle(
                        color: Color.fromARGB(255, 11, 14, 14),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal),
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
