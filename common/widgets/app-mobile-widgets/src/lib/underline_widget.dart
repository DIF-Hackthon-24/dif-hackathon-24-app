

import 'package:flutter/material.dart';

class TextWithUnderline extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Color? underlineColor;
  final double? spaceBetweenTextAndUnderline;
  final double? widthOfTheUnderline;

  TextWithUnderline({Key? key,
  required this.text,
  this.style,
  this.underlineColor,
  this.spaceBetweenTextAndUnderline,
  this.widthOfTheUnderline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TextStyle with underline does not support arabic properly
    return Container(
         padding: EdgeInsets.only(
           bottom: spaceBetweenTextAndUnderline ?? 5, // Space between underline and text
         ),
         decoration: BoxDecoration(
             border: Border(bottom: BorderSide(
             color: underlineColor ?? Colors.black, 
             width: widthOfTheUnderline ?? 1.0, // Underline thickness
            )),
          ),
         child: Text(
            text,
            style: style ?? TextStyle(
            color: Colors.black,
            ),
           ),
          );
  }
}