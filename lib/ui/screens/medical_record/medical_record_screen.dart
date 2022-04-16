import 'package:calkitna_mobile_app/ui/custom_widgets/custom_app_bar.dart';
import 'package:calkitna_mobile_app/ui/screens/medical_record/medical_record_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/style.dart';
import '../../custom_widgets/image_container.dart';

class MedicalRecordScreen extends StatelessWidget {
  const MedicalRecordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MedicalRecordViewModel(),
      child: Consumer<MedicalRecordViewModel>(
        builder: (context, model, child) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(children: [
                SizedBox(height: 70.h),

                ///
                /// custom app bar
                ///
                customAppBar('Medical Record'),
                SizedBox(height: 15.h),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: model.records.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 4.0, right: 4),
                            child: GestureDetector(
                              onTap: model.records[index].onTap,
                              child: Container(
                                height: 120.h,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ImageContainer(
                                          assetImage:
                                              '${model.records[index].image}',
                                          height: 65.h,
                                          width: 45.w),
                                      SizedBox(height: 8.h),
                                      Text(
                                        '${model.records[index].title}',
                                        style: bodyTextStyleRoboto,
                                      )
                                    ]),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                SizedBox(height: 30.h)
              ]),
            ),
          );
        },
      ),
    );
  }
}
