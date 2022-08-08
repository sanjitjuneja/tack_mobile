import 'package:app_drawer/app_drawer.dart';
import 'package:core/core.dart';
import 'package:core_ui/src/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

const double _kNavBarPersistentHeight = 48;

class AppNavigationBar extends StatelessWidget
    implements ObstructingPreferredSizeWidget {
  final Color? backgroundColor;
  final Widget? middle;
  final String? title;
  final TextStyle titleStyle;
  final Color titleColor;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final bool withResult;
  final bool withMenu;

  AppNavigationBar({
    super.key,
    this.backgroundColor,
    this.middle,
    this.title,
    TextStyle? titleStyle,
    Color? titleColor,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.withResult = false,
    this.withMenu = false,
  })  : titleStyle = titleStyle ?? AppTextTheme.manrope20Medium,
        titleColor = titleColor ?? AppColors.black;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _kNavBarPersistentHeight + MediaQuery.of(context).padding.top,
      color: backgroundColor,
      child: CupertinoNavigationBar(
        backgroundColor: backgroundColor,
        leading: automaticallyImplyLeading
            ? CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  if (withResult) {
                    AppRouter.of(context).popWithResult(null);
                  } else {
                    AppRouter.of(context).pop();
                  }
                },
                child: Row(
                  children: <Widget>[
                    AppIconsTheme.chevronLeft(
                      color: AppTheme.topNavBarInterfaceColor,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      FlutterI18n.translate(context, 'general.back'),
                      style: AppTextTheme.manrope16Regular.copyWith(
                        color: AppTheme.topNavBarInterfaceColor,
                      ),
                    ),
                  ],
                ),
              )
            : null,
        middle: middle ??
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: Text(
                title ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: titleStyle.copyWith(color: titleColor),
              ),
            ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ...?actions,
            if (withMenu) ...<Widget>[
              CupertinoButton(
                padding: const EdgeInsets.symmetric(vertical: 10),
                onPressed: () => _onMenuButtonPressed(context),
                child: AppIconsTheme.menu(
                  color: AppTheme.iconPrimaryColor,
                ),
              ),
            ],
          ],
        ),
        automaticallyImplyLeading: false,
        automaticallyImplyMiddle: false,
        border: null,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(_kNavBarPersistentHeight);

  @override
  bool shouldFullyObstruct(BuildContext context) {
    final Color backgroundColor = this.backgroundColor != null
        ? CupertinoDynamicColor.resolve(this.backgroundColor!, context)
        : CupertinoTheme.of(context).barBackgroundColor;
    return backgroundColor.alpha == 0xFF;
  }

  void _onMenuButtonPressed(BuildContext context) {
    AppRouter.of(context).push(AppDrawer.page());
  }
}
