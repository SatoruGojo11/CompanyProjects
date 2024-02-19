import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_notification_project/screens/chat_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void requestNotificationServices() async {
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
      log('User granted Permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('User provisional Permission');
    } else {
      log('User denied Permission');
    }
  }

  void initLocalNotification(
      BuildContext context, RemoteMessage message) async {
    // For Android
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    // For iOS
    // var iOSInitializationSettings =
    //     const DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      // iOS: iOSInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {
        handleMessage(context, message);
      },
    );
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      if (kDebugMode) {
        log(message.notification!.title.toString());
        log(message.notification!.body.toString());
        log(message.data.toString());
        log(message.data['type']);
        log(message.data['id']);
      }
      if (Platform.isAndroid) {
        initLocalNotification(context, message);
        showNotification(message);
      }
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      math.Random.secure().nextInt(10000).toString(),
      'High Importance Channel',
      importance: Importance.max,
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id,
      channel.name.toString(),
      channelDescription: 'Your Channel Description',
      icon: '@mipmap/ic_launcher',
      visibility: NotificationVisibility.public,
      channelShowBadge: true,
      color: channel.ledColor,
      colorized: true,
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    Future.delayed(
      Duration.zero,
      () {
        _flutterLocalNotificationsPlugin.show(
          1,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails,
        );
      },
    );
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      log(event);
    });
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();

    return token!;
  }

  Future<void> setupInteractMessage(BuildContext context) async {
    // When App is killed/Terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      if (context.mounted) {
        handleMessage(context, initialMessage);
      }
    }

    // When app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    if (message.data['type'] == 'message') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatPage(id: message.data['id'] ?? 'No data'),
        ),
      );
    }
  }
}
