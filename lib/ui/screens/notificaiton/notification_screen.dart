import 'package:calkitna_mobile_app/core/constants/style.dart';
import 'package:calkitna_mobile_app/core/enums/view_state.dart';
import 'package:calkitna_mobile_app/ui/custom_widgets/custom_screen.dart';
import 'package:calkitna_mobile_app/ui/screens/pill_reminder/pill_reminder_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PillReminderViewModel(),
      child: Consumer<PillReminderViewModel>(
        builder: (context, model, child) {
          return ModalProgressHUD(
            inAsyncCall: model.state == ViewState.busy,
            child: CustomScreen(
              title: 'Notifications',
              body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      itemCount: model.medicines.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 3,
                                    spreadRadius: 1),
                              ],
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.notifications),
                                  SizedBox(width: 8.w),
                                  Text(
                                    'Reminder',
                                    style: subHeadingTextStyleRoboto,
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                'Reminder for ${model.medicines[index].name} has been turned ${model.medicines[index].isReminderOpen == true ? 'ON' : 'OFF'}',
                                style: bodyTextStyleRoboto,
                              ),
                              SizedBox(height: 8.h),
                            ],
                          ),
                        );
                      })),
            ),
          );
        },
      ),
    );
  }
}
