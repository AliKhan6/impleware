import 'package:calkitna_mobile_app/core/constants/colors.dart';
import 'package:calkitna_mobile_app/core/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool? obscure;
  final String? errorText;
  final String? hintText;
  final bool? enabled;
  final Color? errorColor;
  final Widget? suffixIcon;
  final validator;
  final double? fontSize;
  final String? label;
  final TextInputType? inputType;
  final onSaved;
  final ontap;
  final bool disableBorder;
  final Widget? prefixIcon;
  final int? maxline;
  final Color? fillColor;
  final bool? isElevated;
  final onChange;
  final initialValue;
  CustomTextField(
      {this.controller,
      this.prefixIcon,
      this.maxline = 1,
      this.ontap,
      this.errorColor = blackColor,
      this.disableBorder = false,
      this.label,
      this.inputType = TextInputType.text,
      this.obscure = false,
      this.enabled = true,
      this.validator,
      this.errorText,
      this.fontSize = 15.0,
      this.hintText,
      this.onSaved,
      this.fillColor = Colors.white,
      this.suffixIcon,
      this.onChange,
      this.initialValue,
      this.isElevated = false});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: (43.h * maxline!),
            decoration: BoxDecoration(
                color: fillColor,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  isElevated!
                      ? BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius:
                              2, // has the effect of softening the shadow
                          spreadRadius:
                              0.6, // has the effect of extending the shadow
                          offset: const Offset(
                            0, // horizontal, move right 10
                            0.4, // vertical, move down 10
                          ),
                        )
                      : const BoxShadow(color: Colors.transparent),
                ])),
        TextFormField(
          initialValue: initialValue ?? '',
          onChanged: onChange,
          maxLines: maxline,
          onTap: ontap,
          onSaved: onSaved,
          enabled: enabled,
          style: bodyTextStyleRoboto.copyWith(fontSize: this.fontSize),
          cursorColor: blackColor,
          controller: controller,
          obscureText: obscure!,
          validator: validator ??
              (value) {
                if (value!.isEmpty) {
                  return 'Required Field';
                } else {
                  return null;
                }
              },
          keyboardType: inputType,
          decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 14.0, right: 18.0),
                child: prefixIcon,
              ),
              prefixIconConstraints: BoxConstraints(
                  maxHeight: prefixIcon != null ? 40 : 14,
                  maxWidth: prefixIcon != null ? 50 : 15),
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              isDense: true,
              errorStyle: bodyTextStyleRoboto.copyWith(fontSize: 12),
              // alignLabelWithHint: true,
              suffixIcon: Padding(
                  padding: const EdgeInsets.only(),
                  child: suffixIcon ?? Container()),
              suffixIconConstraints:
                  const BoxConstraints(maxHeight: 40, maxWidth: 50),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              // EdgeInsets.only(left: 21.0, top: 10),
              hintText: hintText,

              // errorStyle: TextStyle(fontSize: 8, height: 1),
              hintStyle: bodyTextStyleRoboto.copyWith(
                  color: blackColor, fontSize: fontSize)),
        ),
      ],
    );
  }
}
