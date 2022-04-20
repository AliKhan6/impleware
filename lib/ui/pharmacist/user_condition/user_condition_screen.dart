import 'package:calkitna_mobile_app/core/constants/style.dart';
import 'package:calkitna_mobile_app/core/enums/view_state.dart';
import 'package:calkitna_mobile_app/core/models/app_user.dart';
import 'package:calkitna_mobile_app/ui/custom_widgets/custom_app_bar.dart';
import 'package:calkitna_mobile_app/ui/pharmacist/user_condition/user_condition_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/strings.dart';
import '../../custom_widgets/image_container.dart';

class UserConditionScreen extends StatelessWidget {
  final AppUser appUser;
  const UserConditionScreen(this.appUser, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserConditionViewModel(appUser),
      child: Consumer<UserConditionViewModel>(
        builder: (context, model, child) {
          return ModalProgressHUD(
            inAsyncCall: model.state == ViewState.busy,
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(children: [
                  SizedBox(height: 70.h),
                  customAppBar("${appUser.name}'s Condition"),
                  Column(children: [
                    SizedBox(height: 30.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///
                        /// symptoms
                        ///
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 15),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 3,
                                    spreadRadius: 1),
                              ],
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white),
                          child: Column(
                            children: [
                              Text('Symptoms', style: headingTextStyleRoboto),
                              SizedBox(height: 10.h),
                              const Divider(),
                              SizedBox(height: 10.h),
                              Row(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle),
                                    height: 17.h,
                                    width: 17.w,
                                  ),
                                  SizedBox(width: 10.w),
                                  Text(model.updateSymptoms.symptom1 ?? '',
                                      style: subHeadingTextStyleRoboto),
                                ],
                              ),
                              SizedBox(height: 12.h),
                              const Divider(),
                              SizedBox(height: 10.h),
                              Row(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle),
                                    height: 17.h,
                                    width: 17.w,
                                  ),
                                  SizedBox(width: 10.w),
                                  Text(model.updateSymptoms.symptom2 ?? '',
                                      style: subHeadingTextStyleRoboto),
                                ],
                              ),
                              SizedBox(height: 12.h),
                              const Divider(),
                              SizedBox(height: 10.h),
                              Row(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle),
                                    height: 17.h,
                                    width: 17.w,
                                  ),
                                  SizedBox(width: 10.w),
                                  Text(model.updateSymptoms.symptom3 ?? '',
                                      style: subHeadingTextStyleRoboto),
                                ],
                              ),
                              SizedBox(height: 12.h),
                              const Divider(),
                              SizedBox(height: 10.h)
                            ],
                          ),
                        )),
                        SizedBox(width: 10.w),

                        ///
                        /// medicines
                        ///
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 15),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 3,
                                    spreadRadius: 1),
                              ],
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white),
                          child: Column(
                            children: [
                              Text('Medicines', style: headingTextStyleRoboto),
                              SizedBox(height: 10.h),
                              const Divider(),
                              SizedBox(height: 10.h),
                              ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  itemCount: model.medicines.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            ImageContainer(
                                                assetImage:
                                                    '$staticAsset/capsule.png',
                                                height: 30.h,
                                                width: 20.w),
                                            SizedBox(width: 10.w),
                                            Text(
                                                '${model.medicines[index].name}',
                                                style:
                                                    subHeadingTextStyleRoboto),
                                          ],
                                        ),
                                        SizedBox(height: 12.h),
                                        const Divider(),
                                        SizedBox(height: 10.h)
                                      ],
                                    );
                                  })
                            ],
                          ),
                        )),
                      ],
                    )
                  ])
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
