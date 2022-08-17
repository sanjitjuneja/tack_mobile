import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class OverlayEntryWidget extends StatelessWidget {
  static const Duration _paddingDuration = Duration(milliseconds: 40);

  const OverlayEntryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: AnimatedPadding(
        duration: _paddingDuration,
        padding: EdgeInsets.only(
          bottom: mediaQuery.viewInsets.bottom,
        ),
        child: Container(
          color: CupertinoColors.extraLightBackgroundGray,
          alignment: Alignment.centerRight,
          child: CupertinoButton(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            onPressed: FocusScope.of(context).unfocus,
            child: Text(
              FlutterI18n.translate(context, 'general.done'),
              style: AppTextTheme.manrope16Regular
                  .copyWith(color: CupertinoColors.activeBlue),
            ),
          ),
        ),
      ),
    );
  }
}
