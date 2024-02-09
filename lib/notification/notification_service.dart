// import 'dart:js';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_table/pages/add_offer.dart';

class NotificationService {
  static Future<void> initializeNottification() async {
    await AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
              channelGroupKey: "high_importance_channel",
              channelKey: "high_importance_channel",
              channelName: "Basic notification",
              channelDescription: "Notification channel for basic tests",
              defaultColor: const Color(0xffF8853E),
              ledColor: Colors.white,
              importance: NotificationImportance.Max,
              channelShowBadge: true,
              onlyAlertOnce: true,
              playSound: true,
              criticalAlerts: true)
        ],
        channelGroups: [
          NotificationChannelGroup(
            channelGroupKey: "hiegh_importance_channel_group",
            channelGroupName: "Group 1",
          )
        ],
        debug: true);
    await AwesomeNotifications()
        .isNotificationAllowed()
        .then((isAllowed) async {
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }

  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationCreatedMethod');
  }

  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationDisplayedMethod');
  }

  static Future<void> onDismissActionReceivedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('onDismissActionReceivedMethod');
  }

  static Future<void> onActionReceivedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('onActionReceivedMethod');
    // final payload = receivedNotification.payload ?? {};
    // if (payload["navigate"] == "true") {
    //   //  Navigator.push(
    //                                     // context,
    //                                     // MaterialPageRoute(
    //                                         // builder: (context) =>
    //                                             // AddOffer()));
    //   MainApp.navigatorkey.currentState?.push(
    //     MaterialPageRoute(builder: (_)=> const AddOffer(),));
    // }
  }
  static Future<void> showNotification({
    required final String title,
    required final String body,
    final String? summary,
    final Map<String,String>? payload,
    final ActionType actionType = ActionType.Default,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? category,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButtons,
    final bool scheduled = false,
    final int? interval,
  })async{
    assert(!scheduled || (scheduled && interval != null));
    await AwesomeNotifications().createNotification(content: NotificationContent(id: -1, channelKey: 'high_importance_channel',
    title: title,
    body: body,
    actionType: actionType,
    notificationLayout: notificationLayout,
    summary: summary,
    category: category,
    payload: payload,
    bigPicture: bigPicture,),
    actionButtons: actionButtons,
    schedule: scheduled? NotificationInterval(interval: interval,
    timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
    preciseAlarm: true,): null,);
  }
}



// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class LocalNotifications {
//   static final FlutterLocalNotificationsPlugin
//       _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   static Future init() async {
//     // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     // FlutterLocalNotificationsPlugin();
// // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     final DarwinInitializationSettings initializationSettingsDarwin =
//         DarwinInitializationSettings(
//             onDidReceiveLocalNotification: ((id, title, body, payload) =>
//                 null));
//     final LinuxInitializationSettings initializationSettingsLinux =
//         LinuxInitializationSettings(defaultActionName: 'Open notification');
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: initializationSettingsAndroid,
//             iOS: initializationSettingsDarwin,
//             macOS: initializationSettingsDarwin,
//             linux: initializationSettingsLinux);
//     await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onDidReceiveNotificationResponse: ((details) => null));
//   }
//   static Future showSimpleNotification({
//     required String title,
//     required String body,
//     required String payload,
//   })async
// }
// import 'dart:html';

//// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationService {
//   final FlutterLocalNotificationsPlugin notificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   Future<void> initNotification() async {
//     AndroidInitializationSettings initializationSettingsAndroid =
//         const AndroidInitializationSettings('flutterlogo');
//     DarwinInitializationSettings initializationSettingsIOS =
//         DarwinInitializationSettings(
//             requestAlertPermission: true,
//             requestBadgePermission: true,
//             requestSoundPermission: true,
//             onDidReceiveLocalNotification: (id, title, body, payload) {});
//     var initializationSettings = InitializationSettings(
//         android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//     await notificationsPlugin.initialize(initializationSettings,
//         onDidReceiveBackgroundNotificationResponse: (details) {});
//   }

//   Future<void> simpleNotificationShow() async {
//     AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails("channelId", "channelName",
//             priority: Priority.high,
//             importance: Importance.max,
//             icon: 'flutter_logo',
//             channelShowBadge: true,
//             largeIcon: DrawableResourceAndroidBitmap('flutterlogo'));
//     NotificationDetails notificationDetails =
//         NotificationDetails(android: androidNotificationDetails);
//     await notificationsPlugin.show(
//         0, 'Simple Notification', "New User send message", notificationDetails);
//   }
// }

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationApi {
//   static final _notifications = FlutterLocalNotificationsPlugin();
//   static Future _notificationDetails() async {
//     return NotificationDetails(
//         android: AndroidNotificationDetails(
//             "channel id", 'channel name',
//             importance: Importance.max),
//             );
//   }
//     // static Future init({bool initScheduled = false})async{
//     //   final android = AndroidInitializationSettings("@mipmap/ic_launcher");
//     //   final settings = InitializationSettings(android: android,);
//     //   await _notifications.initialize(settings,);
//     // }
//   static Future showNotification(
//           {int id = 0, String? title, String? body, String? payload}) async =>
//       _notifications.show(
//         id,
//         title,
//         body,
//         await _notificationDetails(),
//         payload: payload,
//       );
// }
