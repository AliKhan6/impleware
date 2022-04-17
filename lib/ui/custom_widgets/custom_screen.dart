import 'package:flutter/material.dart';

import '../../core/others/screen_utils.dart';
import 'custom_app_bar.dart';

class CustomScreen extends StatelessWidget {
  final Widget? body;
  final String? title;
  const CustomScreen({Key? key, this.body, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            SizedBox(height: 70.h),
            customAppBar('$title'),
            SizedBox(height: 30.h),
            Expanded(child: body ?? Container())
          ],
        ),
      ),
    );
  }
}
