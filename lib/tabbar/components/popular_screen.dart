import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crowd_funding/widgets/campaign_card.dart';
import 'package:flutter/material.dart';

class Popular_Screen extends StatefulWidget {
  const Popular_Screen({Key? key}) : super(key: key);

  @override
  State<Popular_Screen> createState() => _Popular_ScreenState();
}

class _Popular_ScreenState extends State<Popular_Screen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('allCampaigns').orderBy(
                  'backer',descending: true
                ).snapshots(),
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
                        child:  Campaign_Card(
                          title: snapshot.data!.docs[index]['campaignTitle'],
                          percent: snapshot.data!.docs[index]['collectedInvestment'].toString(),
                          backer: snapshot.data!.docs[index]['backer'].length.toString(),
                          days: snapshot.data!.docs[index]['endDate'],
                          image: snapshot.data!.docs[index]['imageUrl'].toString(),
                        ),
                      );

                    },

                  );
                }
            ),
          ],
        ),
      ),
    );
  }
}
