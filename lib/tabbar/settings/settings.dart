import 'package:crowd_funding/auth_screens/login_screen.dart';
import 'package:crowd_funding/utils/size_config.dart';
import 'package:crowd_funding/widgets/textview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../auth_screens/signup_or_login_screen.dart';
import 'account/account.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            InkWell(
                onTap: (){
                  Get.back();
                },
                child: Icon(Icons.arrow_back,color: Colors.black,)),
            SizedBox(width: SizeConfig.widthMultiplier*7,),
            TextView(text: "Settings",
              size: SizeConfig.textMultiplier*2.5,
              color: Colors.black,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: SizeConfig.heightMultiplier*3,),
          Card(
            elevation: 5,
            child: ListTile(
              tileColor: Color(0xff0F6F6F6),
              title:  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextView(text:'Account',
                  size: SizeConfig.textMultiplier*2.5,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Get.to(AccountScreen());
              },
            ),
          ),
          SizedBox(height: SizeConfig.heightMultiplier*2,),
          Card(
            elevation: 5,
            child: ListTile(
              tileColor: Color(0xff0F6F6F6),
              title:  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextView(text:'Help',
                  size: SizeConfig.textMultiplier*2.5,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Get.to(Settings());
              },
            ),
          ),
          SizedBox(height: SizeConfig.heightMultiplier*2,),
          Card(
            elevation: 5,
            child: ListTile(
              tileColor: Color(0xff0F6F6F6),
              title:  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextView(text:'Logout',
                  size: SizeConfig.textMultiplier*2.5,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Get.offAll(()=>LoginorSignup_Screen());
              },
            ),
          ),
        ],
      ),
    );
  }
}
