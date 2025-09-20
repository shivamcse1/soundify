import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:soundify/core/theme/app_colors.dart';

class UiHelper {
  /// This is ui toast
  static Future<void> showToast({
    required String msg,
    Color textColor = AppColors.primary,
    Color bgColor = AppColors.grey,
  }) async {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: bgColor,
      textColor: textColor,
      fontSize: 15.0,
    );
  }
}
