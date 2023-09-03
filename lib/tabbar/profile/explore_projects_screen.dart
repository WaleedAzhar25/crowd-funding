import 'package:crowd_funding/services/user_services.dart';
import 'package:crowd_funding/widgets/textview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../models/usermodel.dart';
import '../../utils/size_config.dart';
import '../../widgets/button.dart';
import 'backed_projects_screen.dart';

class Explore_Projects_Screen extends StatefulWidget {
  const Explore_Projects_Screen({Key? key}) : super(key: key);

  @override
  State<Explore_Projects_Screen> createState() =>
      _Explore_Projects_ScreenState();
}

class _Explore_Projects_ScreenState extends State<Explore_Projects_Screen> {
  UserServices _userServices =UserServices();
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
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
            Spacer(),
            Icon(
              Icons.message,
              color: Colors.black,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: SizeConfig.imageSizeMultiplier * 20,
                width: SizeConfig.imageSizeMultiplier * 20,
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Container(
                    height: SizeConfig.imageSizeMultiplier * 15,
                    width: SizeConfig.imageSizeMultiplier * 15,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        "images/profile.png",
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 3,
              ),
              StreamBuilder<UserModel?>(
                  stream: _userServices.currentDetailsStream(),
                  builder: (context,snapshot) {
                    print(snapshot.data!.name);

                    if(snapshot.hasError){
                      return Text('Loading...');
                    }
                    return TextView(text: snapshot.data!.name.toString(),
                      size: SizeConfig.textMultiplier*2,
                      color: Colors.black,

                    );
                  }
              ),

              SizedBox(
                height: SizeConfig.heightMultiplier * 10,
              ),
              TextView(
                text: "No Backed Projects Yet",
                size: SizeConfig.textMultiplier * 2,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 3,
              ),
              TextView(
                text: "You have not backed any projects yet.Lets change that!",
                size: SizeConfig.textMultiplier * 2,
                color: Colors.black,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 3,
              ),
              InkWell(
                onTap: () {
                  Get.to(Backed_Projects());
                },
                child: Custom_Button(
                  text: "Your Campaigns",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
