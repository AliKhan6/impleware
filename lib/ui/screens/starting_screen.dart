import 'package:calkitna_mobile_app/core/constants/colors.dart';
import 'package:calkitna_mobile_app/core/constants/strings.dart';
import 'package:calkitna_mobile_app/core/constants/style.dart';
import 'package:calkitna_mobile_app/ui/custom_widgets/custom_button.dart';
import 'package:calkitna_mobile_app/ui/screens/auth_screens/login/login_screen.dart';
import 'package:calkitna_mobile_app/ui/screens/auth_screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/others/screen_utils.dart';

class StartingScreen extends StatelessWidget {
  const StartingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                SizedBox(height: 70.h),
                CircleAvatar(
                  backgroundColor: primaryColor.withOpacity(0.2),
                  radius: 90.r,
                  backgroundImage: const AssetImage('$staticAsset/logo.png'),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(height: 50.h),
                Text('YOUR BEST HEALTH PARTNER',
                    style: headingTextStyleRoboto.copyWith(fontSize: 22.sp)),
                SizedBox(height: 30.h),
                Text('Set reminder and keep record of your medications',
                    style: bodyTextStyleRoboto),
                SizedBox(height: 60.h),
                Row(
                  children: [
                    Expanded(
                        child: CustomButton(
                            buttonColor: primaryColor,
                            text: 'Login',
                            textColor: Colors.black,
                            onTap: () {
                              Get.to(() => const LoginScreen());
                            })),
                    SizedBox(width: 20.w),
                    Expanded(
                        child: CustomButton(
                            buttonColor: primaryColor,
                            text: 'Signup',
                            textColor: Colors.black,
                            onTap: () {
                              Get.to(() => const SignUpScreen());
                            })),
                  ],
                ),
                SizedBox(height: 50.h),
              ],
            )
          ],
        ),
      ),
    );
  }
}
