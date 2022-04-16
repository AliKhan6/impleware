import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../core/constants/style.dart';

Widget customAppBar(String title) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back)),
      Text(
        title,
        style: bodyTextStyleRoboto.copyWith(fontSize: 20.sp),
      ),
      IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications, color: Colors.transparent))
    ],
  );
}
