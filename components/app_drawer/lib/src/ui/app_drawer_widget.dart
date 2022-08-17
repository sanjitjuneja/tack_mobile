import 'package:app_drawer/src/bloc/app_drawer_bloc.dart';
import 'package:app_drawer/src/models/go_to_option.dart';
import 'package:app_drawer/src/ui/widgets/app_drawer_header.dart';
import 'package:app_drawer/src/ui/widgets/app_drawer_tile_widget.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'widgets/app_drawer_scroll_container.dart';

class AppDrawerWidget extends StatelessWidget {
  const AppDrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = List<Widget>.from(
      GoToOption.values.map(
        (GoToOption option) {
          return SideBarTileWidget(
            titleKey: option.titleKey,
            onPressed: () => _onOptionPressed(context, option),
          );
        },
      ),
    );
    children.add(
      SideBarTileWidget(
        titleKey: 'drawer.logOut',
        leadingIcon: AppIconsTheme.logout,
        interfaceColor: AppTheme.errorColor,
        isNeedChevron: false,
        onPressed: () => _onLogOutPressed(context),
      ),
    );
    children.insert(4, const AppDivider(height: 2));
    children.insert(8, const AppDivider(height: 2));

    return ColoredBox(
      color: AppTheme.primaryColor,
      child: Column(
        children: <Widget>[
          const AppDrawerHeader(),
          Expanded(
            child: AppDrawerScrollContainer(
              children: <Widget>[
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  itemBuilder: (_, int index) => children[index],
                  separatorBuilder: (_, __) => const SizedBox(height: 18),
                  itemCount: children.length,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextWithHighlight(
                    text: FlutterI18n.translate(context, 'drawer.note'),
                    textStyle: AppTextTheme.manrope13Medium.copyWith(
                      color: AppTheme.grassColor,
                    ),
                    textAlign: TextAlign.center,
                    onLinkTap: (String? url) => _onLinkTap(context, url),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onOptionPressed(
    BuildContext context,
    GoToOption option,
  ) {
    BlocProvider.of<AppDrawerBloc>(context).add(
      GoTo(context, option),
    );
  }

  void _onLogOutPressed(BuildContext context) {
    BlocProvider.of<AppDrawerBloc>(context).add(const LogOut());
  }

  void _onLinkTap(BuildContext context, String? url) {
    UrlManager.openUrl(context, url);
  }
}
