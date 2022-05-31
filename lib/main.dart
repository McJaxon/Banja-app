import 'package:banja/onboarding/onboarding.dart';
import 'package:banja/pager.dart';
import 'package:banja/services/local_db.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oktoast/oktoast.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final _isBoardingSeenAlready =
      GetStorage().read('localDbInitialized') ?? false;

  if (!_isBoardingSeenAlready) {
    await LocalDB.createAppTables();
    GetStorage().write('localDbInitialized', true);
  }

  runApp(
    const OKToast(
      animationCurve: Curves.easeIn,
      animationDuration: Duration(milliseconds: 200),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final isBoardingSeenAlready =
        GetStorage().read('welcomeScreenSeen') ?? false;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild!.unfocus();
        }
      },
      child: ScreenUtilInit(
          designSize: const Size(520, 890),
          builder: (context) {
            return GetMaterialApp(
              title: 'Tuula Credit',
              theme: ThemeData(
                useMaterial3: true,
                primarySwatch: Colors.blue,
                pageTransitionsTheme: const PageTransitionsTheme(
                  builders: {
                    TargetPlatform.android: ZoomPageTransitionsBuilder(),
                    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
                  },
                ),
              ),
              builder: (context, widget) {
                return MediaQuery(
                  //Setting font does not change with system font size
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 0.95),
                  child: widget!,
                );
              },
              home: isBoardingSeenAlready ? const Pager() : const OnBoarding(),
            );
          }),
    );
  }
}
