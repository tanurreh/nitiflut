import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notiflut/firebase_options.dart';
import 'package:notiflut/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingHandler);

    await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return const MyApp();
      }));
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingHandler(RemoteMessage message)async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
        print(message.notification!.title.toString());
       print(message.notification!.body.toString());
        print(message.data.toString());


}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return const GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'notiflut',
          defaultTransition: Transition.downToUp,
          home: HomePageScreen());
  }
}
