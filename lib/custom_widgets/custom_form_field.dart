import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_scanner_project/config/theme_colors.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool security;
  final TextInputType inputType;
  final String? validation;
  final Function(dynamic)? saved;
  final int maxLine;
  final Widget? prefix;
  final Widget? suffix;
  final Function(String)? onChanged;
  final int? number;
  final String? labelText;
  final Color? hintTextColor;
  final Color? labelTextColor;

  const CustomFormField({
    Key? key,
    this.controller,
    this.hintText,
    this.inputType = TextInputType.text,
    this.saved,
    this.validation,
    this.security = false,
    this.maxLine = 1,
    this.prefix,
    this.suffix,
    this.onChanged,
    this.labelText,
    this.number,
    this.hintTextColor,
    this.labelTextColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.isEmpty || value.length < number!) {
          return validation;
        }
        return null;
      },
      onSaved: saved,
      obscureText: security,
      maxLines: maxLine,
      keyboardType: inputType,
      onChanged: onChanged,
      decoration: InputDecoration(
        alignLabelWithHint: false,
        prefixIcon: prefix,
        suffixIcon: suffix,
        hintText: hintText,
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14.0.sp,
          fontFamily: 'madani',
          color: hintTextColor,
        ),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontFamily: 'madani',
          fontSize: 16.0.sp,
          color: labelTextColor,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: TColor.white),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
      ),
    );
  }
}
