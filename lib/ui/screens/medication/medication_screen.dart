import 'package:calkitna_mobile_app/core/constants/colors.dart';
import 'package:calkitna_mobile_app/core/constants/strings.dart';
import 'package:calkitna_mobile_app/core/constants/style.dart';
import 'package:calkitna_mobile_app/core/enums/view_state.dart';
import 'package:calkitna_mobile_app/ui/custom_widgets/custom_app_bar.dart';
import 'package:calkitna_mobile_app/ui/custom_widgets/image_container.dart';
import 'package:calkitna_mobile_app/ui/screens/medication/add_medication.dart';
import 'package:calkitna_mobile_app/ui/screens/medication/edit_medicine/edit_medicine_screen.dart';
import 'package:calkitna_mobile_app/ui/screens/medication/medication_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class MedicationScreen extends StatelessWidget {
  const MedicationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MedicationViewModel(),
      child: Consumer<MedicationViewModel>(
        builder: (context, model, child) {
          return ModalProgressHUD(
            inAsyncCall: model.state == ViewState.busy,
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(children: [
                  SizedBox(height: 70.h),
                  customAppBar('My Medication'),
                  SizedBox(height: 30.h),

                  ///
                  /// lower body
                  ///
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        children: [
                          ///
                          /// search field
                          ///
                          searchField(model),

                          ///
                          /// list of medicines
                          ///
                          Expanded(
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: model.medicines.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              blurRadius: 3,
                                              spreadRadius: 1),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 12, left: 12, right: 6),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                Switch(
                                                    activeColor: primaryColor,
                                                    value: model
                                                            .medicines[index]
                                                            .isReminderOpen ??
                                                        false,
                                                    onChanged: (value) {
                                                      model.setReminder(index);
                                                    })
                                              ],
                                            ),
                                            SizedBox(height: 15.h),
                                            Text(
                                                'Reminder Time (${model.medicines[index].noTimes})',
                                                style: subHeadingTextStyleRoboto
                                                    .copyWith(
                                                        color: primaryColor)),
                                            SizedBox(height: 10.h),
                                            Row(
                                              children: [
                                                const Icon(Icons.repeat,
                                                    size: 18),
                                                SizedBox(width: 10.w),
                                                Text(
                                                    '${model.medicines[index].time1}',
                                                    style: bodyTextStyleRoboto),
                                                SizedBox(width: 10.w),
                                                Container(
                                                    height: 15.h,
                                                    color: primaryColor,
                                                    width: 1.w),
                                                SizedBox(width: 10.w),
                                                model.medicines[index].time2 !=
                                                        null
                                                    ? Text(
                                                        '${model.medicines[index].time2}',
                                                        style:
                                                            bodyTextStyleRoboto)
                                                    : Container(),
                                                SizedBox(width: 10.w),
                                                model.medicines[index].time3 !=
                                                        null
                                                    ? Text(
                                                        '${model.medicines[index].time3}',
                                                        style:
                                                            bodyTextStyleRoboto)
                                                    : Container(),
                                              ],
                                            ),
                                            SizedBox(height: 30.h),
                                            Text('Schedule',
                                                style: subHeadingTextStyleRoboto
                                                    .copyWith(
                                                        color: primaryColor)),

                                            ///
                                            /// schedule
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    ImageContainer(
                                                        assetImage:
                                                            '$staticAsset/calendar.png',
                                                        height: 20.h,
                                                        width: 20.w),
                                                    SizedBox(width: 10.w),
                                                    Text(
                                                        '${model.medicines[index].schedule}',
                                                        style:
                                                            bodyTextStyleRoboto),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    IconButton(
                                                        onPressed: () async {
                                                          model.medicines = await Get.to(() => EditMedicineScreen(
                                                                  list: model
                                                                      .medicines,
                                                                  medicine: model
                                                                          .medicines[
                                                                      index])) ??
                                                              model.medicines;
                                                          model
                                                              .getAllMedicines();
                                                          model.setState(
                                                              ViewState.idle);
                                                        },
                                                        icon: const Icon(
                                                            Icons.edit,
                                                            color:
                                                                primaryColor)),
                                                    IconButton(
                                                        onPressed: () {
                                                          model.deleteMedicine(
                                                              model.medicines[
                                                                  index],
                                                              index);
                                                        },
                                                        icon: const Icon(
                                                            Icons.delete,
                                                            color:
                                                                primaryColor))
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 10.h),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          SizedBox(height: 30.h)
                        ],
                      ),
                    ),
                  )
                ]),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15)),
                          child: Container(
                            height: 0.26.sh,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 25, horizontal: 20),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.back();
                                      model.getImage();
                                    },
                                    child: Row(
                                      children: [
                                        ImageContainer(
                                          assetImage: '$staticAsset/scan.png',
                                          height: 45.h,
                                          width: 45.w,
                                        ),
                                        SizedBox(width: 14.w),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Scan Prescription',
                                                style: headingTextStyleRoboto),
                                            SizedBox(height: 6.h),
                                            Text(
                                                'Add medicine directly by scanning',
                                                style: bodyTextStyleRoboto)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 12.h),
                                  const Divider(),
                                  SizedBox(height: 12.h),
                                  GestureDetector(
                                    onTap: () async {
                                      model.medicines = await Get.to(() =>
                                              AddMedication(
                                                  list: model.medicines)) ??
                                          model.medicines;
                                      model.getAllMedicines();
                                      model.setState(ViewState.idle);
                                    },
                                    child: Row(
                                      children: [
                                        ImageContainer(
                                          assetImage:
                                              '$staticAsset/capsule.png',
                                          height: 45.h,
                                          width: 45.w,
                                        ),
                                        SizedBox(width: 14.w),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Add Medicine',
                                                style: headingTextStyleRoboto),
                                            SizedBox(height: 6.h),
                                            Text('Add medicine manually',
                                                style: bodyTextStyleRoboto)
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
                child: Container(
                  child: const Center(
                      child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 30,
                  )),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: primaryColor),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  searchField(MedicationViewModel model) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 3,
            spreadRadius: 1),
      ]),
      child: TextFormField(
        onChanged: (value) {
          // model.searching(value);
        },
        decoration: InputDecoration(
            suffixIcon: const Icon(Icons.search, size: 20),
            contentPadding: const EdgeInsets.only(left: 5, top: 10),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: bodyTextStyleRoboto.copyWith(fontSize: 15.sp)),
      ),
    );
  }
}
