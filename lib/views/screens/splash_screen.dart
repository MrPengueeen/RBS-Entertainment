import 'package:RBS/colors.dart';

import 'package:RBS/main.dart';

import 'package:RBS/views/screens/bottom_navbar_screen.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:velocity_x/velocity_x.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Notification handling

    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   RemoteNotification notification = message.notification;
    //   AndroidNotification android = message.notification?.android;

    //   if (notification != null && android != null) {
    //     flutterLocalNotificationsPlugin.show(
    //         notification.hashCode,
    //         notification.title,
    //         notification.body,
    //         NotificationDetails(
    //           android: AndroidNotificationDetails(
    //             channel.id,
    //             channel.name,
    //             channel.description,
    //             importance: Importance.max,
    //             priority: Priority.max,
    //             // TODO add a proper drawable resource to android, for now using
    //             //      one that already exists in example app.
    //           ),
    //         ));
    //   }
    // });

    Future.delayed(Duration(seconds: 4), () async {
      // bool isLoggedIn = await getBool(LOGGED_IN, defaultValue: false);

      context.nextReplacementPage(BottomNavigationBarScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: VStack([
        // Text(APP_NAME).text.xl5.bold.white.make().pOnly(bottom: 20),
        Image.asset(
          'assets/logos/logo_big.png',
          height: 100,
          width: 100,
        ),
        //LoadingWidget(),
      ], crossAlignment: CrossAxisAlignment.center)
          .centered(),
    );
  }
}
