import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/size_config.dart';
import '../../../widgets/textview.dart';
import 'components/change_password.dart';
import 'components/change_username.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
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
            TextView(text: "Account",
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
                child: TextView(text:'Change username',
                  size: SizeConfig.textMultiplier*2.5,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Get.to(Change_Username());
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
                child: TextView(text:'Change password',
                  size: SizeConfig.textMultiplier*2.5,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Get.to(ChangePassword());
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
                child: TextView(text:'Payment methods',
                  size: SizeConfig.textMultiplier*2.5,
                  color: Colors.black,
                ),
              ),
              onTap: () {

              },
            ),
          ),
        ],
      ),
    );
  }
}
