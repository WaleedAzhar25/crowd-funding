import 'package:carousel_slider/carousel_slider.dart';
import 'package:crowd_funding/models/usermodel.dart';
import 'package:crowd_funding/services/user_services.dart';
import 'package:crowd_funding/tabbar/profile/explore_projects_screen.dart';
import 'package:crowd_funding/tabbar/settings/settings.dart';
import 'package:crowd_funding/utils/size_config.dart';
import 'package:crowd_funding/widgets/textview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../utils/constants.dart';
import '../widgets/button.dart';
import '../widgets/campaign_card.dart';
import 'components/ending_screen.dart';
import 'components/home_page.dart';
import 'components/newest_screen.dart';
import 'components/popular_screen.dart';
import 'create_campaign/start_project.dart';

class Tabbar extends StatefulWidget {
  const Tabbar({Key? key}) : super(key: key);

  @override
  State<Tabbar> createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> {

  UserServices _userServices=UserServices();

  TabBar get _tabBar => TabBar(
    labelColor: AppColors.primarycolor,
    unselectedLabelColor: Colors.grey,
    indicatorColor:AppColors.primarycolor ,
    tabs: [
      Tab(text:"Home",),
      Tab(text:"POPULAR"),
      Tab(text:"NEWEST"),
      Tab(text:"ENDING"),
    ],
  );
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          title: Row(
            children: [
              TextView(
                text: 'All Projects',
                color: Colors.black,
                size: SizeConfig.textMultiplier*2,
              ),
              const Spacer(),
              Icon(Icons.search_rounded,color: Colors.black,size: SizeConfig.imageSizeMultiplier*10,),
            ],
          ),
         bottom: PreferredSize(
           preferredSize: _tabBar.preferredSize,
           child: Material(
             color: Colors.white,//<-- SEE HERE
             child: _tabBar,
           ),
         ),
        ),
        drawer: Drawer(
                  child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
               DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: SizeConfig.imageSizeMultiplier*20,
                        width: SizeConfig.imageSizeMultiplier*20,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Container(
                            height: SizeConfig.imageSizeMultiplier*15,
                            width: SizeConfig.imageSizeMultiplier*15,
                            child: CircleAvatar(
                              backgroundImage: AssetImage("images/profile.png",),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier*3,),
                      // StreamBuilder<UserModel?>(
                      //   stream: _userServices.currentDetailsStream(),
                      //   builder: (context,AsyncSnapshot snapshot) {
                      //     print(snapshot.data);
                      //
                      //     if(snapshot.hasError){
                      //       return Text('Loading...');
                      //     }
                      //     return TextView(text: snapshot.data!.name.toString(),
                      //     size: SizeConfig.textMultiplier*2,
                      //       color: Colors.black,
                      //
                      //     );
                      //   }
                      // )
                    ],
                  ),
                ),
              ),
              ListTile(
                title:  TextView(text:'Profile',
                  size: SizeConfig.textMultiplier*2,
                  color: Colors.black,
                ),
                horizontalTitleGap: 0,
                leading: Icon(Icons.person_pin),
                onTap: () {
                  Get.to(Explore_Projects_Screen());
                },
              ),
              ListTile(

          title:  TextView(text:'Messages',
            size: SizeConfig.textMultiplier*2,
            color: Colors.black,
          ),
          horizontalTitleGap: 0,
          leading: Icon(Icons.message),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.pop(context);
          },
        ),
              ListTile(
          title:  TextView(text:'Settings',
            size: SizeConfig.textMultiplier*2,
            color: Colors.black,
          ),
          horizontalTitleGap: 0,
          leading: Icon(Icons.settings),
          onTap: () {
            Get.to(Settings());
          },
        ),
              ListTile(
          title:  TextView(text:'Create a Campaign',
            size: SizeConfig.textMultiplier*2,
            color: Colors.black,
          ),
          horizontalTitleGap: 0,
          leading: Icon(Icons.speed),
          onTap: () {
           Get.to(StartProject());
          },
        ),
            ],
          ),
        ),
        body:TabBarView(
          children: <Widget>[
            HomePage(),
            Popular_Screen(),
            Newest_Screen(),
            Ending_Screen(),
          ],
        ),
      ),
    );
  }
}
