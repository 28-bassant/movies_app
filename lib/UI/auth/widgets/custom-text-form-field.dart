
import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
typedef OnValidator = String? Function(String?)?;
class CustomTextFormField extends StatelessWidget {
  final Color borderSideColor;
  final Color fillColor;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? labelText;
  final TextStyle? labelStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final OnValidator validator;
  final TextEditingController? controller;
  final bool? obscureText;
  final String? obscuringCharacter;
  final int? maxLines;
  final Function(String)? onChanged;

  CustomTextFormField({
    super.key,
    this.fillColor = AppColors.darkGreyColor,
    this.borderSideColor = AppColors.darkGreyColor,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.hintStyle,
    this.labelText,
    this.labelStyle,
    this.keyboardType,
    this.validator,
    required this.controller,
    this.obscureText = false,
    this.obscuringCharacter,
    this.maxLines,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: fillColor,
        filled: true,
        enabledBorder: buildOutlineInputBorder(borderSideColor: borderSideColor),
        focusedBorder: buildOutlineInputBorder(borderSideColor: borderSideColor),
        errorBorder: buildOutlineInputBorder(borderSideColor: AppColors.redColor),
        focusedErrorBorder: buildOutlineInputBorder(borderSideColor: AppColors.redColor),
        errorStyle: AppStyles.regular16Red,
        hintText: hintText,
        hintStyle: hintStyle ?? AppStyles.regular16White,
        labelText: labelText,
        labelStyle: labelStyle ?? AppStyles.regular16White,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      keyboardType: keyboardType,
      validator: validator,
      controller: controller,
      obscureText: obscureText!,
      obscuringCharacter: obscuringCharacter ?? ".",
      style: const TextStyle(color: AppColors.whiteColor),
      maxLines: maxLines ?? 1,
      onChanged: onChanged,
    );
  }

  OutlineInputBorder buildOutlineInputBorder({required Color borderSideColor}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: borderSideColor,
        width: 1.5,
      ),
    );
  }
}
