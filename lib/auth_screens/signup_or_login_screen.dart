import 'package:crowd_funding/auth_screens/signup_screen.dart';
import 'package:crowd_funding/utils/size_config.dart';
import 'package:crowd_funding/widgets/textview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../widgets/button.dart';
import 'login_screen.dart';

class LoginorSignup_Screen extends StatefulWidget {
  const LoginorSignup_Screen({Key? key}) : super(key: key);

  @override
  State<LoginorSignup_Screen> createState() => _LoginorSignup_ScreenState();
}

class _LoginorSignup_ScreenState extends State<LoginorSignup_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextView(text: "Being Creative Projects to life",
              color: Colors.black,
              size: SizeConfig.textMultiplier*2,
            fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier*6,
            ),
            InkWell(
              onTap: (){
                Get.to(Signup_Screen());
              },
              child: Custom_Button(
                text: "Sign up with email",
              ),
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier*3,
            ),
            InkWell(
              onTap: (){
                Get.to(Login_Screen());
              },
              child: Custom_Button(
                text: "Log in with email",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
