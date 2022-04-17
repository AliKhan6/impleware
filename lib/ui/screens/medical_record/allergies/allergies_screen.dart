import 'package:calkitna_mobile_app/core/constants/colors.dart';
import 'package:calkitna_mobile_app/core/constants/style.dart';
import 'package:calkitna_mobile_app/core/enums/view_state.dart';
import 'package:calkitna_mobile_app/ui/custom_widgets/custom_app_bar.dart';
import 'package:calkitna_mobile_app/ui/screens/medical_record/allergies/allergies_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../custom_widgets/custom_button.dart';

class AllergiesScreen extends StatelessWidget {
  const AllergiesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AllergyViewModel(),
      child: Consumer<AllergyViewModel>(
        builder: (context, model, child) {
          return ModalProgressHUD(
            inAsyncCall: model.state == ViewState.busy,
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: 70.h),
                    customAppBar('Add Allergies'),
                    SizedBox(height: 40.h),
                    Expanded(
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: model.allergies.length,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Theme(
                                    data: ThemeData(
                                        unselectedWidgetColor: primaryColor),
                                    child: Radio(
                                        activeColor: primaryColor,
                                        focusColor: primaryColor,
                                        value: 1,
                                        groupValue:
                                            model.allergies[index].isSelected,
                                        onChanged: (value) {
                                          model.selectAllergy(index);
                                        }),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text('${model.allergies[index].type}',
                                      style: bodyTextStyleAssistant)
                                ],
                              );
                            })),
                    CustomButton(
                      width: 0.5.sw,
                      buttonColor: primaryColor,
                      text: 'SAVE',
                      textColor: Colors.black,
                      onTap: () {},
                    ),
                    SizedBox(height: 30.h)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
