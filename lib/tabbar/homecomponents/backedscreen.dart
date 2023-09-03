import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/size_config.dart';
import '../../../widgets/button.dart';
import '../../../widgets/campaign_card.dart';
import '../../models/compaign_model.dart';
import 'pledge_campaign.dart';

class BackedScreen extends StatefulWidget {
  CampaignModel campaignModel;

   BackedScreen({Key? key,required this.campaignModel}) : super(key: key);

  @override
  State<BackedScreen> createState() => _BackedScreenState();
}

class _BackedScreenState extends State<BackedScreen> {
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
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Campaign_Card(
                    title: widget.campaignModel.campaignTitle.toUpperCase(),
                    percent: '${widget.campaignModel.collectedInvestment}',
                    backer: widget.campaignModel.backer.length.toString(),
                    days: widget.campaignModel.endDate,
                    image: widget.campaignModel.imageUrl,
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 5,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(  PedgedCampaign(
                        campaignModel: widget.campaignModel,
                      ));
                    },
                    child: const Custom_Button(
                      text: "Back this project",
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
