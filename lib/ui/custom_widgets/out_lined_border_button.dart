import 'package:calkitna_mobile_app/core/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OutLinedBorderButton extends StatelessWidget {
  final onTap;
  final Color? color;
  final String? text;
  const OutLinedBorderButton({Key? key, this.onTap, this.color, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 37.h,
          width: 93.w,
          child: Center(
              child: Text('$text',
                  style: bodyTextStyleAssistant.copyWith(
                      fontSize: 15.sp,
                      color: color))),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: color!, width: 1.0))),
    );
  }
}
