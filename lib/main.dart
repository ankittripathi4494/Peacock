import 'dart:math';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:camera/camera.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pecockapp/global/blocs/internet/internet_cubit.dart';
import 'package:pecockapp/global/utils/firebase_helper.dart';
import 'package:pecockapp/global/utils/logger_util.dart';
import 'package:pecockapp/global/utils/routes_section.dart';
import 'package:pecockapp/global/utils/shared_preferences_helper.dart';
import 'package:pecockapp/modules/customer/bloc/customer_bloc.dart';
import 'package:pecockapp/modules/login/bloc/login_bloc.dart';
import 'package:pecockapp/modules/register/bloc/register_bloc.dart';

NotificationChannel nc = NotificationChannel(
  channelKey: 'peacock',
  channelName: 'Peacock',
  channelDescription: 'This is Test App',
);

late List<CameraDescription> listOfCameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize();
  await SharedPreferencesHelper().init();
  await initialFirebaseNotification();
  listOfCameras = await availableCameras();
  FirebaseMessaging.onBackgroundMessage(_backgroundNotificationHandler);
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  ).then((_) {
    runApp(const MyApp());
  });
}

Future<void> _backgroundNotificationHandler(RemoteMessage message) async {
  await initialFirebaseNotification();
  // Create notification in the background
  _showNotification(message);
}

Future<void> initialFirebaseNotification() async {
  await FirebaseHelper().init();
  await AwesomeNotifications().initialize(
    null,
    [nc],
    debug: true,
  );

  FirebaseHelper.generateFirebaseToken().then((c) {
    LoggerUtil().debugData("Token :- $c");
  }).onError((e, k) {
    LoggerUtil().errorData("Error Firebase :- ${e.toString()}");
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    // Ensure you have permission
    bool permissionGranted =
        await AwesomeNotifications().requestPermissionToSendNotifications();

    LoggerUtil().debugData("Permission Allowed :- $permissionGranted");

    if (permissionGranted) {
      _showNotification(message);
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    // Handle notification tap when the app is in the background
  });
}

void _showNotification(RemoteMessage message) {
  // Extracting title and body from the RemoteMessage
  String title = message.notification?.title ?? 'Default Title';
  String body = message.notification?.body ?? 'Default Body';

  // Create the notification content
  AwesomeNotifications().createNotification(
    content: NotificationContent(
      largeIcon: "asset://assets/images/splashImage.png", // Local asset
      bigPicture: "asset://assets/images/splashImage.png", // Local asset
      fullScreenIntent: true,
      criticalAlert: true,
      id: Random().nextInt(1000), // Unique ID for each notification
      channelKey: nc.channelKey ?? 'peacock', // Ensure your channel key matches
      title: title,
      body: body,
      notificationLayout:
          NotificationLayout.BigPicture, // Use BigPicture layout
    ),
  );
}

//
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      //every upcoming blocs must be register here
      providers: [
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider<CustomerBloc>(
          create: (context) => CustomerBloc(),
        )
      ],
      child: const MaterialApp(
        initialRoute: '/',
        onGenerateRoute: RoutesSection.routers,
      ),
    ); // MaterialApp refers the material app or flutter app
  }
}
