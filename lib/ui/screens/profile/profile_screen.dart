import 'package:calkitna_mobile_app/core/constants/colors.dart';
import 'package:calkitna_mobile_app/core/constants/strings.dart';
import 'package:calkitna_mobile_app/core/constants/style.dart';
import 'package:calkitna_mobile_app/core/enums/view_state.dart';
import 'package:calkitna_mobile_app/ui/custom_widgets/custom_app_bar.dart';
import 'package:calkitna_mobile_app/ui/custom_widgets/custom_button.dart';
import 'package:calkitna_mobile_app/ui/custom_widgets/custom_text_field.dart';
import 'package:calkitna_mobile_app/ui/screens/profile/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileViewModel(),
      child: Consumer<ProfileViewModel>(
        builder: (context, model, child) {
          return ModalProgressHUD(
            inAsyncCall: model.state == ViewState.busy,
            child: Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(children: [
                    SizedBox(height: 70.h),
                    customAppBar('Profile'),
                    SizedBox(height: 30.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(children: [
                        model.image == null
                            ? model.authService.appUser.imageUrl == null
                                ? CircleAvatar(
                                    backgroundImage: const AssetImage(
                                        '$staticAsset/profile.jpg'),
                                    radius: 48.r)
                                : CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        model.authService.appUser.imageUrl!),
                                    radius: 48.r)
                            : CircleAvatar(
                                backgroundImage: FileImage(model.image!),
                                radius: 48.r),
                        SizedBox(height: 5.h),
                        TextButton(
                            onPressed: () {
                              model.getImage();
                            },
                            child: Text(
                              'Change Profile',
                              style: bodyTextStyleRoboto.copyWith(
                                  fontSize: 17.sp,
                                  color: blueColor,
                                  decoration: TextDecoration.underline),
                            )),
                        SizedBox(height: 20.h),

                        ///
                        /// textFields
                        ///
                        textFields(model),
                        SizedBox(height: 30.h),
                        CustomButton(
                          buttonColor: primaryColor,
                          text: 'SAVE CHANGES',
                          textColor: Colors.black,
                          onTap: () {
                            model.saveData();
                          },
                        )
                      ]),
                    ),
                  ]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  textFields(ProfileViewModel model) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      /// email text field
      Text(
        'Full Name',
        style: bodyTextStyleRoboto.copyWith(fontSize: 14.sp),
      ),
      SizedBox(height: 8.h),
      CustomTextField(
        initialValue: model.authService.appUser.name,
        fillColor: const Color(0xFFEBEBEB),
        onChange: (value) {
          model.appUser.name = value;
        },
        inputType: TextInputType.emailAddress,
        disableBorder: true,
      ),
      SizedBox(height: 15.h),

      /// email text field
      Text(
        'Username',
        style: bodyTextStyleRoboto.copyWith(fontSize: 14.sp),
      ),
      SizedBox(height: 8.h),
      CustomTextField(
        initialValue: model.authService.appUser.username,
        fillColor: const Color(0xFFEBEBEB),
        onChange: (value) {
          model.appUser.username = value;
        },
        inputType: TextInputType.emailAddress,
        disableBorder: true,
      ),
      SizedBox(height: 15.h),

      /// email text field
      Text(
        'Emirate Number',
        style: bodyTextStyleRoboto.copyWith(fontSize: 14.sp),
      ),
      SizedBox(height: 8.h),
      CustomTextField(
        initialValue: model.authService.appUser.emirateNumber,
        fillColor: const Color(0xFFEBEBEB),
        onChange: (value) {
          model.appUser.emirateNumber = value;
        },
        inputType: TextInputType.emailAddress,
        disableBorder: true,
      ),
      SizedBox(height: 15.h),
    ]);
  }
}
