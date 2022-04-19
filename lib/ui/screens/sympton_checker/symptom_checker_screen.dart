import 'package:calkitna_mobile_app/core/constants/colors.dart';
import 'package:calkitna_mobile_app/core/constants/strings.dart';
import 'package:calkitna_mobile_app/core/constants/style.dart';
import 'package:calkitna_mobile_app/core/enums/view_state.dart';
import 'package:calkitna_mobile_app/ui/custom_widgets/custom_app_bar.dart';
import 'package:calkitna_mobile_app/ui/custom_widgets/image_container.dart';
import 'package:calkitna_mobile_app/ui/screens/sympton_checker/symptom_checker_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../custom_widgets/custom_text_field.dart';

class SymptomCheckerScreen extends StatelessWidget {
  const SymptomCheckerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return ChangeNotifierProvider(
      create: (context) => SymptomCheckerViewModel(),
      child: Consumer<SymptomCheckerViewModel>(
        builder: (context, model, child) {
          return ModalProgressHUD(
            inAsyncCall: model.state == ViewState.busy,
            child: Scaffold(
              body: Column(children: [
                SizedBox(height: 70.h),
                customAppBar('Symptom Checker'),
                SizedBox(height: 30.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Feeling uncomfortable? Insert your symptoms for a help!',
                            textAlign: TextAlign.center,
                            style: bodyTextStyleRoboto.copyWith(
                                fontSize: 18.sp,
                                color: primaryColor.withOpacity(0.7))),
                        SizedBox(height: 50.h),

                        /// email text field
                        Text(
                          'Enter Symptoms below',
                          style: bodyTextStyleRoboto.copyWith(fontSize: 14.sp),
                        ),
                        SizedBox(height: 15.h),
                        CustomTextField(
                          fillColor: const Color(0xFFEBEBEB),
                          onChange: (value) {
                            model.symptomChecker.symptom1 = value;
                          },
                          inputType: TextInputType.emailAddress,
                          disableBorder: true,
                        ),
                        SizedBox(height: 10.h),
                        CustomTextField(
                          fillColor: const Color(0xFFEBEBEB),
                          onChange: (value) {
                            model.symptomChecker.symptom2 = value;
                          },
                          inputType: TextInputType.emailAddress,
                          disableBorder: true,
                        ),
                        SizedBox(height: 10.h),
                        CustomTextField(
                          fillColor: const Color(0xFFEBEBEB),
                          onChange: (value) {
                            model.symptomChecker.symptom3 = value;
                          },
                          inputType: TextInputType.emailAddress,
                          disableBorder: true,
                        ),
                        SizedBox(height: 40.h),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              model.checkSymptoms();
                            }
                          },
                          child: Center(
                            child: ImageContainer(
                              assetImage: '$staticAsset/search.png',
                              height: 70.h,
                              width: 70.w,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ]),
            ),
          );
        },
      ),
    );
  }
}
