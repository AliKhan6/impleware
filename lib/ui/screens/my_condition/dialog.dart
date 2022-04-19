import 'package:calkitna_mobile_app/core/constants/colors.dart';
import 'package:calkitna_mobile_app/core/constants/style.dart';
import 'package:calkitna_mobile_app/ui/custom_widgets/custom_button.dart';
import 'package:calkitna_mobile_app/ui/custom_widgets/custom_text_field.dart';
import 'package:calkitna_mobile_app/ui/screens/my_condition/my_conditions_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDialog extends StatelessWidget {
  final MyConditionViewModel model;
  CustomDialog(this.model);
  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 15),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
          ),
          height: MediaQuery.of(context).size.height * 0.45,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add Symptoms', style: headingTextStyleRoboto),

              /// email text field

              SizedBox(height: 30.h),
              CustomTextField(
                initialValue: model.updateSymptoms.symptom1,
                fillColor: const Color(0xFFEBEBEB),
                onChange: (value) {
                  model.updateSymptoms.symptom1 = value;
                },
                inputType: TextInputType.emailAddress,
                disableBorder: true,
              ),
              SizedBox(height: 15.h),
              CustomTextField(
                initialValue: model.updateSymptoms.symptom2,
                fillColor: const Color(0xFFEBEBEB),
                onChange: (value) {
                  model.updateSymptoms.symptom2 = value;
                },
                inputType: TextInputType.emailAddress,
                disableBorder: true,
              ),
              SizedBox(height: 15.h),
              CustomTextField(
                initialValue: model.updateSymptoms.symptom3,
                fillColor: const Color(0xFFEBEBEB),
                onChange: (value) {
                  model.updateSymptoms.symptom3 = value;
                },
                inputType: TextInputType.emailAddress,
                disableBorder: true,
              ),
              SizedBox(height: 30.h),
              CustomButton(
                buttonColor: primaryColor,
                text: 'Add',
                textColor: Colors.white,
                onTap: () {
                  model.addSymptoms();
                },
              )
            ],
          ),
        ));
  }
}
