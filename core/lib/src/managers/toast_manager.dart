import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastManager {
  static Future<bool?> showToast(
    BuildContext context, {
    required String messageKey,
    ToastGravity gravity = ToastGravity.TOP,
    Color? backgroundColor,
  }) {
    return Fluttertoast.showToast(
      msg: FlutterI18n.translate(context, messageKey),
      gravity: gravity,
      backgroundColor: backgroundColor,
    );
  }
}
