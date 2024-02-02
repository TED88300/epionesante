import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'Tools/gColors.dart';
import 'Widget/0-splashScreen.dart';

Future<void> _firebadeMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(); // options: DefaultFirebaseConfig.platformOptions
  print('Handling a background message ${message.messageId}');
}

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();

  Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebadeMessagingBackgroundHandler);

//  DbTools.gTED = kDebugMode;



  Widget _defaultHome = new SplashScreen();

  runApp(
          MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'App',
    theme: ThemeData(
      primarySwatch: MaterialColor(
        gColors.primary.value,
        gColors.getSwatch(gColors.primary),
      ),
    ),
    home: _defaultHome,
            localizationsDelegates: [
              GlobalCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('fr')
            ],
  )



  );
}
