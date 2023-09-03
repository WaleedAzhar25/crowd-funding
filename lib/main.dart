import 'package:crowd_funding/tabbar/tabbar.dart';
import 'package:crowd_funding/utils/size_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'auth_screens/signup_or_login_screen.dart';

Future<void> _firebadeMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(); // options: DefaultFirebaseConfig.platformOptions
  print('Handling a background message ${message.messageId}');
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   Stripe.publishableKey='pk_test_51NHjOaIhxExuXZ5G5Hws4Ci7QtUPFsK0Ffa1eqZzhlVbyYsWPE8PxBo0Bam2HolXvlGl2YD4MXaUOB4H7HbrIXM10067JG5V1f';
  FirebaseMessaging.onBackgroundMessage(_firebadeMessagingBackgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return GetMaterialApp(
              useInheritedMediaQuery: true,
              theme: ThemeData(
                  scaffoldBackgroundColor: Color(0xffF3F5F6),
                  fontFamily: 'Roboto'
              ),
              debugShowCheckedModeBanner: false,
              home:  LoginorSignup_Screen(),
            );
          },
        );
      },
    );
  }
}


