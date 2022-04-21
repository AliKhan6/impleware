import 'package:calkitna_mobile_app/core/constants/colors.dart';
import 'package:calkitna_mobile_app/core/enums/view_state.dart';
import 'package:calkitna_mobile_app/core/models/app_user.dart';
import 'package:calkitna_mobile_app/ui/custom_widgets/custom_app_bar.dart';
import 'package:calkitna_mobile_app/ui/custom_widgets/custom_button.dart';
import 'package:calkitna_mobile_app/ui/screens/medical_record/patient_record/patient_record_veiw_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/style.dart';
import '../../../custom_widgets/custom_text_field.dart';

class PatientRecordScreen extends StatelessWidget {
  final AppUser? appUser;
  const PatientRecordScreen({Key? key, this.appUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PatientRecordViewModel(appUser: appUser),
      child: Consumer<PatientRecordViewModel>(
        builder: (context, model, child) {
          return ModalProgressHUD(
            inAsyncCall: model.state == ViewState.busy,
            child: Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 70.h),
                      customAppBar('Patient Record'),
                      SizedBox(height: 40.h),
                      textFields(model),
                      SizedBox(height: 40.h),
                   appUser != null ? Container():   CustomButton(
                        buttonColor: primaryColor,
                        text: 'SAVE',
                        textColor: Colors.black,
                        onTap: () {
                          model.savePatientRecord();
                        },
                      )
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

  textFields(PatientRecordViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// email text field
        Text(
          'Full Name',
          style: bodyTextStyleRoboto.copyWith(fontSize: 14.sp),
        ),
        SizedBox(height: 8.h),
        CustomTextField(
          initialValue: model.patientRecord.name,
          fillColor: const Color(0xFFEBEBEB),
          onChange: (value) {
            model.patientRecord.name = value;
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
          initialValue: model.patientRecord.username,
          fillColor: const Color(0xFFEBEBEB),
          onChange: (value) {
            model.patientRecord.username = value;
          },
          inputType: TextInputType.emailAddress,
          disableBorder: true,
        ),
        SizedBox(height: 15.h),

        /// email text field
        Text(
          'Email',
          style: bodyTextStyleRoboto.copyWith(fontSize: 14.sp),
        ),
        SizedBox(height: 8.h),
        CustomTextField(
          initialValue: model.patientRecord.email,
          fillColor: const Color(0xFFEBEBEB),
          onChange: (value) {
            model.patientRecord.email = value;
          },
          inputType: TextInputType.emailAddress,
          disableBorder: true,
        ),
        SizedBox(height: 15.h),

        /// email text field
        Text(
          'Contact Info',
          style: bodyTextStyleRoboto.copyWith(fontSize: 14.sp),
        ),
        SizedBox(height: 8.h),
        CustomTextField(
          initialValue: model.patientRecord.contact,
          fillColor: const Color(0xFFEBEBEB),
          onChange: (value) {
            model.patientRecord.contact = value;
          },
          inputType: TextInputType.emailAddress,
          disableBorder: true,
        ),
        SizedBox(height: 15.h),

        /// email text field
        Text(
          'Gender',
          style: bodyTextStyleRoboto.copyWith(fontSize: 14.sp),
        ),
        SizedBox(height: 8.h),
        CustomTextField(
          initialValue: model.patientRecord.gender,
          fillColor: const Color(0xFFEBEBEB),
          onChange: (value) {
            model.patientRecord.gender = value;
          },
          inputType: TextInputType.emailAddress,
          disableBorder: true,
        ),
        SizedBox(height: 15.h),

        /// email text field
        Text(
          'Age',
          style: bodyTextStyleRoboto.copyWith(fontSize: 14.sp),
        ),
        SizedBox(height: 8.h),
        CustomTextField(
          initialValue: model.patientRecord.age,
          fillColor: const Color(0xFFEBEBEB),
          onChange: (value) {
            model.patientRecord.age = value;
          },
          inputType: TextInputType.emailAddress,
          disableBorder: true,
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}
