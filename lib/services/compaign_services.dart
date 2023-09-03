import 'dart:async';
import 'package:crowd_funding/tabbar/tabbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/compaign_model.dart';
import '../models/usermodel.dart';

class CampaignServices {

  final _auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  void uploadCampaigns(CampaignModel campaignModel)async{
    print('Upload');

    FirebaseFirestore firebaseFirestore =await FirebaseFirestore.instance;

   await firebaseFirestore.collection('yourCampaigns').doc(
        _auth.currentUser!.email.toString()).collection('campaigns').doc().set({
      "campaignTitle": campaignModel.campaignTitle,
      "story": campaignModel.story,
      "imageUrl": campaignModel.imageUrl,
     "startDate":campaignModel.startDate,
      "endDate": campaignModel.endDate,
      "goalPrice": campaignModel.goalPrice,
      "backer": campaignModel.backer,
      "name": campaignModel.name,
      "collectedInvestment": campaignModel.collectedInvestment,
      "endStamp": campaignModel.endStamp,
    }
    );

    await firebaseFirestore.collection('allCampaigns').doc().set({
      "campaignTitle": campaignModel.campaignTitle,
      "story": campaignModel.story,
      "imageUrl": campaignModel.imageUrl,
      "startDate":campaignModel.startDate,
      "backer":campaignModel.backer,
      "endDate": campaignModel.endDate,
      "goalPrice": campaignModel.goalPrice,
      "endStamp": campaignModel.endStamp,
      "name": campaignModel.name,
      "collectedInvestment": campaignModel.collectedInvestment,

    }
    );

  }


  Future getCampaign() async {
    QuerySnapshot? details;
     details = await firebaseFirestore
        .collection("yourCampaigns")
        .doc(_auth.currentUser!.email).collection('campaigns').get();
    print(details.docs.length);
    return details.docs;
  }




}
