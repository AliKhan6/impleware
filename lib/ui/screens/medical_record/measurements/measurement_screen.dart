import 'package:calkitna_mobile_app/core/constants/colors.dart';
import 'package:calkitna_mobile_app/core/constants/style.dart';
import 'package:calkitna_mobile_app/ui/custom_widgets/custom_app_bar.dart';
import 'package:calkitna_mobile_app/ui/custom_widgets/custom_button.dart';
import 'package:calkitna_mobile_app/ui/custom_widgets/custom_text_field.dart';
import 'package:calkitna_mobile_app/ui/screens/medical_record/measurements/measurement_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MeasurementScreen extends StatelessWidget {
  const MeasurementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MeasurementViewModel(),
      child: Consumer<MeasurementViewModel>(
        builder: (context, model, child) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  SizedBox(height: 70.h),
                  customAppBar('Add Measurements'),
                  SizedBox(height: 40.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///
                        /// textFields
                        ///
                        textFields(model),
                        SizedBox(height: 50.h),
                        Center(
                          child: CustomButton(
                            width: 0.5.sw,
                            buttonColor: primaryColor,
                            text: 'SAVE',
                            textColor: Colors.black,
                            onTap: () {},
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  textFields(MeasurementViewModel model) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      /// email text field
      Text(
        'Height',
        style: bodyTextStyleRoboto.copyWith(fontSize: 14.sp),
      ),
      SizedBox(height: 8.h),
      CustomTextField(
        initialValue: model.measurements.height,
        fillColor: const Color(0xFFEBEBEB),
        onChange: (value) {
          model.measurements.height = value;
        },
        inputType: TextInputType.emailAddress,
        disableBorder: true,
      ),
      SizedBox(height: 15.h),

      /// email text field
      Text(
        'Weight',
        style: bodyTextStyleRoboto.copyWith(fontSize: 14.sp),
      ),
      SizedBox(height: 8.h),
      CustomTextField(
        initialValue: model.measurements.weight,
        fillColor: const Color(0xFFEBEBEB),
        onChange: (value) {
          model.measurements.weight = value;
        },
        inputType: TextInputType.emailAddress,
        disableBorder: true,
      ),
      SizedBox(height: 15.h),

      Text('Body Type', style: subHeadingTextStyleRoboto),
      SizedBox(height: 15.h),

      /// Change language
      ///
      Container(
          height: 55.h,
          width: 1.sw,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border:
                  Border.all(color: const Color(0XFF686868).withOpacity(0.4))),
          child: PopupMenuButton<String>(
            itemBuilder: (context) {
              return model.items.map((str) {
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
                  model.dropdownValue,
                  style: bodyTextStyleRoboto.copyWith(
                      color: const Color(0xFF4F4F4F), fontSize: 16.sp),
                ),
                const Icon(Icons.keyboard_arrow_down,
                    size: 22, color: Color(0xFF4F4F4F)),
              ],
            ),
            onSelected: (v) {
              model.changeDropDown(v);
            },
          )),
    ]);
  }
}
