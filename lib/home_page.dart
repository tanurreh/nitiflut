
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:notiflut/services/notification_services.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {

  NotificationServices ns = NotificationServices();


  @override
  void initState() {
    ns.requestNotificationPermission();
    ns.setUpIneractMessage(context);
    super.initState();
  ns.firebaseInit(context);
  ns.onTokenRefresh();
  ns.getDeviceToken().then((value) {
    log(value!);
  });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body:const  Column(
        children: [
          Center(
            child: Text('Hello!'),
          )
        ],
      ),
    );
  }
}