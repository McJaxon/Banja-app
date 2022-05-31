import 'package:banja/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';

import '../pager.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  end: Alignment.bottomCenter,
                  begin: Alignment.topCenter,
                  colors: [const Color(0xff007981), Colors.lightGreen.shade300],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Lottie.asset('assets/lotties/94138-lock.json',
                        width: 220.w),
                    Text('Secure', style: onBoardingHeavy),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                        'Tuula is secure and safe to use, get quick access to cheap loans with low rates',
                        textAlign: TextAlign.center,
                        style: onBoardingDescription),
                    const Spacer(),
                    Row(
                      children: [
                        Container(
                          width: 30.w,
                          height: 6.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Container(
                          width: 10.w,
                          height: 6.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: Colors.white60),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Container(
                          width: 10.w,
                          height: 6.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: Colors.white60),
                        ),
                        const Spacer(),
                        TextButton(
                            onPressed: () {
                              pageController.animateToPage(1,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.fastOutSlowIn);
                            },
                            child: Text('Next', style: onBoardingButton))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  end: Alignment.bottomCenter,
                  begin: Alignment.topCenter,
                  colors: [const Color(0xff007981), Colors.lightGreen.shade300],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Lottie.asset('assets/lotties/86023-earn-rewards.json',
                        width: 220.w
                        // controller: _controller,
                        ),
                    Text('Trusted', style: onBoardingHeavy),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                        'Tuula is trusted and a legit app to help you easily secure a simple loan',
                        textAlign: TextAlign.center,
                        style: onBoardingDescription),
                    const Spacer(),
                    Row(
                      children: [
                        Container(
                          width: 10.w,
                          height: 6.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: Colors.white60),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Container(
                          width: 30.w,
                          height: 6.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Container(
                          width: 10.w,
                          height: 6.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: Colors.white60),
                        ),
                        const Spacer(),
                        TextButton(
                            onPressed: () {
                              pageController.animateToPage(2,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.fastOutSlowIn);
                            },
                            child: Text('Next', style: onBoardingButton))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  end: Alignment.bottomCenter,
                  begin: Alignment.topCenter,
                  colors: [const Color(0xff007981), Colors.lightGreen.shade300],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Lottie.asset('assets/lotties/99625-instant-process.json',
                        width: 220.2),
                    Text('Fast', style: onBoardingHeavy),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                        'Fast, quick and reliable. Get loans in a flash. You loan requests are quickly approved and received via mobile',
                        textAlign: TextAlign.center,
                        style: onBoardingDescription),
                    const Spacer(),
                    Row(
                      children: [
                        Container(
                          width: 10.w,
                          height: 6.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: Colors.white60),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Container(
                          width: 10.w,
                          height: 6.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: Colors.white60),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Container(
                          width: 30.w,
                          height: 6.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: Colors.white),
                        ),
                        const Spacer(),
                        TextButton(
                            onPressed: () {
                              GetStorage().write('welcomeScreenSeen', true);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Pager()));
                            },
                            child: Text('Next', style: onBoardingButton))
                      ],
                    ),
                  ],
                ),
              ),
            )
          ]),
    );
  }
}
