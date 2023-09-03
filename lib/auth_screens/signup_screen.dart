import 'package:crowd_funding/utils/constants.dart';
import 'package:crowd_funding/utils/size_config.dart';
import 'package:crowd_funding/widgets/button.dart';
import 'package:crowd_funding/widgets/textview.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../services/user_services.dart';
import 'login_screen.dart';

class Signup_Screen extends StatefulWidget {
  const Signup_Screen({Key? key}) : super(key: key);

  @override
  State<Signup_Screen> createState() => _Signup_ScreenState();
}

class _Signup_ScreenState extends State<Signup_Screen> {
  final _formKey = GlobalKey<FormState>();

  UserServices userReg = UserServices();
  var choose = 'Run';
  int sel=0;

  TextEditingController _inputname = new TextEditingController();
  TextEditingController _inputEmail = new TextEditingController();
  TextEditingController _inputPassword = new TextEditingController();

  bool handle_password = true;

  void change_handle_password() {
    handle_password = handle_password == true ? false : true;
  }

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
            IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.arrow_back),color: Colors.black,),
            TextView(
              text: "Sign up",
              size: SizeConfig.textMultiplier*2,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: SizeConfig.heightMultiplier*4,),
            TextFormField(
              controller: _inputname,
              cursorColor: Colors.black,
              style: TextStyle(color: Colors.black),
              decoration:  InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade400,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 25),
                counterText: "",
                floatingLabelBehavior: FloatingLabelBehavior.never,
                // labelText: "Email Address",
                hintText: "Name",
                hintStyle:TextStyle(color: Colors.black) ,
                labelStyle: TextStyle(color: Colors.black),
                // border:OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(30),
                // ),
              ),
              keyboardType: TextInputType.emailAddress,
              //obsecureText: true or false for password visibility
              maxLength: 60,
              maxLines: 1,
              validator: (value) {
                RegExp regex = new RegExp(r'^.{2,}$');
                if (value!.isEmpty) {
                  return ("Email cannot be empty");
                }
                if (!regex.hasMatch(value)) {
                  return ("Enter Valid Email");
                }
              },
              onSaved: (value) {
                _inputname.text = value!;
              },
            ),
            SizedBox(height: SizeConfig.heightMultiplier*2,),
            TextFormField(
              controller: _inputEmail,
              cursorColor: Colors.black,
              style: TextStyle(color: Colors.black),
              decoration:  InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade400,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 25),
                counterText: "",
                floatingLabelBehavior: FloatingLabelBehavior.never,
                // labelText: "Email Address",
                hintText: "Email Address",
                hintStyle:TextStyle(color: Colors.black) ,
                labelStyle: TextStyle(color: Colors.black),
                // border:OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(30),
                // ),
              ),
              keyboardType: TextInputType.emailAddress,
              //obsecureText: true or false for password visibility
              maxLength: 60,
              maxLines: 1,
              validator: (value) {
                RegExp regex = new RegExp(r'^.{2,}$');
                if (value!.isEmpty) {
                  return ("Email cannot be empty");
                }
                if (!regex.hasMatch(value)) {
                  return ("Enter Valid Email");
                }
              },
              onSaved: (value) {
                _inputEmail.text = value!;
              },
            ),
            SizedBox(height: SizeConfig.heightMultiplier*2,),
            TextFormField(
              cursorColor: Colors.black,
              style: TextStyle(color: Colors.black),
              decoration:  InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.warning,
                    color: AppColors.primarycolor,
                  ),
                  onPressed: () {
                    setState(() {
                      change_handle_password();
                    });
                  },
                ),
                filled: true,
                fillColor: Colors.grey.shade400,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 25),
                counterText: "",
                floatingLabelBehavior: FloatingLabelBehavior.never,
                // labelText: "Email Address",
                hintText: "Password",
                hintStyle:TextStyle(color: Colors.black) ,
                labelStyle: TextStyle(color: Colors.black),
                // border:OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(30),
                // ),
              ),
              keyboardType: TextInputType.emailAddress,
              //obsecureText: true or false for password visibility
              maxLength: 60,
              obscureText: handle_password,
              controller: _inputPassword,
              maxLines: 1,
              validator: (value) {
                RegExp regex = new RegExp(r'^.{2,}$');
                if (value!.isEmpty) {
                  return ("password cannot be empty");
                }
                if (!regex.hasMatch(value)) {
                  return ("Enter Valid password");
                }
              },
              onSaved: (value) {
                _inputPassword.text = value!;
              },
            ),
            SizedBox(height: SizeConfig.heightMultiplier*4,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:20.0),
              child: InkWell(
                  onTap: () {
                    userReg.Registration(
                      _inputEmail.text,
                      _inputPassword.text,
                      _formKey,
                      Login_Screen(),
                      context,
                      _inputname.text,
                    );
                  },
                  child: Custom_Button(text: "Sign up")),
            )
          ],
        ),
      ),
    );
  }
}
