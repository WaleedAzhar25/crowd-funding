import 'package:crowd_funding/widgets/button.dart';
import 'package:crowd_funding/widgets/textview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utils/size_config.dart';
import 'create_project.dart';

class StartProject extends StatefulWidget {
  const StartProject({Key? key}) : super(key: key);

  @override
  State<StartProject> createState() => _StartProjectState();
}

class _StartProjectState extends State<StartProject> {
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
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            SizedBox(height: SizeConfig.heightMultiplier*5,),
            TextView(text: "Being your creative projects to life",
            size: SizeConfig.textMultiplier*3,
              color: Colors.black,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
            SizedBox(height: SizeConfig.heightMultiplier*5,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.pinkAccent
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                  child: TextView(text: "A project does\n more then raise\n money.\nIt builds community \n around your work",
                    size: SizeConfig.textMultiplier*3.5,
                    color: Colors.white,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(height: SizeConfig.heightMultiplier*5,),
            InkWell(
                onTap: (){
                  Get.to(const Create_Project());
                },
                child: Custom_Button(text: "Start a project")),
          ],
        ),
      ),
    );
  }
}
