import 'package:flutter/cupertino.dart';

class TextView extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final TextDecoration? line;
  final double? size;
  final String? fontFamily;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final TextAlign? textAlign;

  const TextView(
      {Key? key,
        this.color,
        this.fontWeight,
        required this.text,
        this.size,
        this.line,
        this.fontFamily,
        this.maxLines,
        this.textOverflow,
        this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        maxLines: maxLines,
        overflow: textOverflow,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: size,
          fontWeight: fontWeight,
          color: color,
          decoration: line,
          fontFamily: fontFamily,
        ));
  }
}




