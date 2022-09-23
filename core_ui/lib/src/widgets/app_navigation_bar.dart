import 'package:app_drawer/app_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:navigation/navigation.dart';

import '../theme/app_theme.dart';
import '../widgets/app_back_button.dart';
import 'opacity_on_tap_container.dart';

const double _kNavBarPersistentHeight = 50;

class AppNavigationBar extends StatelessWidget
    implements ObstructingPreferredSizeWidget {
  final Color? backgroundColor;
  final Widget? middle;
  final Widget? leading;
  final String? title;
  final TextStyle titleStyle;
  final Color titleColor;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final bool withResult;
  final bool withMenu;
  final bool isMenuReachable;
  final bool withTransition;

  AppNavigationBar({
    super.key,
    this.backgroundColor,
    this.middle,
    this.leading,
    this.title,
    TextStyle? titleStyle,
    Color? titleColor,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.withResult = false,
    this.withMenu = false,
    this.isMenuReachable = true,
    this.withTransition = true,
  })  : titleStyle = titleStyle ?? AppTextTheme.manrope20Medium,
        titleColor = titleColor ?? AppColors.black;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: backgroundColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Container(
        height: _kNavBarPersistentHeight + MediaQuery.of(context).padding.top,
        color: backgroundColor,
        child: CupertinoNavigationBar(
          backgroundColor: backgroundColor,
          transitionBetweenRoutes: withTransition,
          leading: leading ??
              (automaticallyImplyLeading
                  ? AppBackButton(
                      onPressed: () {
                        if (withResult) {
                          GlobalAppRouter.of(context).popWithResult(null);
                        } else {
                          GlobalAppRouter.of(context).pop();
                        }
                      },
                    )
                  : null),
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
                OpacityOnTapContainer(
                  onTap: () => _onMenuButtonPressed(context),
                  disable: !isMenuReachable,
                  withFeedback: true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: AppIconsTheme.menu(
                      color: AppTheme.iconPrimaryColor,
                    ),
                  ),
                ),
              ],
            ],
          ),
          automaticallyImplyLeading: false,
          automaticallyImplyMiddle: false,
          border: null,
        ),
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
