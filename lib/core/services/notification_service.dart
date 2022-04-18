import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class NotificationsService {
  // var fcm = FirebaseMessaging.instance;
//   final _dbService = locator<DatabaseService>();
  // String? hostUserId;
// this string will hold the fcm token
  String? fcmToken;
// /// Create a [AndroidNotificationChannel] for heads up notifications
  late AndroidNotificationChannel channel;

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //This behaviouSubject instance is for listening purpose in ios either the fuction is recieved or not
  //or if recieved then what event u want to trigger
  // final BehaviorSubject<ReceivedNotification>
  //     didReceivedLocalNotificationSubject =
  //     BehaviorSubject<ReceivedNotification>();

  NotificationsService() {
    init();
  }

  Future<void> _configureLocalTimeZone() async {
    if (kIsWeb || Platform.isLinux) {
      return;
    }
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
  }

  ///
  /// init local notificaitons
  ///
  Future<void> init() async {
    await _configureLocalTimeZone();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('icon');

    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  schedule(int id, String title, String body, Time time) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        calculateNextTime(time),
        NotificationDetails(
          android: AndroidNotificationDetails('$id', title, body),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);

    debugPrint('scheduleTime => ${time.hour} and ${time.minute}');
    // const AndroidNotificationDetails androidPlatformChannelSpecifics =
    //     AndroidNotificationDetails('ST001', 'Android', 'description',
    //         priority: Priority.high);
    // const NotificationDetails platformChannelSpecifics =
    //     NotificationDetails(android: androidPlatformChannelSpecifics);

    // // ignore: deprecated_member_use
    // await flutterLocalNotificationsPlugin.periodicallyShow(
    //     id, title, body, RepeatInterval.everyMinute, platformChannelSpecifics,
    //     androidAllowWhileIdle: true);
  }

  tz.TZDateTime calculateNextTime(Time time) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, time.hour, time.minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  stopNotificaiton(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
    Get.snackbar('Stop Success', 'Notificatoins successfully stoped',
        snackPosition: SnackPosition.BOTTOM);
  }

  ///
  /// show local notificaiton
  showNotificaiton(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('ST001', 'Android', 'description',
            priority: Priority.high);
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      1,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  ///
  /// Schedule Notifications
  ///
  Future<void> scheduleNotification(
      {FlutterLocalNotificationsPlugin? notifsPlugin,
      String? id,
      String? title,
      String? body,
      TZDateTime? scheduledTime}) async {
    var androidSpecifics = AndroidNotificationDetails(
      id!, // This specifies the ID of the Notification
      'Scheduled notification', // This specifies the name of the notification channel
      'A scheduled notification', //This specifies the description of the channel
      icon: 'icon',
    );
    var iOSSpecifics = const IOSNotificationDetails();

    var platformChannelSpecifics =
        NotificationDetails(android: androidSpecifics, iOS: iOSSpecifics);
    // notifsPlugin!.showDailyAtTime(
    //     1, title, body, scheduledTime!, platformChannelSpecifics);

    await notifsPlugin!.zonedSchedule(
        0, title, body, scheduledTime!, platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future selectNotification(String? payload) async {
    //Handle notification tapped logic here
  }

  ///
  ///Initializing Notifiication services that includes FLN, ANDROID NOTIFICATION CHANNEL setting
  ///FCM NOTIFICATION SETTINGS, and also listeners for OnMessage and for onMessageOpenedApp
  ///
//   initConfigure() async {
//     try {
//       print("@initFCMConfigure/started");
//       // await initFlutterLocalNotificationPlugin();
//       NotificationSettings settings = await fcm.requestPermission(
//         alert: true,
//         announcement: false,
//         badge: true,
//         carPlay: false,
//         criticalAlert: false,
//         provisional: false,
//         sound: true,
//       );
//       _moveToTheRespectiveScreen() {
//         // Get.to(() => NotificationScreen(
//         //     notificationType: notifications.notificationType));
//       }

//       _handleNotification(RemoteMessage message, bool isOnMessage) {
//         // final Notifications notification =
//         //     Notifications.fromDirectJson(message.data);
//         // print(notification.title);
//         // print(notification.content);

//         if (isOnMessage) {
//           Get.snackbar(
//             'notification.title!',
//             'notification.content!',
//             backgroundColor: Colors.white,
//             duration: Duration(seconds: 4),
//             onTap: (data) {
//               // _moveToTheRespectiveScreen(notification);
//             },
//           );
//         } else {
//           // _moveToTheRespectiveScreen(notification);
//         }
//       }

//       ///
//       /// [onMessage] callback is called when the app is in foreground.
//       ///
//       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//         final data = message.data;
//         debugPrint('Got a new notification in the foreground now');
//         debugPrint('@OnMessage==> Message: $message');
//         debugPrint('@OnMessage==> Data: ${message.data}');
//         debugPrint('@OnMessage==> Notification: ${message.notification}');
//         // RemoteNotification notification = message.notification!;
//         // AndroidNotification android = message.notification!.android!;
//         // hostUserId = message.data['hostUserId'].toString();
//         if (message.data != null) {
//           _handleNotification(message, true);
//         }
//         // if (!kIsWeb && notification != null && android != null) {
//         //   Get.dialog(
//         //     AlertDialog(
//         //       title: Text('Notification Recieved'),
//         //       content: Text('A new notification Recieved'),
//         //     ),
//         //   );
//         //   // flutterLocalNotificationsPlugin!.show(
//         //   //     notification.hashCode,
//         //   //     notification.title,
//         //   //     notification.body,
//         //   //     NotificationDetails(
//         //   //       iOS: IOSNotificationDetails(subtitle: channel.description),
//         //   //       android: AndroidNotificationDetails(
//         //   //         channel.id,
//         //   //         channel.name,
//         //   //         channel.description,
//         //   //         // TODO add a proper drawable resource to android, for now using
//         //   //         //      one that already exists in example app.
//         //   //         icon: '@mipmap/ic_launcher',
//         //   //       ),
//         //   //     ));
//         // }
//       });

//       ///
//       /// [onMessageOpenedApp] callback is called when notification is received
//       /// in the background (Both when app is running in the background as well
//       /// as terminated) and the notification is clicked from the notification tray.
//       ///
//       FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//         final data = message.data;
//         debugPrint('Got a new notification in the foreground now');
//         debugPrint('@onMessageOpenedApp==> Data: $data');
//         _handleNotification(message, false);
//         // RemoteNotification notification = message.notification!;
//         // AndroidNotification android = message.notification!.android!;
//         // print('A new onMessageOpenedApp event was published!');
//         // if (notification != null && android != null) {
//         //   flutterLocalNotificationsPlugin!.show(
//         //       notification.hashCode,
//         //       notification.title,
//         //       notification.body,
//         //       NotificationDetails(
//         //         iOS: IOSNotificationDetails(subtitle: channel.description),
//         //         android: AndroidNotificationDetails(
//         //           channel.id,
//         //           channel.name,
//         //           channel.description,
//         //           // TODO add a proper drawable resource to android, for now using
//         //           //      one that already exists in example app.
//         //           icon: '@mipmap/ic_launcher',
//         //         ),
//         //       ));
//         // }
//       });
//     } catch (e, s) {
//       print(e);
//       print(s);
//     }
//     print("@initConfigure/ENDED");
//   }
// }
}
