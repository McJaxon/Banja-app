// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_native_timezone/flutter_native_timezone.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

// class otificationService extends GetxController {
//   //instance of FlutterLocalNotificationsPlugin
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   String? selectedNotificationPayload;

//   Future<void> configureLocalTimeZone() async {
//     if (kIsWeb || Platform.isLinux) {
//       return;
//     }
//     tz.initializeTimeZones();
//     final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
//     tz.setLocalLocation(tz.getLocation(timeZoneName!));
//   }

//   Future<void> init() async {
//     //Initialization Settings for Android
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/icon');

//     //Initialization Settings for iOS
//     final IOSInitializationSettings initializationSettingsIOS =
//         IOSInitializationSettings(
//             requestSoundPermission: false,
//             requestBadgePermission: false,
//             requestAlertPermission: false,
//             onDidReceiveLocalNotification: (
//               int id,
//               String? title,
//               String? body,
//               String? payload,
//             ) async {
//               // didReceiveLocalNotificationSubject.add(
//               //   ReceivedNotification(
//               //     id: id,
//               //     title: title,
//               //     body: body,
//               //     payload: payload,
//               //   ),
//               // );
//             });

//     //Initializing settings for both platforms (Android & iOS)
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: initializationSettingsAndroid,
//             iOS: initializationSettingsIOS);

//     //configureLocalTimeZone();
//     //tz.initializeTimeZones();
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: (String? payload) async {
//       if (payload != null) {
//         debugPrint('notification payload: $payload');
//       }
//       selectedNotificationPayload = payload;
//       //selectNotificationSubject.add(payload);
//     });
//   }

//   onSelectNotification(String? payload) async {
//     //Navigate to wherever you want
//   }

//   requestIOSPermissions() {
//     flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(
//           alert: true,
//           badge: true,
//           sound: true,
//         );
//   }

//   Future<void> showNotifications({id, title, body, payload}) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails('your channel id', 'your channel name',
//             channelDescription: 'your channel description',
//             importance: Importance.max,
//             priority: Priority.high,
//             ticker: 'ticker');
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin
//         .show(id, title, body, platformChannelSpecifics, payload: payload);
//   }

//   Future<void> scheduleNotifications({id, title, body, time}) async {
//     try {
//       await flutterLocalNotificationsPlugin.zonedSchedule(
//           id,
//           title,
//           body,
//           tz.TZDateTime.from(time, tz.local),
//           const NotificationDetails(
//               android: AndroidNotificationDetails(
//                   'your channel id', 'your channel name',
//                   channelDescription: 'your channel description')),
//           androidAllowWhileIdle: true,
//           uiLocalNotificationDateInterpretation:
//               UILocalNotificationDateInterpretation.absoluteTime);
//     } catch (e) {
//       print(e);
//     }
//   }

//   static tz.TZDateTime _nextInstanceOfSetTime(int hour, int mins, int frequency) {
//     final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//     tz.TZDateTime scheduledDate =
//         tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, mins);
//     if (scheduledDate.isBefore(now)) {
//       scheduledDate = scheduledDate.add( Duration(days: frequency));
//     }
//     return scheduledDate;
//   }

//   Future<void> scheduleDailyNotification(int hour, int mins, frequency) async {
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//         0,
//         'Loan Payment Reminder',
//         'Please ensure to make to make a payment towards your loan today',
//         _nextInstanceOfSetTime(hour, mins, frequency),
//         const NotificationDetails(
//             android: AndroidNotificationDetails('Loan Payment Reminder',
//                 'Please ensure to make to make a payment towards your loan today',
//                 importance: Importance.max,
//                 priority: Priority.high,
//                 ticker: 'ticker',
//                 channelDescription: 'Please ensure to make to make a payment towards your loan today',
//                 sound: RawResourceAndroidNotificationSound(
//                   'accomplished',
//                 ),
//                 enableLights: true,
//                 color: Color.fromARGB(255, 255, 0, 0),
//                 ledColor: Color.fromARGB(255, 255, 0, 0),
//                 ledOnMs: 1000,
//                 ledOffMs: 500),
//             iOS: IOSNotificationDetails(sound: 'slow_spring_board.aiff')),
//         androidAllowWhileIdle: true,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime,
//         matchDateTimeComponents: DateTimeComponents.time);
//   }
// }
