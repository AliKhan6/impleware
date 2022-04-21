import 'package:calkitna_mobile_app/core/constants/style.dart';
import 'package:calkitna_mobile_app/core/enums/view_state.dart';
import 'package:calkitna_mobile_app/core/models/symptom_checker.dart';
import 'package:calkitna_mobile_app/core/models/symptoms.dart';
import 'package:calkitna_mobile_app/core/services/database_service.dart';
import 'package:calkitna_mobile_app/core/view_models.dart/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/colors.dart';

class SymptomCheckerViewModel extends BaseViewModel {
  final _dbService = DatabaseService();
  SymptomChecker symptomChecker = SymptomChecker();
  List<Symptoms> symptoms = [];
  List<Symptoms> foundDisease = [];

  SymptomCheckerViewModel() {
    getSymptoms();
  }

  getSymptoms() async {
    setState(ViewState.busy);
    symptoms = await _dbService.getSymptoms();
    setState(ViewState.idle);
  }

  checkSymptoms() {
    debugPrint('checkSymptoms');
    setState(ViewState.busy);
    foundDisease = [];
    for (int i = 0; i < symptoms.length; i++) {
      bool isFound = false;
      for (int j = 0; j < symptoms[i].symptoms!.length; j++) {
        if (symptoms[i].symptoms![j] == symptomChecker.symptom1 ||
            symptoms[i].symptoms![j] == symptomChecker.symptom2 ||
            symptoms[i].symptoms![j] == symptomChecker.symptom3) {
          isFound = true;
        }
      }
      if (isFound) {
        foundDisease.add(symptoms[i]);
      }
    }
    Get.dialog(CustomDialog(foundDisease));
    setState(ViewState.idle);
  }
}

class CustomDialog extends StatelessWidget {
  final List<Symptoms> symptoms;
  CustomDialog(this.symptoms);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Disease that contains these symptoms are:',
          style: subHeadingTextStyleRoboto),
      content: SizedBox(
          height: 0.5.sh,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: symptoms.length,
              itemBuilder: (context, index) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Disease: ${symptoms[index].name}',
                          style: headingTextStyleRoboto.copyWith(
                              color: primaryColor)),
                      SizedBox(height: 14.h),
                      const Divider(height: 2),
                      SizedBox(height: 14.h),
                      Text('Symptoms are: ',
                          style: bodyTextStyleAssistant.copyWith(
                              decoration: TextDecoration.underline,
                              fontSize: 17.sp,
                              color: Colors.black)),
                      SizedBox(height: 16.h),
                      ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: symptoms[index].symptoms!.length,
                          itemBuilder: (context, i) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(symptoms[index].symptoms![i],
                                    style: bodyTextStyleRoboto),
                                SizedBox(height: 6.h),
                                const Divider()
                              ],
                            );
                          })
                    ]);
              })),
      actions: [
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(primaryColor)),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Ok'.tr,
            style: bodyTextStyleRoboto,
          ),
        ),
      ],
    );
  }
}
