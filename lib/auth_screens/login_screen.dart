import 'package:crowd_funding/utils/size_config.dart';
import 'package:crowd_funding/widgets/button.dart';
import 'package:crowd_funding/widgets/textview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../services/user_services.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _inputEmail = new TextEditingController();
  final TextEditingController _inputPassword = new TextEditingController();

  bool handle_password = true;

  void change_handle_password() {
    handle_password = handle_password == true ? false : true;
  }

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
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
              text: "Log in",
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
                hintStyle:const TextStyle(color: Colors.black) ,
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
              controller: _inputPassword,
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
                  onTap: ()async {
                    UserServices user = UserServices();

                    // user.SignIn(_inputEmail.text, _inputPassword.text, const WorkoutMapScreen(), _formKey, context);
                    if (_formKey.currentState!.validate()) {
                      await user.login(
                          _inputEmail.text, _inputPassword.text, context);
                    }
                  },
                  child: Custom_Button(text: "Log in")),
            )
          ],
        ),
      ),
    );
  }
}
