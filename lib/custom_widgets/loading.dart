import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:zoodtime_admin/utils/app_colors.dart';
import 'package:zoodtime_admin/utils/app_styles.dart';

void showToast(BuildContext context,
    {String msg = '',
      Color backColor = kPrimaryColor,
      int duration = 3}) {
  final screenWidth = MediaQuery.of(context).size.width;

  Flushbar(
    messageText: Center(
      child: Text(
        msg,
        style: AppStyles.blackTextStyle().copyWith(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
    duration: Duration(seconds: duration),
    backgroundColor: backColor,
    borderRadius: BorderRadius.circular(8),
    margin: const EdgeInsets.only(bottom: 20, right: 20),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
    flushbarPosition: FlushbarPosition.BOTTOM,
    flushbarStyle: FlushbarStyle.FLOATING,
    animationDuration: const Duration(milliseconds: 300),
    maxWidth: screenWidth / 2.5,
    forwardAnimationCurve: Curves.easeOutBack,
    reverseAnimationCurve: Curves.easeIn,
    positionOffset: 0,
    isDismissible: true,
  ).show(context);
}
