import 'package:crowd_funding/utils/constants.dart';
import 'package:crowd_funding/utils/size_config.dart';
import 'package:crowd_funding/widgets/textview.dart';
import 'package:flutter/material.dart';

class Campaign_Card extends StatefulWidget {
  final String title;
  final String percent;
  final String backer;
  final String days;
  final String image;
  const
  Campaign_Card({Key? key,
    required this.title,
    required this.percent,
    required this.backer,
    required this.days,
    required this.image}) : super(key: key);

  @override
  State<Campaign_Card> createState() => _Campaign_CardState();
}

class _Campaign_CardState extends State<Campaign_Card> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: SizeConfig.heightMultiplier*53,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black,width: 1),
        color: Colors.white,
      ),
      child:Column(
        children: [
          Container(
            height: SizeConfig.heightMultiplier*25,
            width: double.infinity,
            child: Image.network(widget.image,fit: BoxFit.cover,),
          ),
          SizedBox(
            height: SizeConfig.heightMultiplier*2,
          ),
          Container(
            height: SizeConfig.heightMultiplier*15,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  TextView(
                    text: widget.title.toUpperCase(),
                    maxLines: 4,
                    textOverflow: TextOverflow.ellipsis,
                    color: Colors.black,
                    size: SizeConfig.textMultiplier*1.5,
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier*1,),
                  Divider(
                    thickness: 3,
                    color: AppColors.primarycolor,
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier*2,),
                  Row(
                    children: [
                      Container(
                        width: SizeConfig.widthMultiplier*20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextView(
                              text: widget.percent,
                              maxLines: 4,
                              textOverflow: TextOverflow.ellipsis,
                              color: Colors.black,
                              size: SizeConfig.textMultiplier*1.6,
                            ),
                            SizedBox(height: 5,),
                            TextView(
                              text: 'Funded',
                              maxLines: 4,
                              textOverflow: TextOverflow.ellipsis,
                              color: Colors.black,
                              size: SizeConfig.textMultiplier*1.6,
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: SizeConfig.widthMultiplier*20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextView(
                              text: widget.backer,
                              maxLines: 4,
                              textOverflow: TextOverflow.ellipsis,
                              color: Colors.black,
                              size: SizeConfig.textMultiplier*1.7,
                            ),
                            SizedBox(height: 5,),

                            TextView(
                              text: 'Backers',
                              maxLines: 4,
                              textOverflow: TextOverflow.ellipsis,
                              color: Colors.black,
                              size: SizeConfig.textMultiplier*1.7,
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: SizeConfig.widthMultiplier*20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextView(
                              text:widget.days,
                              maxLines: 4,
                              textOverflow: TextOverflow.ellipsis,
                              color: Colors.black,
                              size: SizeConfig.textMultiplier*1.6,
                            ),
                            SizedBox(height: 5,),

                            TextView(
                              text:'End Date',
                              maxLines: 4,
                              textOverflow: TextOverflow.ellipsis,
                              color: Colors.black,
                              size: SizeConfig.textMultiplier*1.6,
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     Icon(Icons.games_outlined,size: SizeConfig.imageSizeMultiplier*8,),
                  //     SizedBox(width: SizeConfig.widthMultiplier*2,),
                  //     TextView(text: "Video Games",
                  //     color: Colors.black,
                  //       size: SizeConfig.textMultiplier*2,
                  //     ),
                  //     Spacer(),
                  //     TextView(text: "Projects We Love",
                  //       color: Colors.black,
                  //       size: SizeConfig.textMultiplier*2,
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
