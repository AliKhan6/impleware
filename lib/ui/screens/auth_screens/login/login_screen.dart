import 'package:calkitna_mobile_app/core/constants/colors.dart';
import 'package:calkitna_mobile_app/core/constants/strings.dart';
import 'package:calkitna_mobile_app/core/constants/style.dart';
import 'package:calkitna_mobile_app/core/enums/view_state.dart';
import 'package:calkitna_mobile_app/core/others/screen_utils.dart';
import 'package:calkitna_mobile_app/ui/custom_widgets/custom_button.dart';
import 'package:calkitna_mobile_app/ui/custom_widgets/custom_text_field.dart';
import 'package:calkitna_mobile_app/ui/custom_widgets/social_auth_button.dart';
import 'package:calkitna_mobile_app/ui/screens/auth_screens/login/login_view_model.dart';
import 'package:calkitna_mobile_app/ui/screens/auth_screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
      child: Consumer<LoginViewModel>(
        builder: (context, model, child) {
          return ModalProgressHUD(
            inAsyncCall: model.state == ViewState.busy,
            child: Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 27, top: 65, bottom: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () => Get.back(),
                          icon:
                              const Icon(Icons.arrow_back, color: blackColor)),
                      SizedBox(height: 30.h),

                      /// title
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'LOGIN',
                                style: headingTextStyleRoboto.copyWith(
                                    fontSize: 28.sp,
                                    color: const Color(0xFF756DB8)),
                              ),
                              SizedBox(height: 40.h),

                              ///
                              /// Text fields
                              textFields(model),
                              SizedBox(height: 40.h),

                              ///
                              /// Login button
                              CustomButton(
                                text: 'Login',
                                buttonColor: const Color(0xFF756DB8),
                                onTap: () {
                                  model.login();
                                },
                                textColor: Colors.white,
                              ),
                              SizedBox(height: 24.h),
                              // Center(
                              //   child: Text('Or continue with',
                              //       style: bodyTextStyleAssistant.copyWith(
                              //           fontSize: 14.sp, color: const Color(0xFF707070))),
                              // ),
                              SizedBox(height: 29.h),
                              GestureDetector(
                                onTap: () => Get.to(() => const SignUpScreen()),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "If you don't have an account, try",
                                        style: bodyTextStyleAssistant.copyWith(
                                            fontSize: 14.sp,
                                            color: const Color(0xFF707070)),
                                      ),
                                      SizedBox(width: 7.w),
                                      Text('Signing Up here.',
                                          style:
                                              bodyTextStyleAssistant.copyWith(
                                                  color:
                                                      const Color(0xFF756DB8),
                                                  fontSize: 14.sp,
                                                  decoration:
                                                      TextDecoration.underline))
                                    ]),
                              )
                            ]),
                      )

                      ///
                      /// Social login buttons
                      // socailAuthButtons(model),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  textFields(LoginViewModel model) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      /// email text field
      Text(
        'Email address',
        style: bodyTextStyleRoboto.copyWith(fontSize: 14.sp),
      ),
      SizedBox(height: 8.h),
      CustomTextField(
        fillColor: const Color(0xFFEBEBEB),
        onChange: (value) {
          model.appUser.email = value;
        },
        inputType: TextInputType.emailAddress,
        disableBorder: true,
      ),
      SizedBox(height: 25.h),

      /// password filed

      Text(
        'Password',
        style: bodyTextStyleRoboto.copyWith(fontSize: 14.sp),
      ),
      SizedBox(height: 8.h),
      CustomTextField(
          fillColor: const Color(0xFFEBEBEB),
          onChange: (value) {
            model.appUser.password = value;
          },
          inputType: TextInputType.emailAddress,
          disableBorder: true,
          obscure: model.isShowPassword,
          suffixIcon: GestureDetector(
            onTap: () {
              model.showPassword();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Image.asset(
                model.isShowPassword
                    ? '$staticAsset/password_not_show.png'
                    : '$staticAsset/password.png',
                width: 16.28.w,
                height: 16.28.h,
                color: const Color(0xFF756DB8),
              ),
            ),
          )),
    ]);
  }

  socailAuthButtons(LoginViewModel model) {
    return Column(
      children: [
        Row(
          children: [
            const SocialAuthButton(
              onTap: null,
              image: '$staticAsset/google.png',
            ),
            Platform.isIOS
                ? Row(children: [
                    SizedBox(width: 10.w),
                    const SocialAuthButton(
                      onTap: null,
                      image: '$staticAsset/apple.png',
                    ),
                  ])
                : Container(),
            SizedBox(width: 10.w),
            const SocialAuthButton(
              onTap: null,
              image: '$staticAsset/facebook.png',
            ),
          ],
        ),
      ],
    );
  }
}
