import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePageController extends GetxController {
  final sliderKey = GlobalKey<SliderDrawerState>();
  PageController pageController = PageController();
  late AnimationController controller;
  var currentPage = 0.obs;

  List<BottomNavigationBarItem> navBarItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.dashboard),
      label: '',
    ),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.person_solid), label: '')
  ];

  void pageSelector(index) {
    HapticFeedback.lightImpact();
    currentPage.value = index;

    switch (index) {
      case 0:
        pageController.animateToPage(0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.decelerate);

        break;

      case 1:
        pageController.animateToPage(1,
            duration: const Duration(milliseconds: 300),
            curve: Curves.decelerate);

        break;
      default:
    }
  }

  //   void _callPhone() async {
  //   const url = 'http://dmis.mglsd.go.ug/terms-of-use';

  //   if (await launchUrl(url)) {
  //     await launchUrl(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  showHelpDialog(BuildContext context) {
    HapticFeedback.lightImpact();
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            elevation: 24.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(17.r),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset(
                    'assets/lotties/get_help.json',
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.w),
                    child: Column(
                      children: [
                        Text(
                          'Looking for help and more info?',
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
                          'We are here for you, engage us via the following services. Tap to any convenient platforms to start a chat',
                          style:
                              TextStyle(fontFamily: 'Poppins', fontSize: 17.sp),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        Wrap(
                          runAlignment: WrapAlignment.center,
                          alignment: WrapAlignment.center,
                          spacing: 6.w,
                          runSpacing: 6.w,
                          children: [
                            ActionChip(
                                label: Text(
                                  'Whatsapp',
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 15.sp),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                            ActionChip(
                                label: Text(
                                  'Phone',
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 15.sp),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  _makePhoneCall('07053243424');
                                }),
                            ActionChip(
                                label: Text(
                                  'Email',
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 15.sp),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                            ActionChip(
                                label: Text(
                                  'SMS',
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 15.sp),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
