import 'package:flutter/cupertino.dart';

class KeyboardUtility {
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
