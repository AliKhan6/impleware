import 'package:calkitna_mobile_app/core/constants/style.dart';
import 'package:calkitna_mobile_app/core/enums/view_state.dart';
import 'package:calkitna_mobile_app/ui/custom_widgets/custom_button.dart';
import 'package:calkitna_mobile_app/ui/custom_widgets/custom_screen.dart';
import 'package:calkitna_mobile_app/ui/screens/setting/settting_view_model.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';
import '../../../core/others/screen_utils.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SettingViewModel(),
      child: Consumer<SettingViewModel>(
        builder: (context, model, child) {
          return ModalProgressHUD(
            inAsyncCall: model.state == ViewState.busy,
            child: CustomScreen(
              title: 'Settings',
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Notifications', style: bodyTextStyleRoboto),
                          Switch(
                              activeColor: primaryColor,
                              value: model.isNoti,
                              onChanged: (value) {
                                model.updateNot();
                              })
                        ],
                      ),
                      SizedBox(height: 25.h),
                      Text('Change Tune', style: bodyTextStyleRoboto),
                      SizedBox(height: 25.h),

                      /// Change language
                      ///
                      Container(
                          height: 55.h,
                          width: 1.sw,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                  color: const Color(0XFF686868)
                                      .withOpacity(0.4))),
                          child: PopupMenuButton<String>(
                            itemBuilder: (context) {
                              return model.tunes.map((str) {
                                return PopupMenuItem(
                                  value: str,
                                  child: Text(str),
                                );
                              }).toList();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  model.selectedTune,
                                  style: bodyTextStyleRoboto.copyWith(
                                      color: const Color(0xFF4F4F4F),
                                      fontSize: 16.sp),
                                ),
                                const Icon(Icons.keyboard_arrow_down,
                                    size: 22, color: Color(0xFF4F4F4F)),
                              ],
                            ),
                            onSelected: (v) {
                              model.changeDropDown(v);
                            },
                          )),
                      SizedBox(height: 40.h),
                      CustomButton(
                        text: 'SAVE',
                        buttonColor: primaryColor,
                        textColor: Colors.black,
                        onTap: () {
                          model.save();
                        },
                      )
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
