import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crowd_funding/services/compaign_services.dart';
import 'package:crowd_funding/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/usermodel.dart';
import '../../utils/size_config.dart';
import '../../widgets/backed_card.dart';
import '../../widgets/textview.dart';

class Backed_Projects extends StatefulWidget {
  const Backed_Projects({Key? key}) : super(key: key);

  @override
  State<Backed_Projects> createState() => _Backed_ProjectsState();
}

class _Backed_ProjectsState extends State<Backed_Projects> {

  UserServices _userServices =UserServices();
  CampaignServices _campaignServices =CampaignServices();
  int campaignLength=3;

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
            Spacer(),
            Icon(Icons.message,color: Colors.black,),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:15.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                StreamBuilder<UserModel>(
                    stream: _userServices.currentDetailsStream(),
                    builder: (context,snapshot) {
                      if(snapshot.hasError){
                        return Text('Loading...');
                      }
                      if(snapshot.hasError){
                        return Text('Loading...');
                      }
                      return TextView(text: snapshot.data!.name.toString(),
                        size: SizeConfig.textMultiplier*2,
                        color: Colors.black,

                      );
                    }
                ),
                SizedBox(height: SizeConfig.heightMultiplier*2,),
                TextView(text: "$campaignLength Campaigns",
                  size: SizeConfig.textMultiplier*2,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: SizeConfig.heightMultiplier*3,),
                FutureBuilder(
                  future: _campaignServices.getCampaign(),
                  builder: (_,AsyncSnapshot snapShot) {
                    campaignLength=snapShot.data?.length;
                    print('ASyncSNap');
                    if(snapShot.hasError){
                      return Text('Loading...');
                    }
                    if(snapShot.hasError){
                      return Text('Loading...');
                    }
                    print(snapShot.data!.length);

                    return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapShot.data!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: SizeConfig.heightMultiplier * 25,
                            crossAxisCount: 2,
                            mainAxisSpacing: SizeConfig.heightMultiplier * 2,
                          crossAxisSpacing:SizeConfig.heightMultiplier * 2,
                        ),
                        itemBuilder: (BuildContext context, int i){
                          return BackedCard(
                            image: snapShot.data![i]['imageUrl'],
                            title: snapShot.data![i]['campaignTitle'].toUpperCase(),
                          );
                        }

                    );
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
