import 'package:crowd_funding/models/compaign_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utils/size_config.dart';
import '../../widgets/button.dart';
import '../../widgets/campaign_card.dart';
import '../../widgets/textview.dart';
import '../tabbar.dart';

class Submitted_Project extends StatefulWidget {

  CampaignModel campaignModel;

   Submitted_Project({Key? key,required this.campaignModel}) : super(key: key);

  @override
  State<Submitted_Project> createState() => _Submitted_ProjectState();
}

class _Submitted_ProjectState extends State<Submitted_Project> {
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
                child: const Icon(Icons.arrow_back,color: Colors.black,)),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
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
                    height: SizeConfig.heightMultiplier * 1,
                  ),
                  TextView(
                    text: "Saram Jameel",
                    size: SizeConfig.textMultiplier * 3,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  // Row(
                  //   children: [
                  //     TextView(
                  //       text: "0\$ \nPledge of dollars",
                  //       size: SizeConfig.textMultiplier *1.6,
                  //       color: Colors.black,
                  //     ),
                  //     Spacer(),
                  //     TextView(
                  //       text: "0\$ \nBackers",
                  //       size: SizeConfig.textMultiplier *1.6,
                  //       color: Colors.black,
                  //     ),
                  //     Spacer(),
                  //     TextView(
                  //       text: "0\$ \nSeconds to go",
                  //       size: SizeConfig.textMultiplier *1.6,
                  //       color: Colors.black,
                  //     ),
                  //     Spacer(),
                  //   ],
                  // ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  Campaign_Card(
                    title: widget.campaignModel.campaignTitle.toUpperCase(),
                    percent: '${widget.campaignModel.goalPrice} funded',
                    backer: widget.campaignModel.backer.length.toString(),
                    days: widget.campaignModel.endDate,
                    image: widget.campaignModel.imageUrl,
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 5,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to( Tabbar());
                    },
                    child: Custom_Button(
                      text: "Exit Preview",
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
