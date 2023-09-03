import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crowd_funding/utils/size_config.dart';
import 'package:crowd_funding/widgets/button.dart';
import 'package:crowd_funding/widgets/textview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';



import '../../models/compaign_model.dart';
import '../tabbar.dart';


class PedgedCampaign extends StatefulWidget {
  CampaignModel campaignModel;

   PedgedCampaign({Key? key,required this.campaignModel}) : super(key: key);

  @override
  State<PedgedCampaign> createState() => _PedgedCampaignState();
}

class _PedgedCampaignState extends State<PedgedCampaign> {

  Map<String, dynamic>? paymentIntentData;

  Future<String?> getPostIdByTitle(String postTitle) async {
    final postQuerySnapshot = await FirebaseFirestore.instance
        .collection('allCampaigns')
        .where('campaignTitle', isEqualTo: postTitle)
        .get();

    if (postQuerySnapshot.docs.isNotEmpty) {
      final postDocument = postQuerySnapshot.docs.first;
      return postDocument.id;
    }

    return null;
  }

  Future<void> likePost(String postId, String userId) async {
    final postRef = FirebaseFirestore.instance.collection('allCampaigns').doc(postId);
    final postSnapshot = await postRef.get();

    if (postSnapshot.exists) {
      final postLikes = List<String>.from(postSnapshot.data()!['backer'] ?? []);
      if (postLikes.contains(userId)) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:Text('Already Backed') ));
      }
      else{
        postLikes.add(userId);

        await postRef.update({'backer': postLikes});

      }

    }
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
            InkWell(
                onTap: (){
                  Get.back();
                },
                child: const Icon(Icons.arrow_back,color: Colors.black,)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: SizeConfig.heightMultiplier*25,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: Colors.grey.shade300
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 10),
                child: Column(
                  children: [
                    TextView(text: "Pledged without Investment",
                    size: SizeConfig.textMultiplier*3,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier*2,
                    ),
                    TextView(text: "Back it because you believe in it",
                      size: SizeConfig.textMultiplier*2,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier*2,
                    ),
                    InkWell(
                        onTap: ()async{

                          final postTitle = widget.campaignModel.campaignTitle;
                         final userId= FirebaseAuth.instance.currentUser!.uid;
                          final postId = await getPostIdByTitle(postTitle);
                          if (postId != null) {
                            likePost(postId, userId);
                          } else {
                            print('Post not found.');
                          }


                          Get.to(const Tabbar());
                        },
                        child: const Custom_Button(text: "Select")),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier*5,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: SizeConfig.heightMultiplier*35,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: Colors.grey.shade300
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 10),
                child: Column(
                  children: [
                    TextView(text: "Pledged with Investment",
                    size: SizeConfig.textMultiplier*3,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier*2,
                    ),
                    TextView(text: "Back it because you believe in it",
                      size: SizeConfig.textMultiplier*2,
                      color: Colors.black,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: TextView(text: "Goal",
                        size: SizeConfig.textMultiplier*2,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier*1,),
                    TextFormField(
                      style: const TextStyle(color: Colors.grey),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 18,horizontal: 20),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: "100.0\$",
                        labelStyle: TextStyle(color: Colors.grey),
                        // border:OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(30),
                        // ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      maxLines: 1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Price cannot be empty");
                        }
                        return null;
                      },
                      onSaved: (value) {
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier*2,
                    ),
                    InkWell(
                        onTap: ()async{
                          await makePayment();

                          // Get.to(const Tabbar());
                        },
                        child: const Custom_Button(text: "Select")),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> makePayment() async {
    try {
      paymentIntentData =
      await createPaymentIntent('20', 'USD'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await Stripe.instance
          .initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              setupIntentClientSecret: 'sk_test_51NHjOaIhxExuXZ5GsHsSm5xZMq4FsBOdZ346vbDp2uj2gNqZL3xGSy0tlIcp9zUNncK525OdgTjzuXM3ntzrcc9S003z0RKcjI',
              paymentIntentClientSecret:
              paymentIntentData!['client_secret'],
              //applePay: PaymentSheetApplePay.,
              //googlePay: true,
              //testEnv: true,
              customFlow: true,
              style: ThemeMode.dark,
              // merchantCountryCode: 'US',
              merchantDisplayName: 'Kashif'))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('Payment exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance
          .presentPaymentSheet(
        //       parameters: PresentPaymentSheetParameters(
        // clientSecret: paymentIntentData!['client_secret'],
        // confirmPayment: true,
        // )
      )
          .then((newValue) {
        print('payment intent' + paymentIntentData!['id'].toString());
        print(
            'payment intent' + paymentIntentData!['client_secret'].toString());
        print('payment intent' + paymentIntentData!['amount'].toString());
        print('payment intent' + paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("paid successfully")));

        paymentIntentData = null;
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
            content: Text("Cancelled "),
          ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount('20'),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer sk_test_51NHjOaIhxExuXZ5GsHsSm5xZMq4FsBOdZ346vbDp2uj2gNqZL3xGSy0tlIcp9zUNncK525OdgTjzuXM3ntzrcc9S003z0RKcjI',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}


