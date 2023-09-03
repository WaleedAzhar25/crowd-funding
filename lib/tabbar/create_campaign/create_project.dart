import 'dart:ffi';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crowd_funding/services/compaign_services.dart';
import 'package:intl/intl.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:crowd_funding/tabbar/create_campaign/submitted_project.dart';
import 'package:crowd_funding/utils/size_config.dart';
import 'package:crowd_funding/widgets/button.dart';
import 'package:crowd_funding/widgets/textview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/compaign_model.dart';

class Create_Project extends StatefulWidget {
  const Create_Project({Key? key}) : super(key: key);

  @override
  State<Create_Project> createState() => _Create_ProjectState();
}

class _Create_ProjectState extends State<Create_Project> {
  File? pickedImage;

   CampaignServices _campaignServices= CampaignServices();

  TextEditingController nameController = new TextEditingController();
  TextEditingController titleController = new TextEditingController();
  TextEditingController storyController = new TextEditingController();
  TextEditingController goalController = new TextEditingController();
  TextEditingController endDateController = new TextEditingController();
  // TextEditingController _inputMobileNumber = new TextEditingController();
  // TextEditingController _inputDOB = new TextEditingController();
  // TextEditingController _inputPassword = new TextEditingController();
  // TextEditingController _inputRePassword = new TextEditingController();

  var imageUrl='';

  Future<XFile?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        pickedImage = File(pickedFile.path);
      });
    return pickedFile;
  }}
  Future<void> uploadImageToFirebaseAndStoreInFirestore(File? image) async {
    if (image == null) return;
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    final firebase_storage.Reference storageRef =
    firebase_storage.FirebaseStorage.instance.ref().child('images').child('${fileName}.jpg');

    final uploadTask = storageRef.putFile(File(image.path));
    final taskSnapshot = await uploadTask.whenComplete(() {});

    final downloadUrl = await taskSnapshot.ref.getDownloadURL();

    imageUrl=downloadUrl;
    print('Image Url $imageUrl');
    setState(() {

    });

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
            SizedBox(width: SizeConfig.widthMultiplier*3,),
            TextView(text: "Start a Project",
            color: Colors.black,
              size: SizeConfig.textMultiplier*2.5,
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SizeConfig.heightMultiplier*3,),
              TextView(text: "Your Name",
              size: SizeConfig.textMultiplier*2,
                color: Colors.grey,
              ),
              SizedBox(height: SizeConfig.heightMultiplier*1,),
              TextFormField(
                style: TextStyle(color: Colors.grey),
                controller: nameController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 18,horizontal: 20),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: "Enter Name",
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
                  RegExp regex = new RegExp(r'^.{2,}$');
                  if (value!.isEmpty) {
                    return ("Email cannot be empty");
                  }
                  if (!regex.hasMatch(value)) {
                    return ("Enter Valid Email");
                  }
                },
                onSaved: (value) {
                },
              ),
              SizedBox(height: SizeConfig.heightMultiplier*2,),
              TextView(text: "Campaign title",
                size: SizeConfig.textMultiplier*2,
                color: Colors.grey,
              ),
              SizedBox(height: SizeConfig.heightMultiplier*1,),
              TextFormField(
                style: TextStyle(color: Colors.grey),
                controller: titleController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 18,horizontal: 20),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: "write you campaign title",
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
                  RegExp regex = new RegExp(r'^.{2,}$');
                  if (value!.isEmpty) {
                    return ("Email cannot be empty");
                  }
                  if (!regex.hasMatch(value)) {
                    return ("Enter Valid Email");
                  }
                },
                onSaved: (value) {
                },
              ),
              SizedBox(height: SizeConfig.heightMultiplier*2,),
              TextView(text: "Story",
                size: SizeConfig.textMultiplier*2,
                color: Colors.grey,
              ),
              SizedBox(height: SizeConfig.heightMultiplier*1,),
              TextFormField(
                style: TextStyle(color: Colors.grey),
                controller: storyController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical:12,horizontal: 20),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: "write your story",
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
                maxLines: 7,
                validator: (value) {
                  RegExp regex = new RegExp(r'^.{2,}$');
                  if (value!.isEmpty) {
                    return ("Email cannot be empty");
                  }
                  if (!regex.hasMatch(value)) {
                    return ("Enter Valid Email");
                  }
                },
                onSaved: (value) {
                },
              ),
              SizedBox(height: SizeConfig.heightMultiplier*2,),
              TextView(text: "Goal",
                size: SizeConfig.textMultiplier*2,
                color: Colors.grey,
              ),
              SizedBox(height: SizeConfig.heightMultiplier*1,),
              TextFormField(
                controller: goalController,
                style: TextStyle(color: Colors.grey),
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
                  RegExp regex = new RegExp(r'^.{2,}$');
                  if (value!.isEmpty) {
                    return ("Email cannot be empty");
                  }
                  if (!regex.hasMatch(value)) {
                    return ("Enter Valid Email");
                  }
                },
                onSaved: (value) {
                },
              ),
              SizedBox(height: SizeConfig.heightMultiplier*2,),
              TextView(text: "End Date",
                size: SizeConfig.textMultiplier*2,
                color: Colors.grey,
              ),
              SizedBox(height: SizeConfig.heightMultiplier*1,),
              TextFormField(
                style: TextStyle(color: Colors.grey),
                controller: endDateController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 18,horizontal: 20),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: "mm/dd/yy",
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
                  RegExp regex = new RegExp(r'^.{2,}$');
                  if (value!.isEmpty) {
                    return ("Email cannot be empty");
                  }
                  if (!regex.hasMatch(value)) {
                    return ("Enter Valid Email");
                  }
                },
                onSaved: (value) {
                },
              ),
              SizedBox(height: SizeConfig.heightMultiplier*2,),
              TextView(text: "Upload an Project Image",
                size: SizeConfig.textMultiplier*2,
                color: Colors.grey,
              ),
              SizedBox(height: SizeConfig.heightMultiplier*1,),
              InkWell(
                onTap: ()async{
                 await pickImage();
                },
                child: Container(
                  height: SizeConfig.heightMultiplier*20,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: pickedImage != null
                      ? Image.file(
                    pickedImage!,
                    fit: BoxFit.cover,
                  ): Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextView(text: "Upload an Image",
                        size: SizeConfig.textMultiplier*1.8,
                          color: Colors.black,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier*1,),
                        TextView(text: "It must be a JPG,PNG, no larger then 200 MB",
                          size: SizeConfig.textMultiplier*1.5,
                          color: Colors.grey,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.heightMultiplier*5,),
              InkWell(
                  onTap: ()async{
                    DateTime now = DateTime.now();
                    String formattedDate = DateFormat.yMd().format(now);
                    await uploadImageToFirebaseAndStoreInFirestore(pickedImage );
                     _campaignServices.uploadCampaigns(
                        CampaignModel(
                            name:nameController.text,
                            campaignTitle: titleController.text,
                            story: storyController.text,
                            startDate: now,
                            goalPrice: double.parse(goalController.text),
                            endDate: endDateController.text,
                            imageUrl: imageUrl,
                          backer: [],
                          collectedInvestment: 0,
                          endStamp:endDateController.text.substring(3,5),
                          
                        )
                    );
                    Get.to(Submitted_Project(
                      campaignModel:  CampaignModel(
                            name:nameController.text,
                            campaignTitle: titleController.text,
                            imageUrl: imageUrl,
                            startDate: now,
                            story: storyController.text,
                            goalPrice: double.parse(goalController.text),
                            endDate: endDateController.text,
                        backer: [],
                          collectedInvestment: 0,
                        endStamp: endDateController.text.substring(3,4),
                        ),
                    ));
                  },
                  child: const Custom_Button(

                    text: "Submit New Campaign",)),
              SizedBox(height: SizeConfig.heightMultiplier*5,),
            ],
          ),
        ),
      ),
    );
  }
}


