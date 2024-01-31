import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:notiflut/message_screen.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationPlugin =
      FlutterLocalNotificationsPlugin();

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      dev.log('User Granted Permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      dev.log('User Granted Provisional');
    } else {
      dev.log('User Granted Dennied');
    }
  }

  Future<String?> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void initLocalNotifications(BuildContext context,RemoteMessage message) async {
    var androidInitialization =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitialization = const DarwinInitializationSettings();
    var initialicationSettings = InitializationSettings(
      android: androidInitialization,
      iOS: iosInitialization,
    );

    await _flutterLocalNotificationPlugin.initialize(initialicationSettings,
        onDidReceiveNotificationResponse: (payyload) {
          handleMessage(context, message);
        });
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      showNotification(message);
      print(message.notification!.title.toString());
       print(message.notification!.body.toString());
        print(message.data.toString());



      if (Platform.isAndroid) {
        initLocalNotifications(context, message);
        showNotification(message);
      }else {
          showNotification(message);
      }
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(100000).toString(),
        'High Important Notification',
        importance: Importance.max);
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: 'your channel description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const DarwinNotificationDetails iosNotifications =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotifications);

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationPlugin.show(
          1,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails);
    });
  }

  void onTokenRefresh() {
    messaging.onTokenRefresh.listen((event) {});
  }
// When app is in terminated
  Future<void> setUpIneractMessage(BuildContext context)async {
   
   RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
   if(initialMessage != null){
   handleMessage(context, initialMessage);
   }
// When app is in background
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    handleMessage(context, event);
  });
  }


  void handleMessage(BuildContext context, RemoteMessage message){
    if(message.data['type'] == 'msg'){
      Get.to(()=> MessageScreen(value: message.data['value'],));
    }

  }
}
