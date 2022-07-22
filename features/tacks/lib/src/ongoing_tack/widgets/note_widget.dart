import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class NoteWidget extends StatelessWidget {
  final String contentKey;

  const NoteWidget({
    super.key,
    required this.contentKey,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text(
        FlutterI18n.translate(
          context,
          contentKey,
        ),
        textAlign: TextAlign.center,
        style: AppTextTheme.manrope13Medium.copyWith(color: AppTheme.hintColor),
      ),
    );
  }
}
