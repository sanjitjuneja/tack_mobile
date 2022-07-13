import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

class ImagePickOptionDrawer {
  static const String routeName = '/imagePickOptionDrawer';

  static Page<ImageSource?> page() => const _ImagePickOptionDrawerPage();
}

class _ImagePickOptionDrawerPage extends Page<ImageSource?> {
  @override
  String get name => ImagePickOptionDrawer.routeName;

  const _ImagePickOptionDrawerPage();

  @override
  Route<ImageSource?> createRoute(BuildContext context) {
    return CupertinoModalPopupRoute<ImageSource?>(
      settings: this,
      barrierColor: AppTheme.barrierColor,
      barrierDismissible: true,
      builder: (_) => Material(
        type: MaterialType.transparency,
        child: CupertinoActionSheet(
          actions: <Widget>[
            CupertinoButton(
              color: AppTheme.primaryColor,
              onPressed: () => AppRouter.of(context).popWithResult(
                ImageSource.camera,
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                FlutterI18n.translate(
                  context,
                  'imagePickOptionsDrawer.pickPhoto',
                ),
                style: AppTextTheme.poppins14Medium.copyWith(
                  color: AppTheme.textPrimaryColor,
                ),
              ),
            ),
            CupertinoButton(
              color: AppTheme.primaryColor,
              onPressed: () => AppRouter.of(context).popWithResult(
                ImageSource.gallery,
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                FlutterI18n.translate(
                  context,
                  'imagePickOptionsDrawer.choosePhoto',
                ),
                style: AppTextTheme.poppins14Medium.copyWith(
                  color: AppTheme.textPrimaryColor,
                ),
              ),
            ),
          ],
          cancelButton: CupertinoButton(
            onPressed: () => AppRouter.of(context).popWithResult(null),
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              FlutterI18n.translate(context, 'general.cancel'),
              style: AppTextTheme.poppins14Medium.copyWith(
                color: AppTheme.textPrimaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
