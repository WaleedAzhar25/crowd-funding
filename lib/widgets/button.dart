import 'package:crowd_funding/widgets/textview.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/size_config.dart';

class Custom_Button extends StatelessWidget {
  final String text;
  const Custom_Button({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.heightMultiplier*8,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: AppColors.primarycolor,
      ),
      child: Center(
        child: TextView(
          text: text,
          color: Colors.white,
          size: SizeConfig.textMultiplier*2.2,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
