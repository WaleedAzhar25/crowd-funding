import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crowd_funding/models/compaign_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/compaign_services.dart';
import '../../utils/size_config.dart';
import '../../widgets/button.dart';
import '../../widgets/campaign_card.dart';
import '../../widgets/textview.dart';
import '../homecomponents/backedscreen.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CampaignServices _campaignServices=CampaignServices();
  List<Widget> items=[
    Image.asset("images/caruselimages/c1.png" ,fit: BoxFit.fill,height: SizeConfig.heightMultiplier*35,width: double.infinity,),
    Image.asset("images/caruselimages/c2.png",fit: BoxFit.fill,height: SizeConfig.heightMultiplier*35,width: double.infinity,),
    Image.asset("images/caruselimages/c3.png",fit: BoxFit.fill,height: SizeConfig.heightMultiplier*35,width: double.infinity,),
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SizedBox(
          //   height: SizeConfig.heightMultiplier*5,
          // ),
          // Center(
          //   child: TextView(
          //     text: 'Being creative projects to life',
          //     color: Colors.black,
          //     size: SizeConfig.textMultiplier*2,
          //     fontWeight: FontWeight.w500,
          //   ),
          // ),
          // SizedBox(
          //   height: SizeConfig.heightMultiplier*4,
          // ),
          // Padding(
          //   padding:  EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier*10),
          //   child: const Custom_Button(
          //     text: "Sign up or Log in",
          //   ),
          // ),
          // SizedBox(
          //   height: SizeConfig.heightMultiplier*4,
          // ),
          CarouselSlider(
              items: items,
              options: CarouselOptions(
                // aspectRatio: 16/9,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
              )
          ),
          SizedBox(
            height: SizeConfig.heightMultiplier*4,
          ),

          // Expanded(
          //   child: StreamBuilder<QuerySnapshot>(
          //     stream: FirebaseFirestore.instance
          //         .collection('yourCampaigns')
          //         .snapshots(),
          //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //        getCount() async {
          //          var id =await FirebaseFirestore.instance
          //              .collection('yourCampaigns')
          //              .doc();
          //         int count = await FirebaseFirestore.instance
          //             .collection('yourCampaigns')
          //             .get()
          //             .then((value) => value.size);
          //         print(count);
          //         print(id.snapshots());
          //         return count;
          //       }
          //       print('yourCampaigns');
          //       print( getCount());
          //
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return CircularProgressIndicator(); // Loading indicator
          //       }
          //       if (snapshot.hasError) {
          //         return Text('Error: ${snapshot.error}');
          //       }
          //       if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          //         return Text('No parent documents available');
          //       }
          //
          //       // Process the snapshot and display the data
          //       final parentDocuments = snapshot.data!.docs;
          //
          //       return ListView.builder(
          //         itemCount: parentDocuments.length,
          //         itemBuilder: (BuildContext context, int parentIndex) {
          //           final parentDocument = parentDocuments[parentIndex];
          //
          //           return StreamBuilder<QuerySnapshot>(
          //             stream: parentDocument.reference.collection('campaigns').snapshots(),
          //             builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> subSnapshot) {
          //               if (subSnapshot.connectionState == ConnectionState.waiting) {
          //                 return CircularProgressIndicator(); // Loading indicator
          //               }
          //               if (subSnapshot.hasError) {
          //                 return Text('Error: ${subSnapshot.error}');
          //               }
          //               if (!subSnapshot.hasData || subSnapshot.data!.docs.isEmpty) {
          //                 return Text('No subcollection documents available');
          //               }
          //
          //               final subDocuments = subSnapshot.data!.docs;
          //               print('subDocuments');
          //               print(subDocuments.length);
          //
          //               return ListView.builder(
          //                 shrinkWrap: true,
          //                 physics: ClampingScrollPhysics(),
          //                 itemCount: subDocuments.length,
          //                 itemBuilder: (BuildContext context, int subIndex) {
          //                   final subDocument = subDocuments[subIndex];
          //                   final title = subDocument['name'] ?? 'No Title'; // Provide a default value if the field is missing
          //                   final subtitle = subDocument['endData'] ?? 'No Subtitle';
          //
          //                   return ListTile(
          //                     title: Text(title),
          //                     subtitle: Text(subtitle),
          //                     // Add any additional fields you want to display
          //                   );
          //                 },
          //               );
          //             },
          //           );
          //         },
          //       );
          //     },
          //   )
          // ),

          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('allCampaigns').snapshots(),
            builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading");
              }
              final documents = snapshot.data!.docs;

              print(documents.length);
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),

                itemBuilder: (BuildContext context, int index) {
                  print(snapshot.data!.docs[index]['imageUrl']);

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8),
                    child:  InkWell(
                      onTap: (){
                        Get.to(BackedScreen(
                          campaignModel:CampaignModel(
                              campaignTitle: snapshot.data!.docs[index]['campaignTitle'],
                              story:  snapshot.data!.docs[index]['story'].toString(),
                              backer:  snapshot.data!.docs[index]['backer'],
                              collectedInvestment: snapshot.data!.docs[index]['collectedInvestment'],
                              imageUrl:  snapshot.data!.docs[index]['imageUrl'].toString(),
                              endDate: snapshot.data!.docs[index]['endDate']
                          ),));
                      },
                      child: Campaign_Card(
                        title: snapshot.data!.docs[index]['campaignTitle'],
                        percent: snapshot.data!.docs[index]['collectedInvestment'].toString(),
                        backer: snapshot.data!.docs[index]['backer'].length.toString(),
                        days: snapshot.data!.docs[index]['endDate'],
                        image: snapshot.data!.docs[index]['imageUrl'].toString(),
                      ),
                    ),
                  );

                },

              );
            }
          ),
        ],
      ),
    );
  }
}
