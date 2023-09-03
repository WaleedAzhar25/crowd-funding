import 'package:crowd_funding/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/size_config.dart';
import '../../../../widgets/textview.dart';

class Change_Username extends StatefulWidget {
  const Change_Username({Key? key}) : super(key: key);

  @override
  State<Change_Username> createState() => _Change_UsernameState();
}

class _Change_UsernameState extends State<Change_Username> {
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
            TextView(text: "Change Username",
              size: SizeConfig.textMultiplier*2.5,
              color: Colors.black,
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: SizeConfig.heightMultiplier*2,),
          SizedBox(
            width: double.infinity,
            child: Card(
              elevation: 5,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(text: "Current Username :-",
                      size: SizeConfig.textMultiplier*2,
                      color: Colors.black,
                    ),
                    SizedBox(height: 5,),
                    TextView(text: "Abdul Rafay",
                      size: SizeConfig.textMultiplier*2.5,
                      color: Colors.black,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: SizeConfig.heightMultiplier*3,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextView(text: "Change Username",
              size: SizeConfig.textMultiplier*2,
              color: Colors.black,
              maxLines: 1,
            ),
          ),
          SizedBox(height: SizeConfig.heightMultiplier*1,),
          TextFormField(
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
            decoration:  InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade100,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 25),
              counterText: "",
              floatingLabelBehavior: FloatingLabelBehavior.never,
              // labelText: "Email Address",
              hintText: "Username",
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
            },
          ),
          SizedBox(height: SizeConfig.heightMultiplier*3,),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Custom_Button(text: "Confirm"),
          ),
        ],
      ),
    );
  }
}
