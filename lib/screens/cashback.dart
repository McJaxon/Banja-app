import 'package:banja/controllers/homePageController.dart';
import 'package:banja/services/server.dart';
import 'package:banja/utils/customOverlay.dart';
import 'package:banja/widgets/headers.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nanoid/nanoid.dart';
import 'package:share_plus/share_plus.dart';

class Cashback extends StatefulWidget {
  const Cashback({Key? key}) : super(key: key);

  @override
  State<Cashback> createState() => _CashbackState();
}

class _CashbackState extends State<Cashback> {
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
            heading: 'Cashback',
          ),
          Positioned(
              left: 20.w,
              right: 20.w,
              top: 145.h,
              child: Text(
                'Get bonuses and cash when you invite your friends and family to the Tuula Credit App.',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 19.sp),
              )),
          Padding(
            padding: EdgeInsets.only(top: 245.h, left: 25.w, right: 25.w),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'You have made no referrals yet!',
                style: TextStyle(
                    fontSize: 38.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              BouncingWidget(
                onPressed: () {
                  HapticFeedback.lightImpact();
                  var userTag = GetStorage().read('user_tag');
                  if (userTag != null) {
                    Share.share(
                        'I use the Tuula app to get cheap loans instantly on my phone...use my Tag as a referral code: $userTag');
                  } else {
                    CustomOverlay.showToast(
                        'Wait, creating your tag', Colors.green, Colors.white);
                    var userName =
                        GetStorage().read('fullNames').toString().split(' ')[0];
                    var userTagName =
                        userName + '-' + customAlphabet('1234567890abcdef', 5);

                    Server.createUserTag(context, userTagName).then((value) {
                      if (value) {
                        Share.share(
                            'I use the Tuula app to get cheap loans instantly on my phone...use my Tag as a referral code: ${GetStorage().read('user_tag')}');
                      }
                    });
                  }
                },
                child: Container(
                    width: double.infinity,
                    height: 75.0,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(36.r)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Invite new user',
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
                onPressed: () {
                  HapticFeedback.lightImpact();

                  var userTag = GetStorage().read('user_tag');

                  if (userTag != null) {
                    Clipboard.setData(ClipboardData(
                            text:
                                "I use the Tuula app to get cheap loans instantly on my phone...use my Tag as a referral code: $userTag"))
                        .whenComplete(() {
                      CustomOverlay.showToast(
                        'Copied to your Clipboard!',
                        const Color.fromARGB(255, 14, 86, 51),
                        Colors.white,
                      );
                    });
                  } else {
                    CustomOverlay.showToast(
                        'Wait, creating your tag', Colors.green, Colors.white);
                    var userName =
                        GetStorage().read('fullNames').toString().split(' ')[0];
                    var userTag =
                        userName + '-' + customAlphabet('1234567890abcdef', 5);
                    Server.createUserTag(context, userTag).then((value) {
                      if (value) {
                        Clipboard.setData(ClipboardData(
                                text:
                                    "I use the Tuula app to get cheap loans instantly on my phone...use my Tag as a referral code: $userTag"))
                            .whenComplete(() {
                          CustomOverlay.showToast(
                            'Copied to your Clipboard!',
                            const Color.fromARGB(255, 14, 86, 51),
                            Colors.white,
                          );
                        });
                      }
                    });
                  }
                },
                child: Container(
                    width: double.infinity,
                    height: 75.0,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(36.r)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Copy my Referral ID',
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    )),
              ),
              const Spacer(),
            ]),
          )
        ],
      ),
    );
  }
}
