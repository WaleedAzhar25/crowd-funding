import 'package:crowd_funding/utils/size_config.dart';
import 'package:crowd_funding/widgets/textview.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class BackedCard extends StatefulWidget {
  final String title;
  final String image;
   BackedCard({Key? key, required this.title,  required this.image}) : super(key: key);

  @override
  State<BackedCard> createState() => _BackedCardState();
}

class _BackedCardState extends State<BackedCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey,),
      ),
      child: Column(
        children: [
          Image.network(widget.image,fit: BoxFit.fill,height: SizeConfig.heightMultiplier*14,width: double.infinity,),
          SizedBox(height: SizeConfig.heightMultiplier*2,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:  16.0),
            child: TextView(text: widget.title,
                color: Colors.black,
            size: SizeConfig.textMultiplier*2,
              textAlign: TextAlign.start,
              maxLines: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(thickness: 2,color: AppColors.primarycolor,),
          )
        ],
      ),
    );
  }
}
