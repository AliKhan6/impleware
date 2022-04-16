import 'package:calkitna_mobile_app/core/constants/colors.dart';
import 'package:calkitna_mobile_app/core/constants/style.dart';
import 'package:calkitna_mobile_app/ui/custom_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllergiesScreen extends StatelessWidget {
  const AllergiesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 70.h),
            customAppBar('Add Allergies'),
            SizedBox(height: 40.h),
            Row(
              children: [
                Theme(
                  data: ThemeData(unselectedWidgetColor: primaryColor),
                  child: Radio(
                      activeColor: primaryColor,
                      focusColor: primaryColor,
                      value: 1,
                      groupValue: 1,
                      onChanged: (value) {}),
                ),
                SizedBox(width: 8.w),
                Text('Drug Allergy', style: bodyTextStyleAssistant)
              ],
            )
          ],
        ),
      ),
    );
  }
}
