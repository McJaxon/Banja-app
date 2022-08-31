import 'dart:async';

import 'package:banja/pager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oktoast/oktoast.dart';
import 'bindings/home_bindings.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await NotificationService().configureLocalTimeZone();
  // await NotificationService().init();
  // await NotificationService().requestIOSPermissions();
  // HomeBindings();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Color.fromARGB(255, 255, 255, 255),
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarDividerColor: Color.fromARGB(255, 255, 255, 255),
  ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Future.delayed(const Duration(seconds: 5));
  runApp(
    Phoenix(
      child: const OKToast(
        animationCurve: Curves.easeIn,
        animationDuration: Duration(milliseconds: 200),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
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
          builder: (cont) {
            return GetMaterialApp(
                initialBinding: HomeBindings(),
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
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 0.96),
                    child: widget!,
                  );
                },
                home: const Pager());
          }),
    );
  }
}


