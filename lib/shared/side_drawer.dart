import 'package:banja/animation/delay_fade.dart';
import 'package:banja/controllers/homepage_controller.dart';
import 'package:banja/screens/auth/register_page.dart';
import 'package:banja/screens/cashback.dart';
import 'package:banja/screens/dashboard.dart';
import 'package:banja/screens/faq.dart';
import 'package:banja/screens/make_deposit.dart';
import 'package:banja/screens/records.dart';
import 'package:banja/screens/slips.dart';
import 'package:banja/shared/prompt_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../controllers/user_detail_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SliderView extends StatelessWidget {
  SliderView({
    Key? key,
  }) : super(key: key);

  final UserDetailsController userDetails = Get.find();
  var homeController = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          end: Alignment.bottomCenter,
          begin: Alignment.topCenter,
          colors: [const Color(0xff007981), Colors.lightGreen.shade300],
        ),
      ),
      padding: EdgeInsets.only(top: 45.h),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 30.h,
            ),
            GetStorage().read('profilePic') == null
                ? Container()
                : DelayedFade(
                  delay: 200,
                  child: CircleAvatar(
                      radius: 65.r,
                      backgroundColor: Colors.white30,
                      child: Container(
                        width: 90.0,
                        height: 90.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(
                                  GetStorage().read('profilePic')),
                            )),
                      ),
                    ),
                ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              GetStorage().read('fullNames') == null
                  ? 'Hello there'
                  : 'Hi, ${GetStorage().read('fullNames')}',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 29.sp,
                  fontFamily: 'Poppins'),
            ),
            SizedBox(
              height: 40.h,
            ),
            Text(
              'Menu',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 25.sp,
                  fontFamily: 'Poppins'),
            ),
            SizedBox(
              height: 20.h,
            ),
            Divider(
              endIndent: 30.w,
              color: Colors.white54,
            ),
            SizedBox(
              height: 20.h,
            ),
            _SliderMenuItem(
                canPop: true,
                title: 'Home',
                iconData: 'Home',
                screen: const Dashboard()),
            _SliderMenuItem(
                title: 'Make Deposit',
                iconData: 'Wallet',
                screen: const MakeDeposit()),
            _SliderMenuItem(
                title: 'Records',
                iconData: 'Chart',
                screen: const RecordsPage()),
            _SliderMenuItem(
                title: 'CashBack',
                iconData: 'Discount',
                screen: const Cashback()),
            _SliderMenuItem(
                title: 'Slips',
                iconData: 'Paper Download',
                screen: const Slips()),
            _SliderMenuItem(
                title: 'FAQs', iconData: 'info', screen: const FAQ()),
            const Spacer(),
            _SliderMenuItem(
              logout: true,
              title: 'Log out',
              iconData: 'Logout',
            ),
            SizedBox(
              height: 40.h,
            ),
          ],
        ),
      ),
    );
  }
}

class _SliderMenuItem extends StatelessWidget {
  final String title;
  final String iconData;
  final Widget? screen;
  final bool canPop, logout;

  _SliderMenuItem(
      {Key? key,
      this.canPop = false,
      this.logout = false,
      required this.title,
      required this.iconData,
      this.screen})
      : super(key: key);
  HomePageController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return ListTile(
        textColor: Colors.white,
        contentPadding: EdgeInsets.zero,
        horizontalTitleGap: 4,
        title: Text(title, style: const TextStyle(fontFamily: 'Poppins')),
        leading: SvgPicture.asset(
          'assets/images/$iconData.svg',
          color: Colors.white,
        ),
        onTap: () {
          HapticFeedback.lightImpact();
          if (logout) {
            showDialog(
                context: context,
                builder: (context) {
                  return PromptBox(
                    action1: () {
                      Navigator.pop(context);
                    },
                    action2: () async {
                      GetStorage().erase();
                      await Get.deleteAll(force: true);
                      // restart app
                      Phoenix.rebirth(Get.context!);
                      // reset get state
                      Get.reset();
                    },
                    message:
                        'This will sign you out and erase app data but will not delete your loan information ',
                    title: 'Do you want to log out',
                  );
                });
          }

          if (canPop) {
            homeController.sliderKey.currentState?.closeSlider();
          } else {
            if (screen != null) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => screen!));
            }
          }
        });
  }
}
