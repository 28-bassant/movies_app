
import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
typedef OnValidator = String? Function(String?)?;
class  CustomTextFormField extends StatelessWidget {
  Color borderSideColor;
  Color fillColor;
  String? hintText;
  TextStyle? hintStyle;
  String? labelText;
  TextStyle? labelStyle;
  Widget? prefixIcon;
  Widget? suffixIcon;
  TextInputType? kerboardType;
  OnValidator validator;
  TextEditingController? controller;
  bool? obscureText;
  String? obscuringCharacter;
  int? maxLines;
  CustomTextFormField ({super.key,this.fillColor=AppColors.darkGreyColor,this.borderSideColor=AppColors.darkGreyColor,
    this.prefixIcon,this.suffixIcon,this.hintText,this.hintStyle,
    this.labelText,this.labelStyle,this.kerboardType,this.validator,
    required this.controller,this.obscureText=false,this.obscuringCharacter,this.maxLines});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: fillColor,
        filled: true,
        enabledBorder: buildOutlineInputBorder(borderSideColor: borderSideColor)
        ,focusedBorder: buildOutlineInputBorder(borderSideColor: borderSideColor)
        ,errorBorder: buildOutlineInputBorder(borderSideColor:AppColors.redColor),
        focusedErrorBorder: buildOutlineInputBorder(borderSideColor: AppColors.redColor),
        errorStyle: AppStyles.regular16Red,
        hintText: hintText,
        hintStyle:hintStyle ?? AppStyles.regular16White ,
        labelText: labelText,
        labelStyle:labelStyle ?? AppStyles.regular16White ,
        prefixIcon:prefixIcon,
        suffixIcon: suffixIcon,
      ),keyboardType: kerboardType,
      validator: validator,
      controller: controller,
      obscureText: obscureText!,
      obscuringCharacter:obscuringCharacter ?? "." ,
      style: TextStyle(
          color:AppColors.whiteColor
      ),maxLines: maxLines ??1,
    );
  }
  OutlineInputBorder buildOutlineInputBorder({ required borderSideColor}){
    return  OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
            color:borderSideColor,
            width: 1.5
        )
    ) ;
  }
}
