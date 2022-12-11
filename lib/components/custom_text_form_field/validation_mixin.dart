import 'package:flutter/material.dart';
import 'package:ninan1/models/bank.dart';
import 'package:ninan1/models/category.dart';
import 'package:ninan1/models/city.dart';
import 'package:ninan1/utils/app_colors.dart';
import 'package:validators/validators.dart';
import 'dart:io';
import 'package:ninan1/components/response_handling/response_handling.dart';

mixin ValidationMixin<T extends StatefulWidget> on State<T> {
  String _password = '';








  // String validateKeySearch(String keySearch) {
  //   if (keySearch.trim().length == 0) {
  //     return ' يرجى إدخال كلمة البحث';
  //   }
  //   return null;
  // }

  // String validateAge(String age) {
  //   if (age.trim().length == 0 || !isNumeric(age)) {
  //     return ' يرجى إدخال العمر';
  //   }
  //   return null;
  // }

  bool checkAddProductValidation(BuildContext context,
      {File imgFile, Category adMainCategory}) {
     if (imgFile == null) {
       showToast("يجب اختيار صورة", context);
      return false;
    }
    if (adMainCategory == null) {
      showToast("يجب اختيار القسم", context);
      return false;
    }
    return true;
  }

  bool checkEditProductValidation(BuildContext context,
      { Category adMainCategory}) {


    if (adMainCategory == null) {
      showToast("يجب اختيار القسم", context);
      return false;
    }
    return true;
  }


  bool checkAddCatValidation(BuildContext context,
      {File imgFile, Category adMainCategory}) {
    if (imgFile == null) {
      showToast("يجب اختيار صورة", context);
      return false;
    }

    return true;
  }




  bool checkAddRequestValidation(BuildContext context,
      {Bank adMainBank}) {
    if (adMainBank == null) {
      showToast("يجب اختيار البنك", context);
      return false;
    }
    return true;
  }







}
