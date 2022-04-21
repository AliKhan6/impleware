import 'package:calkitna_mobile_app/core/constants/style.dart';
import 'package:calkitna_mobile_app/ui/custom_widgets/custom_screen.dart';
import 'package:calkitna_mobile_app/ui/screens/setting/settting_view_model.dart';
import 'package:flutter/material.dart';
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
          return CustomScreen(
            title: 'Settings',
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(children: [
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
                )
              ]),
            ),
          );
        },
      ),
    );
  }
}
