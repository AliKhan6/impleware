import 'package:calkitna_mobile_app/core/constants/strings.dart';
import 'package:calkitna_mobile_app/core/constants/style.dart';
import 'package:calkitna_mobile_app/core/enums/view_state.dart';
import 'package:calkitna_mobile_app/ui/custom_widgets/custom_app_bar.dart';
import 'package:calkitna_mobile_app/ui/custom_widgets/image_container.dart';
import 'package:calkitna_mobile_app/ui/screens/chat/chat_screen.dart';
import 'package:calkitna_mobile_app/ui/screens/pharmacists/pharmacist_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class PharmacistScreen extends StatelessWidget {
  const PharmacistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PharmacistViewModel(),
      child: Consumer<PharmacistViewModel>(
        builder: (context, model, child) {
          return ModalProgressHUD(
            inAsyncCall: model.state == ViewState.busy,
            child: Scaffold(
              body: Column(
                children: [
                  SizedBox(height: 70.h),
                  customAppBar('Pharmacists'),
                  SizedBox(height: 30.h),

                  ///
                  /// list of pharmacists
                  ///
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: ListView.builder(
                        itemCount: model.pharmacists.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(
                                    () => ChatScreen(model.pharmacists[index]));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        blurRadius: 3,
                                        spreadRadius: 1),
                                  ],
                                  borderRadius: BorderRadius.circular(6),
                                  color: Colors.white,
                                ),
                                child: ListTile(
                                  leading: model.pharmacists[index].imageUrl ==
                                          null
                                      ? CircleAvatar(
                                          backgroundImage: const AssetImage(
                                              '$staticAsset/profile.jpg'),
                                          radius: 25.r)
                                      : CircleAvatar(
                                          backgroundImage: NetworkImage(model
                                              .pharmacists[index].imageUrl!),
                                          radius: 25.r),
                                  title: Text(
                                      '${model.pharmacists[index].name}',
                                      style: subHeadingTextStyleRoboto),
                                  subtitle: Text(
                                      '${model.pharmacists[index].email}',
                                      style: bodyTextStyleRoboto),
                                ),
                              ),
                            ),
                          );
                        }),
                  ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
