import 'package:calkitna_mobile_app/core/constants/colors.dart';
import 'package:calkitna_mobile_app/core/constants/style.dart';
import 'package:calkitna_mobile_app/core/enums/view_state.dart';
import 'package:calkitna_mobile_app/core/models/medicine.dart';
import 'package:calkitna_mobile_app/core/services/data_type_service.dart';
import 'package:calkitna_mobile_app/ui/custom_widgets/custom_button.dart';
import 'package:calkitna_mobile_app/ui/custom_widgets/custom_screen.dart';
import 'package:calkitna_mobile_app/ui/custom_widgets/custom_text_field.dart';
import 'package:calkitna_mobile_app/ui/screens/medication/add_medicine_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class EditMedicineScreen extends StatelessWidget {
  final List<Medicine>? list;
  final Medicine? medicine;
  const EditMedicineScreen({Key? key, this.list, this.medicine})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return ChangeNotifierProvider(
      create: (context) => AddMedicineViewModel(medicine: medicine),
      child: Consumer<AddMedicineViewModel>(
        builder: (context, model, child) {
          return ModalProgressHUD(
            inAsyncCall: model.state == ViewState.busy,
            child: CustomScreen(
              title: 'Add New Medicine',
              body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          ///
                          /// picture of medicine
                          ///
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 3,
                                    spreadRadius: 1),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Add medicine picture',
                                      style: subHeadingTextStyleRoboto),
                                  medicine!.imageUrl == null
                                      ? model.image == null
                                          ? IconButton(
                                              onPressed: () {
                                                model.getImage();
                                              },
                                              icon: const Icon(
                                                  Icons.photo_camera))
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              child: Image.file(model.image!,
                                                  height: 50.h,
                                                  width: 50.w,
                                                  fit: BoxFit.cover))
                                      : GestureDetector(
                                          onTap: () {
                                            model.getImage();
                                          },
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              child: Image.network(
                                                  medicine!.imageUrl!,
                                                  height: 50.h,
                                                  width: 50.w,
                                                  fit: BoxFit.cover)),
                                        )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),

                          ///
                          /// medicine name
                          ///
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 3,
                                    spreadRadius: 1),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// email text field
                                  Text(
                                    'Medicine name',
                                    style: subHeadingTextStyleRoboto,
                                  ),
                                  SizedBox(height: 8.h),
                                  CustomTextField(
                                    initialValue: medicine!.name,
                                    fillColor: const Color(0xFFEBEBEB),
                                    onChange: (value) {
                                      model.medicine.name = value;
                                    },
                                    inputType: TextInputType.emailAddress,
                                    disableBorder: true,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          ///
                          /// reminder
                          ///
                          SizedBox(height: 20.h),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 3,
                                    spreadRadius: 1),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// email text field
                                  Text(
                                    'Reminder Time',
                                    style: subHeadingTextStyleRoboto,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Icon(Icons.repeat),
                                      SizedBox(width: 5.w),
                                      Container(
                                        width: 0.25.sw,
                                        decoration: const BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey))),
                                        child: TextFormField(
                                          initialValue: medicine!.noTimes,
                                          onChanged: (String? value) {
                                            model.medicine.noTimes = value;
                                          },
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      top: 14, left: 4),
                                              border: InputBorder.none,
                                              hintText: 'no of times',
                                              hintStyle: bodyTextStyleRoboto),
                                        ),
                                      ),
                                    ],
                                  ),

                                  ///
                                  /// reminders
                                  remindersTile(model, () {
                                    model.shoPicker1(context);
                                  }, (value) {
                                    if (value.isNotEmpty) {
                                      model.medicine.pill1 =
                                          stringToDouble(value);
                                    }
                                  }, context,
                                      time: model.medicine.time1,
                                      inititalValue: model.medicine.pill1 ==
                                              null
                                          ? ''
                                          : model.medicine.pill1.toString()),

                                  // time 2
                                  remindersTile(model, () {
                                    model.shoPicker2(context);
                                  }, (value) {
                                    if (value.isNotEmpty) {
                                      model.medicine.pill2 =
                                          stringToDouble(value);
                                    }
                                  }, context,
                                      time: model.medicine.time2,
                                      inititalValue: model.medicine.pill2 ==
                                              null
                                          ? ''
                                          : model.medicine.pill2.toString()),
                                  // time 3
                                  remindersTile(model, () {
                                    model.shoPicker3(context);
                                  }, (value) {
                                    if (value != null) {
                                      model.medicine.pill3 =
                                          stringToDouble(value);
                                    }
                                  }, context,
                                      time: model.medicine.time3,
                                      inititalValue: model.medicine.pill3 ==
                                              null
                                          ? ''
                                          : model.medicine.pill3.toString()),
                                  SizedBox(height: 10.h)
                                ],
                              ),
                            ),
                          ),

                          ///
                          /// reminder
                          ///
                          SizedBox(height: 20.h),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 3,
                                    spreadRadius: 1),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// email text field
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Schedule',
                                        style: subHeadingTextStyleRoboto,
                                      ),
                                      Text(
                                        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
                                        style: subHeadingTextStyleRoboto,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  customRadio('Everyday', (value) {
                                    model.selectNewSchedule(0);
                                  }, model.everyday),
                                  // customRadio('Every Monday', (value) {
                                  //   model.selectNewSchedule(1);
                                  // }, model.everyMonday),
                                  // customRadio('Every Sunday', (value) {
                                  //   model.selectNewSchedule(2);
                                  // }, model.everySunday),
                                  SizedBox(height: 10.h)
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 30.h),
                          CustomButton(
                            width: 0.6.sw,
                            buttonColor: primaryColor,
                            text: 'DONE',
                            textColor: Colors.black,
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                model.update(list!);
                              }
                            },
                          ),
                          SizedBox(height: 40.h)
                        ],
                      ),
                    ),
                  )),
            ),
          );
        },
      ),
    );
  }

  Widget customRadio(String title, onChange, int groupValue) {
    return Row(
      children: [
        Theme(
            data: ThemeData(unselectedWidgetColor: primaryColor),
            child: Radio(
                activeColor: primaryColor,
                value: 1,
                groupValue: groupValue,
                onChanged: onChange)),
        Text(
          title,
          style: bodyTextStyleRoboto,
        )
      ],
    );
  }

  remindersTile(AddMedicineViewModel model, onChange1, onChange2, context,
      {String? time, String? inititalValue}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: onChange1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Icon(Icons.alarm),
                  SizedBox(width: 5.w),
                  Container(
                      width: 0.25.sw,
                      decoration: const BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Colors.grey))),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0, bottom: 5),
                        child:
                            Text(time ?? 'time..', style: bodyTextStyleRoboto),
                      )
                      // TextFormField(
                      //   onChanged: onChange1,
                      //   keyboardType: TextInputType.number,
                      //   decoration: InputDecoration(
                      //       contentPadding: const EdgeInsets.only(top: 14, left: 4),
                      //       border: InputBorder.none,
                      //       hintText: 'time...',
                      //       hintStyle: bodyTextStyleRoboto),
                      // ),
                      ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 0.2.sw,
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey))),
                  child: TextFormField(
                    initialValue: inititalValue ?? '',
                    onChanged: onChange2,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(top: 14, left: 4),
                        border: InputBorder.none,
                        hintText: 'no of pill...',
                        hintStyle: bodyTextStyleRoboto),
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
