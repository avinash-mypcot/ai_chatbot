import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/textstyles.dart';

class SigninTextfield extends StatelessWidget {
  const SigninTextfield(
      {super.key,
      required TextEditingController nameController,
      required String textHint,
      required this.validation})
      : _nameController = nameController,
        _textHint = textHint;

  final TextEditingController _nameController;
  final String _textHint;
  final FormFieldValidator validation;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validation,
      controller: _nameController,
      cursorColor: AppColors.kColorWhite,
      cursorHeight: 16.h,
      style: kTextStylePoppins300.copyWith(color: AppColors.kColorGrey),
      decoration: InputDecoration(
          focusColor: AppColors.kColorWhite,
          hintText: _textHint,
          hintStyle: kTextStylePoppins300.copyWith(color: AppColors.kColorGrey),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.kColorWhite)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.kColorWhite))),
    );
  }
}
