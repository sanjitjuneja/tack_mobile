import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:core/src/managers/haptic_feedback_manager.dart';
import 'package:core/src/managers/toast_manager.dart';

class ClipboardManager {
  static const Duration _hapticFeedbackOnCopyDelay =
      Duration(milliseconds: 250);

  static Future<void> copyText(BuildContext context, String text) async {
    await Clipboard.setData(
      ClipboardData(text: text),
    ).then((_) async {
      return ToastManager.showToast(
        context,
        messageKey: 'toast.copiedToClipboard',
        backgroundColor: AppTheme.toastBackgroundColor,
      );
    });

    return Future.delayed(
      _hapticFeedbackOnCopyDelay,
      HapticFeedbackManager.success,
    );
  }
}
