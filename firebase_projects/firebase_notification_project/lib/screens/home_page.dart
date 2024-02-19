import 'dart:convert';
import 'dart:developer';

import 'package:firebase_notification_project/models/notification_setting.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NotificationServices services = NotificationServices();

  @override
  void initState() {
    super.initState();
    services.requestNotificationServices();
    services.firebaseInit(context);
    services.setupInteractMessage(context);
    // services.isTokenRefresh();
    services.getDeviceToken().then((value) {
      log('Device Token');
      log(value.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Firebase Local Notification Project  ',
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                services.getDeviceToken().then((value) async {
                  log(value.toString());
                  var data = {
                    'to': value.toString(),
                    'priority': 'high',
                    'notification': {
                      'title': 'Jaydip',
                      'body': 'Hello, How are you?',
                    },
                    'data': {
                      'type': 'message',
                      'id': '1212121212',
                    },
                  };
                  await http.post(
                      Uri.parse('https://fcm.googleapis.com/fcm/send'),
                      body: jsonEncode(data),
                      headers: {
                        'Content-Type': 'application/json; charset=UTF-8',
                        'Authorization':
                            'key=AAAAQfen5C8:APA91bEkFZ5BGNHdIfKgGAB70OAvoEwytVvASbPZRfhVFxrQoMXXCe5c4HgUqFFN88zQNrY9x5fkfCxkV_54qYj97Ij3DZThS03y8ZVeh4KCqIZcYe-ZfYgYU0ypTcNmzIo7STe2yVE8',
                      });
                });
              },
              child: const Text('Send Notification'),
            ),
          ],
        ),
      ),
    );
  }
}
