import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style/style.dart';

class LiquidLoading extends StatelessWidget {
  final String text;
  LiquidLoading({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: TextLiquidFill(
          text: text,
          waveColor: Style.primaryColor,
          boxBackgroundColor: Colors.grey,
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          boxHeight: 100),
    );
  }
}
